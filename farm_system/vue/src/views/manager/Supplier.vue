
<template>
  <div>
    <div class="card" style="margin-bottom: 5px;">
      <el-input v-model="data.supplierName" style="width: 300px; margin-right: 10px" placeholder="请输入供应商名称查询"></el-input>
      <el-button type="primary" @click="load">查询</el-button>
      <el-button type="info" style="margin: 0 10px" @click="reset">重置</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <div style="margin-bottom: 10px">
        <el-button type="primary" @click="handleAdd">新增</el-button>
      </div>
      <el-table :data="data.tableData" stripe>
        <el-table-column label="供应商名" prop="supplierName"></el-table-column>
        <el-table-column label="类别" prop="category"></el-table-column>
        <el-table-column label="地址" prop="address"></el-table-column>
        <el-table-column label="法人代表" prop="legalRepresentative"></el-table-column>
        <el-table-column label="联系人" prop="contactPerson"></el-table-column>
        <el-table-column label="联系电话" prop="contactPhone"></el-table-column>
        <el-table-column label="传真号码" prop="faxNumber"></el-table-column>
        <el-table-column label="电子邮件" prop="email"></el-table-column>
        <el-table-column label="备注" prop="remarks"></el-table-column>
        <el-table-column label="操作" header-align="center" width="160">
          <template #default="scope">
            <el-button type="primary" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button type="danger" @click="handleDelete(scope.row.supplierID)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <div class="card" v-if="data.total">
      <el-pagination @current-change="load" background layout="prev, pager, next" v-model:page-size="data.pageSize" v-model:current-page="data.pageNum" :total="data.total"/>
    </div>

    <el-dialog title="供应商信息" width="40%" v-model="data.formVisible" :close-on-click-modal="false" destroy-on-close >
      <el-form :model="data.form" label-width="100px" style="padding-right: 50px">
        <el-form-item label="供应商名" prop="supplierName">
          <el-input v-model="data.form.supplierName" autocomplete="off" />
        </el-form-item>
        <el-form-item label="类别" prop="category">
          <el-input v-model="data.form.category" autocomplete="off" />
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="data.form.address" autocomplete="off" />
        </el-form-item>
        <el-form-item label="法人代表" prop="legalRepresentative">
          <el-input v-model="data.form.legalRepresentative" autocomplete="off" />
        </el-form-item>
        <el-form-item label="联系人" prop="contactPerson">
          <el-input v-model="data.form.contactPerson" autocomplete="off" />
        </el-form-item>
        <el-form-item label="联系电话" prop="contactPhone">
          <el-input v-model="data.form.contactPhone" autocomplete="off" />
        </el-form-item>
        <el-form-item label="传真号码" prop="faxNumber">
          <el-input v-model="data.form.faxNumber" autocomplete="off" />
        </el-form-item>
        <el-form-item label="电子邮件" prop="email">
          <el-input v-model="data.form.email" autocomplete="off" />
        </el-form-item>
        <el-form-item label="备注" prop="remarks">
          <el-input v-model="data.form.remarks" type="textarea" autocomplete="off" />
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
  supplierName: null
})

// 分页查询
const load = () => {
  request.get('/supplier/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      supplierName: data.supplierName
    }
  }).then(res => {
    console.log(res.data?.list);  // 打印返回的数据，检查是否包含 suppliersupplierName
    data.tableData = res.data?.list
    data.total = res.data?.total
  })
}

// 新增
const handleAdd = () => {
  data.form = {};
  data.formVisible = true;
}

// 编辑
const handleEdit = (row) => {
  data.form = JSON.parse(JSON.stringify(row));
  data.formVisible = true;
}

// 新增保存
const add = () => {
  request.post('/supplier/add', data.form).then(res => {
    if (res.code === '200') {
      load();
      ElMessage.success('操作成功');
      data.formVisible = false;
    } else {
      ElMessage.error(res.msg);
    }
  });
}

// 编辑保存
const update = () => {
  request.put('/supplier/update', data.form).then(res => {
    if (res.code === '200') {
      load();
      ElMessage.success('操作成功');
      data.formVisible = false;
    } else {
      ElMessage.error(res.msg);
    }
  });
}

// 弹窗保存
const save = () => {
  // 如果form有supplierID就是更新，没有就是新增
  data.form.supplierID ? update() : add();
}

// 删除
const handleDelete = (id) => {
  ElMessageBox.confirm('删除后数据无法恢复，您确定删除吗?', '删除确认', { type: 'warning' }).then(() => {
    request.delete(`/supplier/delete/${id}`).then(res => {
      if (res.code === '200') {
        load();
        ElMessage.success('操作成功');
      } else {
        ElMessage.error(res.msg);
      }
    });
  }).catch(err => {});
}

// 重置
const reset = () => {
  data.supplierName = null;
  load();
}

// 初始化加载数据
load();
</script>