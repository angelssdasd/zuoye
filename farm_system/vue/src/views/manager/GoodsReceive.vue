<template>
  <div>

    <div class="card" style="margin-bottom: 5px;">
      <el-input v-model="data.goodsName" style="width: 300px; margin-right: 10px" placeholder="请输入农产品名称查询"></el-input>
      <el-button type="primary" @click="load">查询</el-button>
      <el-button type="info" style="margin: 0 10px" @click="reset">重置</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table :data="data.tableData" stripe>
        <el-table-column label="农产品名称" prop="goodsName"></el-table-column>
        <el-table-column label="进货数量" prop="num"></el-table-column>
        <el-table-column label="进货渠道" prop="channel"></el-table-column>
        <el-table-column label="进货日期" prop="date"></el-table-column>
        <el-table-column label="备注" prop="comment"></el-table-column>
        <el-table-column label="操作" header-align="center" width="160">
          <template #default="scope">
           
            <el-button type="primary" @click="receiveDelete(scope.row.id)">进货</el-button>
            <el-button type="danger" @click="handleDelete(scope.row.id)">退货</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div class="card" v-if="data.total">
      <el-pagination @current-change="load" background layout="prev, pager, next" v-model:page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total"/>
    </div>

  </div>
</template>

<script setup>
import request from "@/utils/request";
import {reactive,ref,onMounted} from "vue";
import {ElMessageBox, ElMessage} from "element-plus";

const data = reactive({
  pageNum: 1,
  pageSize: 10,
  total: 0,
  formVisible: false,
  form: {},
  tableData: [],
  goodsName: null,
  goodsList: []
})

let str1 = "Hello World!";
request.get('/goods/selectAll').then(res => {
  data.goodsList = res.data
})

// 分页查询
const load = () => {
  request.get('/goodsStock/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      goodsName: data.goodsName
    }
  }).then(res => {
   
    data.tableData = res.data?.list
    data.total = res.data?.total
  })
}

// 新增
const handleAdd = () => {
  data.form = {}
  data.formVisible = true
}

// 编辑
const handleEdit = (row) => {
  data.form = JSON.parse(JSON.stringify(row))
  data.formVisible = true
}
onMounted(() => {
  const user1 = localStorage.getItem('system-user');
  if (user1) {
    const parsedUser = JSON.parse(user1);
    str1 = parsedUser.name;
  }
});
//收货
/* const receiveDelete = (id,userName) => {
  ElMessageBox.confirm('确定收货吗', { type: 'warning' }).then(res => {
    request.delete('/goodsStock/receive/' + id).then(res => {
      if (res.code === '200') {
        load()
        ElMessage.success('操作成功')
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(err => {})
} */
const receiveDelete = (id) => {
  ElMessageBox.confirm('确定收货吗', { type: 'warning' }).then(() => {
    request.delete('/goodsStock/receive/' + id, {
      params: {
        receiveName: str1
      }
    }).then(res => {
      if (res.code === '200') {
        load();
        ElMessage.success('操作成功');
      } else {
        ElMessage.error(res.msg);
      }
    }).catch(err => {
      ElMessage.error('操作失败');
    });
  }).catch(err => {
    // 用户取消了确认对话框
  });
};

// 编辑保存
const update = () => {
  request.put('/goodsStock/update', data.form).then(res => {
    if (res.code === '200') {
      load()
      ElMessage.success('操作成功')
      data.formVisible = false
    } else {
      ElMessage.error(res.msg)
    }
  })
}

// 弹窗保存
const save = () => {
  // data.form有id就是更新，没有就是新增
  data.form.id ? update() : add()
}

// 删除
const handleDelete = (id) => {
  ElMessageBox.confirm('确定要退货吗', { type: 'warning' }).then(res => {
    request.delete('/goodsStock/delete/' + id).then(res => {
      if (res.code === '200') {
        load()
        ElMessage.success('操作成功')
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(err => {})
}

// 重置
const reset = () => {
  data.goodsName = null
  load()
}

load()
</script>