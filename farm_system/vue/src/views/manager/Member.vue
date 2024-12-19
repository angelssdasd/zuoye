<template>
  <div>

    <!-- 查询区域 -->
    <div class="card" style="margin-bottom: 5px;">
      <el-input v-model="data.memberName" style="width: 300px; margin-right: 10px" placeholder="请输入会员姓名查询"></el-input>
      <el-button type="primary" @click="load">查询</el-button>
      <el-button type="info" style="margin: 0 10px" @click="reset">重置</el-button>
    </div>

    <!-- 表格及操作按钮 -->
    <div class="card" style="margin-bottom: 5px">
      <div style="margin-bottom: 10px">
        <el-button type="primary" @click="handleAdd">新增</el-button>
      </div>
      <el-table :data="data.tableData" stripe>
        <el-table-column label="会员姓名" prop="memberName"></el-table-column>
        <el-table-column label="性别" prop="gender"></el-table-column>
        <el-table-column label="出生日期" prop="birthDate"></el-table-column>
        <el-table-column label="联系方式" prop="phoneNumber"></el-table-column>
        <el-table-column label="职业" prop="occupation"></el-table-column>
        <el-table-column label="身份证号" prop="idNumber"></el-table-column>
       <!--  <el-table-column label="加入时间" prop="joinTime"></el-table-column> -->
        <el-table-column label="操作" header-align="center" width="160">
          <template #default="scope">
            <el-button type="primary" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button type="danger" @click="handleDelete(scope.row.id)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 分页组件 -->
    <div class="card" v-if="data.total">
      <el-pagination @current-change="load" background layout="prev, pager, next" v-model:page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total"/>
    </div>

    <!-- 对话框 - 新增/编辑 -->
    <el-dialog title="会员信息" width="40%" v-model="data.formVisible" :close-on-click-modal="false" destroy-on-close>
      <el-form :model="data.form" label-width="100px" style="padding-right: 50px">
        <el-form-item label="会员姓名">
          <el-input v-model="data.form.memberName" placeholder="请输入会员姓名"></el-input>
        </el-form-item>
        <el-form-item label="性别">
          <el-select v-model="data.form.gender" placeholder="请选择性别" style="width: 100%">
            <el-option value="M" label="男"></el-option>
            <el-option value="F" label="女"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="出生日期">
          <el-date-picker style="width: 100%" type="date" v-model="data.form.birthDate" placeholder="请选择出生日期" format="YYYY-MM-DD" value-format="YYYY-MM-DD"></el-date-picker>
        </el-form-item>
        <el-form-item label="联系方式">
          <el-input v-model="data.form.phoneNumber" placeholder="请输入联系方式"></el-input>
        </el-form-item>
        <el-form-item label="职业">
          <el-input v-model="data.form.occupation" placeholder="请输入职业"></el-input>
        </el-form-item>
        <el-form-item label="身份证号">
          <el-input v-model="data.form.idNumber" placeholder="请输入身份证号"></el-input>
        </el-form-item>
       <el-form-item label="加入时间">
          <el-date-picker style="width: 100%" type="date" v-model="data.form.joinTime" placeholder="请选择加入时间" format="YYYY-MM-DD" value-format="YYYY-MM-DD" ></el-date-picker>
        </el-form-item> 
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="data.formVisible = false">取 消</el-button>
          <el-button type="primary" @click="save">保 存</el-button>
        </span>
      </template>
    </el-dialog>

  </div>
</template>

<script setup>
import request from "@/utils/request";
import {reactive} from "vue";
import {ElMessageBox, ElMessage} from "element-plus";

const data = reactive({
  pageNum: 1,
  pageSize: 10,
  total: 0,
  formVisible: false,
  form: {},
  tableData: [],
  memberName: null,
})

// 加载数据
const load = () => {
  request.get('/members/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      memberName: data.memberName
    }
  }).then(res => {
    data.tableData = res.data?.list || [];
    data.total = res.data?.total || 0;
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

// 保存（新增或更新）
const save = () => {
  if (data.form.id) {
    // 更新
    update()
  } else {
    // 新增
    add()
  }
}

// 新增
const add = () => {
  request.post('/members/add', data.form).then(res => {
    if (res.code === '200') {
      load()
      ElMessage.success('操作成功')
      data.formVisible = false
    } else {
      ElMessage.error(res.msg)
    }
  })
}

// 更新
const update = () => {
  request.put('/members/update', data.form).then(res => {
    if (res.code === '200') {
      load()
      ElMessage.success('操作成功')
      data.formVisible = false
    } else {
      ElMessage.error(res.msg)
    }
  })
}

// 删除
const handleDelete = (id) => {
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗?', '删除确认', { type: 'warning' }).then(() => {
    request.delete(`/members/delete/${id}`).then(res => {
      if (res.code === '200') {
        load()
        ElMessage.success('操作成功')
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(err => {})
}

// 重置查询条件
const reset = () => {
  data.memberName = null
  load()
}

// 初始化加载数据
load()
</script>