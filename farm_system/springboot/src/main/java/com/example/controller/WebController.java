package com.example.controller;

import com.example.common.LogAOP;
import com.example.common.Result;
import com.example.entity.Account;
import com.example.entity.User;
import com.example.service.AdminService;
import com.example.service.ReviewerService;
import com.example.service.UserService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;


@RestController
public class WebController {

    @Resource
    private AdminService adminService;
    @Resource
    private UserService userService;
    @Resource
    private UserService ReviewerService;


    /**
     * 默认请求接口
     */
    @GetMapping("/")
    public Result hello() {
        return Result.success();
    }

    /**
     * 登录
     */
    @PostMapping("/login")
    //@LogAOP(title = "登录", content = "用户登录")
    public Result login(@RequestBody Account account) {
        Account ac = null;
        if ("管理员".equals(account.getRole())) {
            ac = adminService.login(account);
        } else {
            ac = ReviewerService.login(account);
             ac.setId(1);
            ac.setRole("USER");
        }
        return Result.success(ac);
    }

    /**
     * 注册
     */
    @PostMapping("/register")
    //@LogAOP(title = "注册", content = "用户注册")
    public Result register(@RequestBody User user) {
        userService.register(user);
        return Result.success();
    }

    /**
     * 修改密码
     */
    @PutMapping("/updatePassword")
    public Result updatePassword(@RequestBody Account account) {
        if ("ADMIN".equals(account.getRole())) {
            adminService.updatePassword(account);
        } else {
            userService.updatePassword(account);
        }
        return Result.success();
    }

}
