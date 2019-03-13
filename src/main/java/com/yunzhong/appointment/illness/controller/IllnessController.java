package com.yunzhong.appointment.illness.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.pagehelper.PageInfo;
import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Illness;
import com.yunzhong.appointment.entity.Illnessposition;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.illness.service.IllnessService;
import com.yunzhong.appointment.util.FileUtils;
import com.yunzhong.appointment.util.PageData;

@Controller
@RequestMapping("appointment")
public class IllnessController {

	@Autowired
	private IllnessService service;
/**	
 * 查询疾病列表
 * @param model
 * @param request
 * @return
 */
	@RequestMapping("listIllness")
	public String querylistIllness(Model model,HttpServletRequest request) {
		//查询疾病
		List<Illnessposition>IllnesspositionList=service.queryIllnessposition();
		model.addAttribute("IllnesspositionList",IllnesspositionList);		
		List<Illness>illnessList=service.queryIllness();
		model.addAttribute("illnessList",illnessList);
		return "appointment/illness/listIllness";	
	}
/**
 * 查询九天内出诊的医生	
 * @param mm
 * @param request
 * @return
 */
	@RequestMapping("listDoctor")
	public String querylistDoctor(ModelMap mm,HttpServletRequest request,String illName) {	
		PageData pd = new PageData(request);
		Illness illness=service.queryById(pd);
		mm.put("illness", illness);
		List<Person>listDoctor=service.querylistDoctor(pd);
		PageInfo page = new PageInfo(listDoctor);
		mm.put("pd", pd);
		mm.put("page", page);
		return "appointment/doctor/listDoctor_illness";		
	}
	/**
	 * 查询热门疾病
	 * @param mm
	 * @param request
	 * @param illName
	 * @return
	 */
	@RequestMapping("queryByName")
	public String queryByName(ModelMap mm,HttpServletRequest request,String illName) {	
		PageData pd = new PageData(request);
		Illness illness=service.queryInfo(pd);
		mm.put("illness", illness);
		List<Person>listDoctor=service.queryByName(pd);
		System.err.println(listDoctor);
		PageInfo page = new PageInfo(listDoctor);
		mm.put("pd", pd);
		mm.put("page", page);
		return "appointment/doctor/listDoctor_illness2";			
	}
	
	//根据疾病名称或者科室名称查询对应的医生(输入名称查询)
	@RequestMapping("queryByillnessOrdoctor")
	public String queryByillnessOrdoctor(ModelMap mm,HttpServletRequest request,String illName,String departmentName) {
		List<Illness> ills=service.queryByillName(illName);
		mm.put("ills", ills);
		PageData pd = new PageData(request);
		List<Person>listDoctor=service.queryByillnessOrdoctor(pd);
		PageInfo page = new PageInfo(listDoctor);
		mm.put("pd", pd);
		mm.put("page", page);
		if(pd.get("departmentName")!=null) {
			return "appointment/doctor/listDoctor_byDept";
		}
		return  "appointment/doctor/listDoctor_byIllness";			
	}
	
	/**
	 * 显示头像
	 */
	@RequestMapping("down")
	public void down(String location ,HttpServletResponse response) {
		FileUtils.downloadFile(response, location);
	}
}
