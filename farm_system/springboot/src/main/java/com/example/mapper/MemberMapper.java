package com.example.mapper;

import com.example.entity.Member;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 操作Member相关数据接口
 */
@Mapper
public interface MemberMapper {

    /**
     * 新增
     */
    @Insert("INSERT INTO Member (ID, MemberName, Gender, BirthDate, ContactAddress, PhoneNumber, Occupation, IDNumber) " +
            "VALUES (#{id}, #{memberName}, #{gender}, #{birthDate}, #{contactAddress}, #{phoneNumber}, #{occupation}, #{idNumber})")
    int insert(Member member);

    /**
     * 删除
     */
    @Delete("DELETE FROM Member WHERE ID = #{id}")
    int deleteById(@Param("id") int id);

    /**
     * 修改
     */
    @Update("UPDATE Member SET " +
            "MemberName = #{memberName}, " +
            "Gender = #{gender}, " +
            "BirthDate = #{birthDate}, " +
            "ContactAddress = #{contactAddress}, " +
            "PhoneNumber = #{phoneNumber}, " +
            "Occupation = #{occupation}, " +
            "IDNumber = #{idNumber} " +
            "WHERE ID = #{id}")
    int updateById(Member member);

    /**
     * 根据ID查询
     */
    @Select("SELECT * FROM Member WHERE ID = #{id}")
    Member selectById(@Param("id") int id);

    /**
     * 查询所有
     */
    @Select("SELECT * FROM Member")
    List<Member> selectAll();
}