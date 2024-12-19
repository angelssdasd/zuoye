package com.example.service;

import com.example.entity.Member;
import com.example.mapper.MemberMapper;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 业务处理
 **/
@Service
public class MemberService {

    @Resource
    private MemberMapper memberMapper;

    /**
     * 新增
     */
    public void add(Member member) {
        memberMapper.insert(member);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        memberMapper.deleteById(id);
    }

    /**
     * 修改
     */
    public void updateById(Member member) {
        memberMapper.updateById(member);
    }

    /**
     * 根据ID查询
     */
    public Member selectById(Integer id) {
        return memberMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Member> selectAll() {
        return memberMapper.selectAll();
    }

    /**
     * 分页查询
     */
    public PageInfo<Member> selectPage( Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Member> list = memberMapper.selectAll();
        return PageInfo.of(list);
    }

}