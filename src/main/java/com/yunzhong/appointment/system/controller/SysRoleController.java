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
import com.yunzhong.appointment.entity.SysRole;
import com.yunzhong.appointment.entity.SysUser;
import com.yunzhong.appointment.system.service.SysRoleService;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.ResultJson;
import com.yunzhong.appointment.util.SelectOptions;



@RequestMapping("sys")
@Controller
public class SysRoleController {

	@Autowired
	private SysRoleService roleService;

	/**
	 * 查询角色列表
	 * @param request
	 * @param mm
	 * @return
	 */
	@RequestMapping("listRole")
	public String listRole(HttpServletRequest request,ModelMap mm){
		PageData pd = new PageData(request);
		List<SysRole> roleList = roleService.listRole(pd);
		PageInfo page = new PageInfo(roleList);
		mm.put("pd", pd);
		mm.put("page", page);
		return "system/role/listrole";
	}
/**
 * 跳转角色的增加或修改页	
 * @param id
 * @param mm
 * @return
 */
	@RequestMapping("pageRole")
	public String pageRole(String id,ModelMap mm){
		if(null!=id){
			SysRole role = roleService.getRoleById(id);
			mm.put("role", role);
		}
		return "system/role/pagerole";
	}
	/**
	 * 验证角色名称是否重复
	 * @param userName
	 * @return
	 */
	@RequestMapping("checkRoleName")
	@ResponseBody
	public ResultJson checkRoleName(String roleName){
		int count = roleService.getRoleByRoleName(roleName);
		ResultJson r=new ResultJson();
		if(count>0) {
			r.setSuccess(true);
		}else {
			r.setSuccess(false);
		}
		return r;
	}
/**
 * 增加或修改用户信息	
 * @param role
 * @param redirectAttributes
 * @return
 */
	@RequestMapping("saveOrUpdateRole")
	public String saveOrUpdateRole(SysRole role,RedirectAttributes redirectAttributes){
		roleService.saveOrUpdateRole(role);
		//刚增加或修改的数据要回传到页面显示在第一条
		redirectAttributes.addFlashAttribute("firstObj",role);
		return "redirect:listRole";
	}
/**
 * 删除角色信息	
 * @param ids
 * @return
 */
	@RequestMapping("removeRole")
	public String removeRole(String[] ids){
		roleService.removeRole(ids);
		return "redirect:listRole";
	}
/**
 * 对角色进行授权,跳转至授权页面
 * @param id
 * @param mm
 * @return
 */
	@RequestMapping("authRole")
	public String authRole(String id, ModelMap mm){
		SysRole role = roleService.getRoleById(id);
		//查询菜单，用户菜单为selected
		List<SelectOptions> list = roleService.queryRoleMenu(id);
		mm.put("role", role);
		mm.put("list", list);
		return "system/role/role_menu";
	}
/**
 * 提交授权保存	
 * @param roleId
 * @param menuIds
 * @return
 */
	@RequestMapping("roleMenu")
	public String roleMenu(String menuIds,String roleId,RedirectAttributes redirectAttributes){
		SysRole role=roleService.roleMenu(menuIds,roleId);
		redirectAttributes.addFlashAttribute("firstObj",role);
		return "redirect:listRole";
	}
}
