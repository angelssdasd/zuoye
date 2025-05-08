package com.example.entity;

import java.time.LocalDateTime;

/**
 * 审核员实体类（对应数据库 reviewer 表）
 */
public class Reviewer extends Account {

    /** 用户ID(主键) */
    private Integer id;

    /** 用户名 */
    private String username;

    /** 密码（需加密存储） */
    private String password;

    /** 邮箱 */
    private String email;

    /** 注册时间，默认 CURRENT_TIMESTAMP */
    private LocalDateTime registerTime;

    /** 用户角色（固定为“审核员”） */
    private String role;

    /** 权限状态（正常/受限） */
    private String permissionStatus;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDateTime getRegisterTime() {
        return registerTime;
    }

    public void setRegisterTime(LocalDateTime registerTime) {
        this.registerTime = registerTime;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPermissionStatus() {
        return permissionStatus;
    }

    public void setPermissionStatus(String permissionStatus) {
        this.permissionStatus = permissionStatus;
    }
}