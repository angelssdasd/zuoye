package com.example.service;

import cn.hutool.core.util.ObjectUtil;
import com.example.entity.Account;
import com.example.entity.Log;
import com.example.exception.CustomException;
import com.example.mapper.LogMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 管理员业务处理
 **/
@Service
public class LogService {

    @Resource
    private LogMapper LogMapper;

    /**
     * 新增
     */
    public void add(Log admin) {

        LogMapper.insert(admin);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        LogMapper.deleteById(id);
    }


    /**
     * 根据ID查询
     */
    public Log selectById(Integer id) {
        return LogMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Log> selectAll(Log admin) {
        return LogMapper.selectAll(admin);
    }

    /**
     * 分页查询
     */
    public PageInfo<Log> selectPage(Log admin, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Log> list = LogMapper.selectAll(admin);
        return PageInfo.of(list);
    }


}