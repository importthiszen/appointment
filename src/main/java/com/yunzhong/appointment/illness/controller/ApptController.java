package com.yunzhong.appointment.illness.controller;
/**
 * 预约控制层
 * @author于占峰
 *2019年3月7日13:40:11
 */

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Scheduling;
import com.yunzhong.appointment.illness.service.ApptService;
import com.yunzhong.appointment.illness.service.impl.ApptServiceImpl;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.ResultJson;
@Controller
@RequestMapping("appt")
public class ApptController {

	@Autowired
	private ApptService service;
	/**
	 * 预约跳页
	 */
	@RequestMapping("apptlist")
	public String appBydept(String ppId,ModelMap mp,String type,String illId) {
		//查询医生
		Person pp = service.selectDoctorByPpid(ppId);
		mp.put("pp", pp);
		//根据医生主键查询未来九天的排班表
		List<Scheduling> list = service.queryDoctorSchedulingById(ppId);
		mp.put("list", list);
		//查询挂号费
		String bassfee = service.quryBassfee(); 
		mp.put("basefee", bassfee);
		if (type.equals("illness")) {
			mp.put("illId", illId);
			return"appointment/appt/apptByillness";
		} else {
			return"appointment/appt/apptBydept";
		}
	}
	/**
	 * 添加预约
	 */
	@RequestMapping("apptadd")
	@ResponseBody
	public ResultJson apptadd(HttpServletRequest request) {
		PageData pd = new PageData(request);
		ResultJson r = new ResultJson();
		int tiao = service.addAppointmentorder(pd);
		/**
		 * 在同一就诊日、同一科室只能预约1次； -1 在同一就诊日的预约总量不可超过2次； -2 在七日内的预约总量不可超过3次；-3
		 * 在三个月内预约总量不可超过5次。 -4 3个月内累计爽约达到3次也将无法预约 -5
		 */
		if (tiao>0) {
			r.setSuccess(true);
		} else if(tiao == 0){
			r.setSuccess(false);
			r.setMsg("网络开了个小差,请稍后重试");
		}else if (tiao == -1) {
			r.setSuccess(false);
			r.setMsg("同一就诊日、同一科室或疾病只能预约1次");
		} else if (tiao == -2) {
			r.setSuccess(false);
			r.setMsg("同一就诊日的预约总量超过2次");
		} else if (tiao == -3) {
			r.setSuccess(false);
			r.setMsg("七日内的预约总量超过3次");
		}else if (tiao == -4) {
			r.setSuccess(false);
			r.setMsg("三个月内预约总量超过5次");
		}else if (tiao == -5) {
			r.setSuccess(false);
			r.setMsg("三个月内累计爽约达到3次");	
		}
		return r;
	}
}
