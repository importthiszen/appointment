package com.yunzhong.appointment.system.controller;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.pagehelper.PageInfo;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.SysUser;
import com.yunzhong.appointment.system.service.PersonService;
import com.yunzhong.appointment.system.service.SysUserService;
import com.yunzhong.appointment.system.service.impl.PersonServiceImpl;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.ResultJson;
import com.yunzhong.appointment.util.SelectOptions;

/**
 * @author 冯建辉
 * @name 人员管理
 * @date 2019年3月5日16:58:13
 */
@RequestMapping("sys")
@Controller
public class PersonController {
	/**
	 * 人员模型层
	 */
	@Autowired
	private PersonService service;
	/**
	 * 用户模型层
	 */
	@Autowired
	private SysUserService userService;
	/**
	 * 冯建辉
	 * 查询人员
	 * @param request
	 * @param mm
	 * @date 2019年3月5日16:58:43
	 * @return
	 */
	@RequestMapping("listPerson")
	public String listPerson(HttpServletRequest request,ModelMap mm){
		PageData pd = new PageData(request);
		List<Person> userList = service.listPerson(pd);
		PageInfo page = new PageInfo(userList);
		mm.put("pd", pd);
		mm.put("pageInfo", page);
		return "person/listPerson";
	}
	/**冯建辉
	 * 选择用户
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("chooseUserPage")
	public String chooseUserPage(HttpServletRequest request,Model model) {
		PageData pd = new PageData(request);
		//没有被使用的用户并且角色不是患者和游客或   (**)   
		List<SysUser> userList = userService.queyUserByRoles(pd);
		PageInfo page = new PageInfo(userList);
		model.addAttribute("pd", pd);
		model.addAttribute("pageInfo", page);
		return "person/listuser";
	}
	/**
	 * 冯建辉
	 * 人员添加页面
	 * @param model
	 * @return
	 */
	@RequestMapping("addPersonPage")
	public String addPersonPage(Model model) {
		//查询科室类别
		List<Departmenttype> deptTypeList = service.queryDepartmentType();
		model.addAttribute("deptTypeList", deptTypeList);
		return "person/person_add";
	}
	/**
	 * 冯建辉
	 * 跳转修改页面
	 * @param model
	 * @return
	 */
	@RequestMapping("editPersonPage")
	public String editPersonPage(Model model,String id) {
		//查询科室类别
		List<Departmenttype> deptTypeList = service.queryDepartmentType();
		model.addAttribute("deptTypeList", deptTypeList);
		//根据id查询人员
		Person person = service.queryById(id);
		//根据user主键查询user
		SysUser user = userService.getUserById(person.getUserId());
		//把user名放到person里
		person.setUserName(user.getUserName());
		model.addAttribute("person", person);
		//根据科室id查询科室类别
		if (null != person.getDepartmentId()) {
			Departmenttype deptType = service.queryByDeptTypeByDeptId(person.getDepartmentId());
			model.addAttribute("deptType", deptType);
		}
		return "person/person_edit";
	}
	/**
	 * 冯建辉
	 * 添加person
	 * @param model
	 * @param person
	 * @return
	 */
	@RequestMapping("addPerson")
	public @ResponseBody ResultJson addPerson(Model model,Person person,@RequestParam("pic")MultipartFile picFile) {
		ResultJson r = new ResultJson();
		int count = service.addPerson(person,picFile);
		if (count > 0) {
			r.setSuccess(true);
		} else if(count == 0) {
			r.setSuccess(false);
			r.setMsg("添加失败");
		}else if(count == -1) {
			//-1  用户被其他人员使用了
			r.setSuccess(false);
			r.setMsg("该用户已被使用请退出该页面后重新添加!");
		}
		return r;
	}
	
	/**
	 * 修改人员
	 * @param model
	 * @param person
	 * @param picFile
	 * @return
	 */
	@RequestMapping("editPerson")
	public @ResponseBody ResultJson editPerson(Model model,Person person,@RequestParam("pic")MultipartFile picFile) {
		ResultJson r = new ResultJson();
		int count = service.editPerson(person,picFile);
		if (count > 0) {
			r.setSuccess(true);
		} else{
			r.setSuccess(false);
			r.setMsg("修改失败");
		}
		return r;
	}
	/**
	 * 冯建辉
	 * 查询用户是否有医生的权限
	 * @param userId
	 * @return
	 */
	@RequestMapping("queryUserRoles")
	public @ResponseBody boolean queryUserRoles(String userId){
		int count = userService.queryUserRoles(userId);
		if (count > 0) {
			return true;
		}
		return false;
	}
	/**冯建辉
	 * 查询是否有非患者的用户
	 * @return
	 */
	@RequestMapping("queryPerUser")
	public @ResponseBody boolean queryPerUser(){
		int count = userService.queryPerUserCount();
		if (count > 0) {
			return true;
		}
		return false;
	}
	/**
	 * 验证图片是否存在
	 * @param location
	 * @return
	 */
	@RequestMapping("queryImgInfo")
	public @ResponseBody boolean queryImgInfo(String location){
		if (null != location && location !="") {
			File file = new File(location);
			if (!file.exists()) {
				return false;
			}
		}
		return true;
	}
	
	/**
	 * 删除人员
	 * @param ids
	 * @return
	 */
	@RequestMapping("delPerson")
	public @ResponseBody boolean delPerson(String ids){
		int count = service.delPerson(ids);
		if (count > 0 ) {
			return true;
		}else {
			return false;
		}
	}
}
