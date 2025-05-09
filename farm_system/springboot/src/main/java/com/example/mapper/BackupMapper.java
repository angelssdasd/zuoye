package com.example.mapper;

import com.example.entity.Backup;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BackupMapper {
    List<Backup> selectAll();

    List<Backup> selectByCondition(@Param("operatorId") Integer operatorId);

    void insert(Backup backup);

    void deleteById(Integer id);
}
