package com.yunzhong.appointment.baseinfo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yunzhong.appointment.baseinfo.service.HospitalService;
import com.yunzhong.appointment.entity.Hostipal;
import com.yunzhong.appointment.util.ResultJson;

/**
 * 医院简介
 * @author 张玉娇
 * @date 2019年3月12日
 */
@Controller
@RequestMapping("baseinfo")
public class HospitalController {
	
	@Autowired
	private HospitalService hospitalService;
	/**
	 * 查询医院简介
	 * @param mm
	 * @return
	 */
	@RequestMapping("showHospitalInfo")
	public String showHospitalInfo(Model mm) {
		List<Hostipal> hospitalList= hospitalService.query();		
		mm.addAttribute("hospital", hospitalList.get(0));
		return "hostipal/listHospital";
	}
	/**
	 * 进入修改医院简介
	 * @param mm
	 * @return
	 */
	@RequestMapping("editHospital")
	public String editHospital(Model mm,String id) {
		Hostipal hospital= hospitalService.queryById(id);
		mm.addAttribute("hospital", hospital);
		return "hostipal/hospital_edit";
	}
	/**
	 * 修改保存
	 * @param hospital
	 * @return
	 */
	@RequestMapping("editsaveHospital")
	@ResponseBody
	public ResultJson editsaveHospital(Hostipal hospital) {
		ResultJson r = new ResultJson();
		int count =hospitalService.editsaveHospital(hospital);
		if (count > 0) {
			r.setSuccess(true);
		} else {
			r.setSuccess(false);	
		}
		return r;
	}

}
