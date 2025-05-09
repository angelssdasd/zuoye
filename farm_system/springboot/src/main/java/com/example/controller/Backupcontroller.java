package com.example.controller;

import com.example.entity.Backup;
import com.example.mapper.BackupMapper;
import com.example.common.Result;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
@RestController
@RequestMapping("/backup")
public class Backupcontroller {

    @Autowired
    private BackupMapper backupMapper;

    @GetMapping("/selectPage")
    public Result selectPage(Backup backup,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Backup> list = backupMapper.selectByCondition(backup.getOperatorId());
        return Result.success(new PageInfo<>(list));
    }

    @PostMapping("/add")
    public Result add(@RequestBody Backup backup) {
        backupMapper.insert(backup);
        return Result.success();
    }

    @DeleteMapping("/delete/{id}")
    public Result delete(@PathVariable Integer id) {
        backupMapper.deleteById(id);
        return Result.success();
    }
}
