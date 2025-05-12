<template>
  <div>
    <div class="card" style="margin-bottom: 5px;">
      <el-input v-model="data.operatorId" placeholder="操作员ID查询" style="width: 300px; margin-right: 10px" />
      <el-button type="primary" @click="load">查询</el-button>
      <el-button type="info" @click="reset">重置</el-button>
    </div>

    <div class="card">
      <el-table :data="data.tableData" stripe>
        <el-table-column prop="backupId" label="ID" />
        <el-table-column prop="backupTime" label="时间" />
        <el-table-column prop="filePath" label="路径" />
        <el-table-column prop="operatorId" label="操作员ID" />
        <el-table-column label="操作">
          <template #default="scope">
            <el-button type="danger" @click="handleDelete(scope.row.backupId)">还原到此状态</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div class="card" v-if="data.total">
      <el-pagination
        @current-change="load"
        background
        layout="prev, pager, next"
        v-model:page-size="data.pageSize"
        v-model:current-page="data.pageNum"
        :total="data.total"
      />
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'
import request from '@/utils/request'
import { ElMessageBox, ElMessage } from 'element-plus'

const data = reactive({
  tableData: [],
  total: 0,
  pageNum: 1,
  pageSize: 10,
  operatorId: null,
})

const load = () => {
  request.get('/backup/selectPage', {
    params: {
      operatorId: data.operatorId,
      pageNum: data.pageNum,
      pageSize: data.pageSize
    }
  }).then(res => {
    data.tableData = res.data?.list || []
    data.total = res.data?.total || 0
  })
}

const handleDelete = (id) => {
  ElMessageBox.confirm('确认恢复到此状态？', '警告', { type: 'warning' }).then(() => {
    request.delete(`/backup/delete/${id}`).then(res => {
      if (res.code === '200') {
        ElMessage.success('执行成功')
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  })
}

const reset = () => {
  data.operatorId = null
  load()
}

load()
</script>
