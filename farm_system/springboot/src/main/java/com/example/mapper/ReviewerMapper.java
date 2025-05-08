package com.example.mapper;

import com.example.entity.Reviewer;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * 操作user相关数据接口
*/
public interface ReviewerMapper {


    @Select("select * from reviewer where username = #{username}")
    Reviewer selectByUsername(String username);

}