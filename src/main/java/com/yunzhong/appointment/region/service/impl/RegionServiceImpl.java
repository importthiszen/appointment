package com.yunzhong.appointment.region.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yunzhong.appointment.entity.Area;
import com.yunzhong.appointment.entity.City;
import com.yunzhong.appointment.mapper.AreaMapper;
import com.yunzhong.appointment.mapper.CityMapper;
import com.yunzhong.appointment.mapper.ProvinceMapper;
import com.yunzhong.appointment.region.service.RegionService;
@Service
public class RegionServiceImpl implements RegionService {
      /**
       * 省接口
       */
	@Autowired
	private ProvinceMapper proMapper;
	/**
	 * 市借口
	 */
	@Autowired
	private CityMapper cityMapper;
	/**
	 * 区接口
	 */
	@Autowired
	private AreaMapper areaMapper;
	/**
	 * 根据省id查询市
	 */
	@Override
	public List<City> queryVityByProvinceId(String id) {
		return cityMapper.queryVityByProvinceId(id);
	}
	/**
	 * 根据市id查询区id
	 */
	@Override
	public List<Area> queryAreaByCityId(String id) {
		return areaMapper.queryAreaByCityId(id);
	}
	
}
