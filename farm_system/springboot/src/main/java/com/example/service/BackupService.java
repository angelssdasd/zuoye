package com.example.service;

import com.example.entity.Backup;
import com.example.mapper.BackupMapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BackupService {
    @Resource
    private BackupMapper backupMapper;
    public void restore(String backupIds) {}

// 根据条件查询Backup列表
    public List<Backup>selectByCondition(Backup backup) {
        // 调用backupMapper的selectByCondition方法，传入backup的operatorId参数
        return backupMapper.selectByCondition(backup.getOperatorId());
    }

    public String getFilePath(Integer backupId) {
        return backupMapper.getFilePath(backupId);
    }
}
