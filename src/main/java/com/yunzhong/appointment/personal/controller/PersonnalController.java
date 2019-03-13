package com.yunzhong.appointment.personal.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.yunzhong.appointment.entity.Appointmentorder;
import com.yunzhong.appointment.entity.Patient;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Province;
import com.yunzhong.appointment.personal.service.PersonalService;
import com.yunzhong.appointment.util.FileUtils;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.ResultJson;

/**
 * 个人中心控制层
 * @author 于占峰
 *2019年3月3日13:04:29
 */


@Controller
@RequestMapping("personal")
public class PersonnalController {

	/**
	 * 模型层
	 */
	@Autowired
	private PersonalService service;
	/**
	 * 个人中心跳页
	 */
	@RequestMapping("list")
	public String list(String type) {
		if (type != null && type.equals("ap")) {
			return"personal/personal2";
		} else {

			return"personal/personal";
		}
	}
	/**
	 * 查看个人信息
	 */
	@RequestMapping("personalInfo")
	public String personalInfo(String userName,ModelMap mp){
		//查询省
		List<Province> proList = service.queryProvince(); 
		mp.put("proList", proList);
		Patient pt = service.queryPatientByuserName(userName);
		mp.put("pt", pt);
		return "personal/personal_edit";
	}
	/**
	 * 修改个人信息
	 */
	@RequestMapping("edit")
	@ResponseBody
	public ResultJson edit(Patient pt) {
		ResultJson r = new ResultJson();
		int tiao = service.editPatient(pt);
		if (tiao>0) {
			r.setSuccess(true);
		} else {
            r.setSuccess(false);
		}
		return  r ;
	}
	/**
	 * 修改头像跳页
	 */
	@RequestMapping("personalPhoto")
	public String personalPhoto(String userName,ModelMap mp) {
		Patient pt = service.queryPatientByuserName(userName);
		Person ps = service.queryPersonByuserName(userName);
		mp.put("ps", ps);
		mp.put("pt", pt);
		mp.put("userName", userName);
		return "personal/personPhoto";
	}
	/**
	 * 上传头像
	 */
	@RequestMapping("addimg")
	@ResponseBody
	public ResultJson addimg(String image,String id,String userName) {
		System.err.println(image);
		ResultJson r = new ResultJson();
		int tiao = service.addimg(image,id,userName);
		if (tiao>0) {
			r.setSuccess(true);
		} else {
            r.setSuccess(false);
		}
		return r;
	}
	/**
	 * 显示头像
	 */
	@RequestMapping("down")
	public void down(String location ,HttpServletResponse response) {
		FileUtils.downloadFile(response, location);
	}
	/**
	 * 修改密码跳页
	 */
	@RequestMapping("changePass")
	public String changePass(String userName,ModelMap mp) {
		mp.put("userName", userName);
		return"personal/editPassword";
	}
	/**
	 * 修改密码
	 */
	@RequestMapping("editpass")
	@ResponseBody
	public ResultJson editpass(Patient pt,String Pass) {
		ResultJson r = new ResultJson();
 		int tiao = service.editpass(pt,Pass);
 		if (tiao== 0) {
			r.setSuccess(true);
			r.setMsg("修改失败");
		} else if(tiao == 1) {
            r.setSuccess(true);
            r.setMsg("修改成功,请重新登录");
		} else if(tiao == -1) {
			r.setSuccess(false);
			r.setMsg("原密码错误");
		}
 		return r ;
	}
	/**
	 * 查询订单
	 */
	@RequestMapping("listOrder")
	public String listOrder(HttpServletRequest request,String userName,ModelMap mp,String order_state) {
		    PageData pd = new PageData(request);
			List<Appointmentorder> list = service.querylistOrder(pd,order_state);
			PageInfo page = new PageInfo(list);
			mp.put("pd",pd);
			mp.put("page",page);
			mp.put("userName", userName);
			if (order_state != null && order_state.equals("N")) {
				return "personal/order/listOrder_N";
			} else {
				return "personal/order/listOrder";
			}
	}
	/**
	 * 取消订单
	 */
	@RequestMapping("cancelOrder")
	@ResponseBody
	public ResultJson cancelOrder(String id) {
		ResultJson r = new ResultJson();
		int tiao = service.cancelOrder(id);
		if (tiao>0) {
			r.setSuccess(true);
		} else {
            r.setSuccess(false);
		}
		return r;
	}
	/**
	 * 支付跳页
	 */
	@RequestMapping("payOrder")
	public String payOrder(String type) {
		if (type.equals("weixin")) {	
			return"personal/order/weixinPayOrder";
		} 
		if (type.equals("zhifubao")) {	
			return"personal/order/weixinPayOrder";
		} 
		return"";
	}
}
