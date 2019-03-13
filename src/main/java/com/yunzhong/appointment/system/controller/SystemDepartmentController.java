package com.yunzhong.appointment.system.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.system.service.SystemDepartmentService;
import com.yunzhong.appointment.util.ResultJson;
import com.yunzhong.appointment.util.SelectOptions;

@RequestMapping("sys")
@Controller
public class SystemDepartmentController {

	@Autowired
	private SystemDepartmentService deptService;
	
	@RequestMapping("listDepartment")
	public String listDepartment(ModelMap mm){
//		List<Department> topList =  deptService.queryAllwithList();
		List<SelectOptions>topList=deptService.queryAllList();
		mm.put("topList", topList);
		return "system/dept/listdept";
	}
	/**
	 * 
	 * @param id
	 * @return
	 */
	@RequestMapping("addpage")
	@ResponseBody
	public Departmenttype addpage(String id){
		Departmenttype depttype = deptService.queryById(id);
		return depttype;
	}
	/**
	 * 验证名称是否重复
	 * @param roleName
	 * @return
	 */
	@RequestMapping("validDeptName")
	@ResponseBody
	public ResultJson validDeptName(String deptName,String deptId){
		int count = deptService.validDeptName(deptName,deptId);
		ResultJson r=new ResultJson();
		if(count>0) {
			r.setSuccess(true);
		}else {
			r.setSuccess(false);
		}
		return r;
	}
	/**
	 * 添加保存
	 * @param deptPar
	 * @param deptName
	 * @return
	 */
	@RequestMapping("saveDept")
	@ResponseBody
	public ResultJson addsaveDept(String deptPar,String deptName,String deptId,String parDeptName) {
		ResultJson r=new ResultJson();
		int count;
		if(deptId=="") {
			 count = deptService.addsaveDept(deptPar,deptName);			
		}else {
			 count=deptService.editsaveDept(deptPar,deptName,deptId,parDeptName);
		}				

		if(count>0) {
			r.setSuccess(true);
		}else {
			r.setSuccess(false);
		}
		return r;
	}
	/**
	 * 跳转到修改页面
	 */
	@RequestMapping("editpage")
	@ResponseBody
	public List editpage(String id,String deptName){
		List rvList = new ArrayList();
		Department dept = deptService.queryBydpName(deptName);
		rvList.add(dept);
		Departmenttype parDept =deptService.queryDeptType(deptName);		
		if(dept!=null) {
			Departmenttype parDept1 =deptService.queryById(dept.getDplId());
			rvList.add(parDept1);
		}
		System.err.println(dept);
		System.err.println(parDept);
		rvList.add(parDept);
		return rvList;
	}
	/**
	 * 删除
	 */
	@RequestMapping("deleteDept")
	@ResponseBody
	public ResultJson deleteDept(String id,String deptName) {
		String names=deptService.deleteDept( id,deptName);
		ResultJson r=new ResultJson();
		if("".equals(names)) {
			r.setSuccess(true);
			r.setMsg("删除成功");
		}else {
			r.setSuccess(false);
			r.setMsg("删除失败,"+names+"已被占用不能删除");
		}
		return r;	
	}
	
}
