package com.yunzhong.appointment.system.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.pagehelper.PageInfo;
import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Professional;
import com.yunzhong.appointment.entity.SysRole;
import com.yunzhong.appointment.system.service.ProfessionalService;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.ResultJson;

@RequestMapping("sys")
@Controller
public class ProfessionalController {

	@Autowired
	private ProfessionalService proService;
/**
 * 查询职称列表	
 * @param request
 * @param mm
 * @return
 */
	@RequestMapping("listProfessional")
	public String listPro(HttpServletRequest request,ModelMap mm){
		PageData pd = new PageData(request);
		List<Professional> proList = proService.listPro(pd);
		PageInfo page = new PageInfo(proList);
		mm.put("pd", pd);
		mm.put("page", page);
		//查询科室下拉列表
		List<Department>deptList=proService.queryDept();
		mm.put("deptList", deptList);
		return "system/professional/listprofessional";
	}
	/**
	 * 跳转到增加或修改页
	 */
	@RequestMapping("pagePro")
	public String pageUser(String id,ModelMap mm){
		if(null!=id){
			Professional pro = proService.getproById(id);
			mm.put("pro", pro);
		}
		List<Department>deptList=proService.queryDept();
		mm.put("deptList", deptList);
		return "system/professional/pagepro";
	}
	
	//判断名称是否重复validProName
		@RequestMapping("validProName")	
		@ResponseBody
		public ResultJson validProName(String professionalName,String dpId) {
			int count=proService.validProName(professionalName,dpId);
			ResultJson r=new ResultJson();
			if(count>0) {
				r.setSuccess(true);
			}else {
				r.setSuccess(false);
			}
			return r;
		}	
/**
 * 	保存(添加/修改)
 * @param pro
 * @param redirectAttributes
 * @return
 */
		@RequestMapping("saveOrUpdatePro")
		public String saveOrUpdatePro(Professional pro,RedirectAttributes redirectAttributes){
			proService.saveOrUpdatePro(pro);
			Department  dept= proService.queryDeptNameById(pro.getDpId());
			pro.setDpName(dept.getDpName());
			//刚增加或修改的数据要回传到页面显示在第一条
			redirectAttributes.addFlashAttribute("firstObj",pro);
			return "redirect:listProfessional";
		}
	/**
	 * 删除职称信息		
	 */
		@RequestMapping("removePro")
		@ResponseBody
		public ResultJson removePro(String ids) {
			System.err.println("++++++++++++++++++++++++++++="+ids);
			String names = proService.removePro(ids);
			ResultJson r = new ResultJson();
			if ("".equals(names)) {
				r.setSuccess(true);
				r.setMsg("删除成功");
			} else {
				r.setSuccess(false);
				r.setMsg(names+"不能删除");
			}	
			return r;
		}
}
