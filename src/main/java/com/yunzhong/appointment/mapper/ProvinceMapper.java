package com.yunzhong.appointment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.Province;

public interface ProvinceMapper {
    int deleteByPrimaryKey(String provinceId);

    int insert(Province record);

    int insertSelective(Province record);

    Province selectByPrimaryKey(String provinceId);

    int updateByPrimaryKeySelective(Province record);

    int updateByPrimaryKey(Province record);
    /**
     * 查询所有省
     * @return
     */
    @Select("SELECT\n" + 
    		"province.province_id,\n" + 
    		"province.province_name\n" + 
    		"FROM\n" + 
    		"province")
    @ResultMap("BaseResultMap")
	List<Province> queryAll();
}