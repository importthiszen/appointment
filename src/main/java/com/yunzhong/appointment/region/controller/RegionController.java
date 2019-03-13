package com.yunzhong.appointment.region.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yunzhong.appointment.entity.Area;
import com.yunzhong.appointment.entity.City;
import com.yunzhong.appointment.region.service.RegionService;
import com.yunzhong.appointment.region.service.impl.RegionServiceImpl;
import com.yunzhong.appointment.util.ResultJson;

/**
 * 地区查询
 * @author 于占峰
 * 2019年2月28日10:57:09
 */
@Controller
@RequestMapping("region")
public class RegionController {

	/**
	 * 模型层
	 */
	@Autowired
	private RegionService service;
	/**
	 * ajax查询市
	 */
	@RequestMapping("city")
	@ResponseBody
	public ResultJson querycity(String id) {
		ResultJson r = new ResultJson();
		List<City> citylist = service.queryVityByProvinceId(id);
		r.setObj(citylist);
		return r;
	}
	/**
	 * ajax查询区
	 */
	@RequestMapping("area")
	@ResponseBody
	public ResultJson queryarea(String id) {
		ResultJson r = new ResultJson();
		List<Area> arealist = service.queryAreaByCityId(id);
		r.setObj(arealist);
		return r;
	}


}
