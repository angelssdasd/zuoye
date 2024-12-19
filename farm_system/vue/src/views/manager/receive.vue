<template>
    <div>
      <div class="card" style="margin-bottom: 5px;">
        <el-input v-model="data.name" style="width: 300px; margin-right: 10px" placeholder="请输入名称查询"></el-input>
        <el-button type="primary" @click="load">查询</el-button>
        <el-button type="info" style="margin: 0 10px" @click="reset">重置</el-button>
      </div>
  
      <div class="card" style="margin-bottom: 5px">
        <el-table :data="data.tableData" stripe>
          <el-table-column label="商品" prop="goodsName"></el-table-column>
          <el-table-column label="进货数量" prop="num"></el-table-column>
          <el-table-column label="进货渠道" prop="channel"></el-table-column>
          <el-table-column label="备注" prop="comment"></el-table-column>
          <el-table-column label="到货时间" prop="deliveryTime"></el-table-column>
          <el-table-column label="订单总价" prop="singlePrice"></el-table-column>
          <el-table-column label="收货员工名称" prop="receiveName"></el-table-column>
        </el-table>
      </div>
    </div>
  </template>
  
  <script setup>
  import request from "@/utils/request";
  import { reactive } from "vue";
  import { ElMessage } from "element-plus";
  
  const data = reactive({
    pageNum: 1,
    pageSize: 10,
    total: 0,
    tableData: [],
    name: null
  });
  
  // 分页查询
  const load = () => {
    console.log('当前查询名称:', data.name); // 添加日志记录
    request.get('/receiveStock/selectPage', {
      params: {
        pageNum: data.pageNum,
        pageSize: data.pageSize,
        goodsName: data.name
      }
    }).then(res => {
      console.log('返回的数据:', res.data);
      console.log('数据是什么', data.name);
      data.tableData = res.data?.list || [];
      data.total = res.data?.total || 0;
    }).catch(err => {
      ElMessage.error('查询失败，请稍后重试');
      console.error('查询失败:', err);
    });
  }
  
  // 重置
  const reset = () => {
    data.name = null;
    console.log('重置后的名称:', data.name); // 添加日志记录
    load();
  }
  
  // 页面加载时执行查询
  load();
  </script>
  
  <style scoped>
  .card {
    margin-bottom: 10px;
  }
  </style>