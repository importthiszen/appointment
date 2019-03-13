package com.yunzhong.appointment.region.service;

import java.util.List;

import com.yunzhong.appointment.entity.Area;
import com.yunzhong.appointment.entity.City;

public interface RegionService {
     /**
      * 根据省id查询市
      * @param id
      * @return list
      * 2019年2月28日11:31:10
      */ 
	List<City> queryVityByProvinceId(String id);
    /**
     * 根据市id查询区
     * @param id
     * @return list
     * 2019年2月28日12:52:36
     */
	List<Area> queryAreaByCityId(String id);

}
