package com.example.mapper;

import com.example.entity.Backup;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface BackupMapper {
    List<Backup> selectAll();

    @Select("SELECT * FROM backup WHERE backup_id = #{id}")
    Backup selectById(@Param("id") Integer id);
    List<Backup> selectByCondition(@Param("operatorId") Integer operatorId);

    void insert(Backup backup);

    void deleteById(Integer id);

    // 根据备份ID获取文件路径
    String getFilePath(Integer backupId);
}
