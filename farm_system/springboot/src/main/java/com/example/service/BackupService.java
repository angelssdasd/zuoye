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
    public List<Backup>selectByCondition(Backup backup) {
        return backupMapper.selectByCondition(backup.getOperatorId());
    }
}
