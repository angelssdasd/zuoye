package com.example.mapper;

import com.example.entity.Comment;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface CommentMapper {
    List<Comment> selectAll();

    List<Comment> selectByCondition(@Param("userId") Integer userId, @Param("artifactId") Integer artifactId);

    Comment selectById(Integer id);

    void insert(Comment comment);

    void update(Comment comment);

    void deleteById(Integer id);
}
