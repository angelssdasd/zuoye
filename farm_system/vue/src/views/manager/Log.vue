<template>
  <div>
    <div class="card" style="margin-bottom: 10px;">
      <el-input v-model="data.searchParams.operationType" style="width: 300px; margin-right: 10px" placeholder="请输入操作类型查询 (例如: 增, 删, 改)"></el-input>
      <el-button type="primary" @click="loadLogs">查询</el-button>
      <el-button type="info" style="margin: 0 10px" @click="resetSearch">重置</el-button>
    </div>

    <div class="card" style="margin-bottom: 10px">
      <el-table :data="data.logTableData" stripe style="width: 100%">
        <el-table-column label="日志ID" prop="logId" width="100" sortable></el-table-column>
        <el-table-column label="操作类型" prop="operationType" width="120"></el-table-column>
        <el-table-column label="操作详情" prop="operationDetail" show-overflow-tooltip></el-table-column>
        <el-table-column label="操作时间" prop="operationTime" width="200" sortable>
          <template #default="scope">
            {{ formatDateTime(scope.row.operationTime) }}
          </template>
        </el-table-column>
        <el-table-column label="操作用户ID" prop="operatorId" width="120" sortable></el-table-column>
        <el-table-column label="操作" header-align="center" align="center" width="100">
          <template #default="scope">
            <el-button type="danger" size="small" @click="handleDeleteLog(scope.row.logId)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div class="card" v-if="data.totalLogs > 0">
      <el-pagination
          @current-change="handlePageChange"
          background
          layout="prev, pager, next, total"
          v-model:current-page="data.searchParams.pageNum"
          :page-size="data.searchParams.pageSize"
          :total="data.totalLogs"
      />
    </div>
  </div>
</template>

<script setup>
import request from "@/utils/request"; // 确保您的request工具路径正确
import { reactive, onMounted } from "vue";
import { ElMessageBox, ElMessage } from "element-plus";

// 响应式数据对象
const data = reactive({
  logTableData: [],      // 日志表格数据
  totalLogs: 0,          // 日志总条数
  searchParams: {        // 查询参数
    pageNum: 1,          // 当前页码
    pageSize: 10,        // 每页显示条数
    operationType: null, // 操作类型，用于搜索
    // operatorId: null, // 如果需要按操作用户ID搜索，可以添加此项
  },
});

// 日期时间格式化函数 (如果后端返回的是标准ISO字符串或时间戳)
const formatDateTime = (dateTimeStr) => {
  if (!dateTimeStr) return '';
  // 假设后端返回的 operationTime 是可以直接被 new Date() 解析的格式
  // 或者您可能需要根据后端返回的实际格式进行调整
  const date = new Date(dateTimeStr);
  if (isNaN(date.getTime())) { // 无效日期检查
    return dateTimeStr; // 返回原始字符串如果不可解析
  }
  // 返回 yyyy-MM-dd HH:mm:ss 格式
  const year = date.getFullYear();
  const month = (date.getMonth() + 1).toString().padStart(2, '0');
  const day = date.getDate().toString().padStart(2, '0');
  const hours = date.getHours().toString().padStart(2, '0');
  const minutes = date.getMinutes().toString().padStart(2, '0');
  const seconds = date.getSeconds().toString().padStart(2, '0');
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
};


// 加载日志数据的方法
const loadLogs = () => {
  request.get('/log/selectPage', { // 参考 LogController 中的 @GetMapping("/selectPage")
    params: data.searchParams
  }).then(res => {
    if (res.code === '200' && res.data) {
      data.logTableData = res.data.list || []; // 后端分页数据在 res.data.list
      data.totalLogs = res.data.total || 0;   // 后端总条数在 res.data.total
    } else {
      ElMessage.error(res.msg || '日志数据加载失败');
      data.logTableData = [];
      data.totalLogs = 0;
    }
  }).catch(err => {
    ElMessage.error('请求失败: ' + (err.message || '网络错误'));
    data.logTableData = [];
    data.totalLogs = 0;
  });
}

// 处理页码变化
const handlePageChange = (newPageNum) => {
  data.searchParams.pageNum = newPageNum;
  loadLogs();
}

// 重置搜索条件
const resetSearch = () => {
  data.searchParams.operationType = null;
  // data.searchParams.operatorId = null; // 如果添加了操作用户ID搜索
  data.searchParams.pageNum = 1; // 重置到第一页
  loadLogs();
}

// 处理删除日志
const handleDeleteLog = (logId) => {
  ElMessageBox.confirm('您确定要删除这条日志吗? 删除后无法恢复。', '删除确认', {
    confirmButtonText: '确定删除',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    request.delete(`/log/delete/${logId}`) // 参考 LogController 中的 @DeleteMapping("/delete/{id}")
        .then(res => {
          if (res.code === '200') {
            ElMessage.success('日志删除成功');
            loadLogs(); // 重新加载数据
          } else {
            ElMessage.error(res.msg || '删除失败');
          }
        }).catch(err => {
      ElMessage.error('请求失败: ' + (err.message || '网络错误'));
    });
  }).catch(() => {
    // 用户点击取消
    ElMessage.info('已取消删除');
  });
}

// 组件挂载时加载初始数据
onMounted(() => {
  loadLogs();
});
</script>

<style scoped>
.card {
  padding: 15px;
  background-color: #fff;
  border-radius: 5px;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
}
/* 可以根据需要添加更多样式 */
</style>
