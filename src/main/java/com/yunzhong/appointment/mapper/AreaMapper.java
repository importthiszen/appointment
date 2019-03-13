package com.yunzhong.appointment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.Area;
import com.yunzhong.appointment.entity.City;

public interface AreaMapper {
    int deleteByPrimaryKey(String areaId);

    int insert(Area record);

    int insertSelective(Area record);

    Area selectByPrimaryKey(String areaId);

    int updateByPrimaryKeySelective(Area record);

    int updateByPrimaryKey(Area record);
     /**
      * 根据市id查询区
      * @param id
      * @return list
      * 2019年2月28日12:54:12
      */
    @Select("SELECT\n" + 
    		"area.area_id,\n" + 
    		"area.area_name\n" + 
    		"FROM\n" + 
    		"area\n" + 
    		"WHERE area.city_id = #{param1}")
    @ResultMap("BaseResultMap")
	List<Area> queryAreaByCityId(String id);


	
}