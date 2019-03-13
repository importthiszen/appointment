package com.yunzhong.appointment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.City;

public interface CityMapper {
    int deleteByPrimaryKey(String id);

    int insert(City record);

    int insertSelective(City record);

    City selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(City record);

    int updateByPrimaryKey(City record);
    /**
     * 根据省id查询市
     * @param id
     * @return list
     * 2019年2月28日11:32:08
     */ 
    @Select("SELECT\n" + 
    		"city.city_id,\n" + 
    		"city.city_name\n" + 
    		"FROM\n" + 
    		"city\n" + 
    		"WHERE city.province_id = #{param1}")
    @ResultMap("BaseResultMap")
	List<City> queryVityByProvinceId(String id);

}