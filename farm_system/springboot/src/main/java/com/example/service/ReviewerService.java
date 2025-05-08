package com.example.service;

import cn.hutool.core.util.ObjectUtil;
import com.example.entity.Account;
import com.example.entity.Reviewer;
import com.example.entity.User;
import com.example.exception.CustomException;
import com.example.mapper.ReviewerMapper;
import com.example.mapper.UserMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import com.example.entity.Account;

import java.util.List;

/**
 * 用户的业务处理
 **/
@Service
public class ReviewerService {

    @Resource
    private ReviewerMapper reviewerMapper;



    /**
     * 登录
     */
    public Account login(Account account) {
        Account dbUser = reviewerMapper.selectByUsername(account.getUsername());
        if (ObjectUtil.isNull(dbUser)) {
            throw new CustomException("用户不存在");
        }
        if (!account.getPassword().equals(dbUser.getPassword())) {
            throw new CustomException("账号或密码错误");
        }
        return dbUser;
    }

}