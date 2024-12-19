package com.example.controller;

import com.example.common.Result;
import com.example.entity.Member;
import com.example.service.MemberService;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 前端操作接口
 **/
@RestController
@RequestMapping("/members")
public class MemberController {

    @Resource
    private MemberService memberService;

    /**
     * 新增
     */
    @PostMapping("/add")
    public Result add(@RequestBody Member member) {
        memberService.add(member);
        return Result.success();
    }

    /**
     * 删除
     */
    @DeleteMapping("/delete/{id}")
    public Result deleteById(@PathVariable Integer id) {
        memberService.deleteById(id);
        return Result.success();
    }

    /**
     * 修改
     */
    @PutMapping("/update")
    public Result updateById(@RequestBody Member member) {
        memberService.updateById(member);
        return Result.success();
    }

    /**
     * 根据ID查询
     */
    @GetMapping("/selectById/{id}")
    public Result selectById(@PathVariable Integer id) {
        Member member = memberService.selectById(id);
        return Result.success(member);
    }

    /**
     * 查询所有
     */
    @GetMapping("/selectAll")
    public Result selectAll(Member member) {
        List<Member> list = memberService.selectAll();
        return Result.success(list);
    }

    /**
     * 分页查询
     */
    @GetMapping("/selectPage")
    public Result selectPage(Member member,
                             @RequestParam(defaultValue = "1") Integer pageNum,
                             @RequestParam(defaultValue = "10") Integer pageSize) {
        PageInfo<Member> page = memberService.selectPage( pageNum, pageSize);
        return Result.success(page);
    }

}