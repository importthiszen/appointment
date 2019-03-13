package com.yunzhong.appointment.system.controller;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.yunzhong.appointment.baseinfo.service.HospitalService;
import com.yunzhong.appointment.entity.Hostipal;
import com.yunzhong.appointment.system.service.DashBoardService;

/**
 * @类名称：首页控制器
 * @author 石洪刚
 * @time 2017年8月07日20:08:23
 *
 */
@Controller
@RequestMapping("/")
public class DashBoardController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private DashBoardService dashBoardService;
	
	@Autowired
	private HospitalService hospitalService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String dashBoard(Model mm){
		logger.debug("加载控制台(首页)................................");
		dashBoardService.setGuestMenu();
		//更改医院简介
		List<Hostipal> hospitalList= hospitalService.query();		
		mm.addAttribute("hospital", hospitalList.get(0));
		return "dashboard";
	}
	
	
}
