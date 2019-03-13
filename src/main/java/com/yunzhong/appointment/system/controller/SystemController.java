package com.yunzhong.appointment.system.controller;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * @className 系统设置控制器
 * @author 石洪刚
 * @time 2017年8月17日23:52:36
 */
@Controller
@RequestMapping("/sys")
public class SystemController {
	
	/**
	 * 
	 * @methodName sys
	 * @description 跳转系统设置页面
	 * @author 石洪刚
	 * @time 2017年10月6日 下午3:21:50
	 * @return
	 */
	@RequestMapping("/sys")
	public String sys(){
		return "system/system";
	}
	/**冯建辉
	 * 跳转基本信息页面
	 * @param model
	 * 2019年3月2日10:46:47
	 * @return
	 */
	@RequestMapping("baseinfo")
	public String baseinfo() {
		return "system/system";
	}
}
