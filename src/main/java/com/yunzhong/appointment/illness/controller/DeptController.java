package com.yunzhong.appointment.illness.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.yunzhong.appointment.entity.Appointmentorder;
import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Professional;
import com.yunzhong.appointment.illness.service.DepartmentService;
import com.yunzhong.appointment.util.PageData;

@Controller
@RequestMapping("appointment")
public class DeptController {

	@Autowired
	private DepartmentService service;
	
	//查询所有科室类别
	@RequestMapping("listDept")
	public String queryDepartmenttype(ModelMap mm) {
		//查询科室
		List<Departmenttype> deptList = service.selectDeptmenttype();
		mm.put("deptList", deptList);
		//查询热门科室
		List<Appointmentorder>appointmentorderDplist=service.queryAppointmentorder();
		mm.put("appointmentorderDplist", appointmentorderDplist);
		return "appointment/dept/listDept";		
//		List<Departmenttype>dplList=service.queryDepartmenttype();
//		mm.put("dplList", dplList);
//		List<Department>dpList=service.queryDepartment();
//		mm.put("dpList", dpList);
	}
	/**
	 * 查询九天内出诊的医生	
	 * @param mm
	 * @param request
	 * @return
	 */
	@RequestMapping("deptDoctor")
	public String querylistDoctor(ModelMap mm,HttpServletRequest request) {	
		PageData pd = new PageData(request);
		Department dept=service.queryById(pd);
		mm.put("dept", dept);
		List<Person>deptDoctor=service.querydeptDoctor(pd);
		PageInfo page = new PageInfo(deptDoctor);
		mm.put("pd", pd);
		mm.put("page", page);
		return "appointment/doctor/listDoctor_dept";		
	}	
	/**
	 * 根据类别查询科室
	 * @param mm
	 * @param dplId
	 * @return
	 */
	@RequestMapping("queryDeptBydplId")
	public @ResponseBody List<Department> queryDeptBydplId(ModelMap mm,String dplId) {	
	    List<Department> deptList = service.queryDeptBydplId(dplId);
		return deptList;		
	}
	
	
	/**
	 * 根据科室查询职务
	 * @param mm
	 * @param departmentId
	 * @return
	 */
	@RequestMapping("queryProByDeptId")
	public @ResponseBody List<Professional> queryProByDeptId(ModelMap mm,String departmentId) {	
	    List<Professional> proList = service.queryProByDeptId(departmentId);
		return proList;		
	}
	/**
	 * 根据职务查询出诊费用
	 * @param mm
	 * @param professionalId
	 * @return
	 */
	@RequestMapping("queryProfessionalFeeById")
	public @ResponseBody Double queryProfessionalFeeById(ModelMap mm,String professionalId) {	
		Double professionalFee = service.queryProfessionalFeeById(professionalId);
		return professionalFee;		
	}
	
}
