package com.yunzhong.appointment.system.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageInfo;
import com.yunzhong.appointment.config.SessionConst;
import com.yunzhong.appointment.entity.SysMenu;
import com.yunzhong.appointment.entity.SysUser;
import com.yunzhong.appointment.system.service.SysMenuService;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.TreeNode;

/**
 * 
 * @className SysMenuController
 * @description 对菜单进行管理与维护
 * @author 石洪刚
 * @time 2017年10月2日 下午7:32:15
 */
@Controller
@RequestMapping("sys")
public class SysMenuController {
	
	@Autowired
	private SysMenuService menuService;
	/**
	 * 
	 * @methodName showMenu
	 * @description 用于点击一级菜单进行跳转
	 * @author 石洪刚
	 * @time 2017年10月2日 下午7:32:41
	 * @param id
	 * @return
	 */
	@RequestMapping("showMenu")
	public String showMenu(String id){
		List<SysMenu> menuList = (List<SysMenu>) SecurityUtils.getSubject().getSession().getAttribute(SessionConst.SESSION_MENULIST);
		SysMenu sm = null;
		if(menuList!=null){
			for (SysMenu sysMenu : menuList) {
				if(id.equals(sysMenu.getMenuId())){
					sm = sysMenu;
					break;
				}
			}
		}
		//如果没查到，则设置要显示的菜单为个人中心
		if(sm==null){
			sm = (SysMenu) SecurityUtils.getSubject().getSession().getAttribute(SessionConst.SESSION_PERSONAL_MENU);
		}
		SecurityUtils.getSubject().getSession().setAttribute(SessionConst.SESSION_MENU, sm);
		return "redirect:"+sm.getMenuUrl();
	}
	/**
	 * 跳到菜单页面
	 * @param request
	 * @param mm
	 * @return
	 */
	@RequestMapping("listMenu")
	public String listUser(HttpServletRequest request,ModelMap mm){
		return "system/menu/listmenu";
	}
	/**
	 * 显示菜单维护
	 * @param request
	 * @param mm
	 * @param id
	 * @return
	 */
	@RequestMapping("queryMenu")
	public @ResponseBody List<TreeNode> listUser(HttpServletRequest request,ModelMap mm,String id){
		if (id == null) {
			id="0";
			List<TreeNode> nodeList = new ArrayList<>();
			TreeNode node = new TreeNode();
			node.setId("0");
			node.setText("菜单");
			node.setState("open");
			node.setChildren(menuService.queryMeNuTree(id));
			nodeList.add(node);
			return nodeList;
		}
		return menuService.queryMeNuTree(id);
	}
	/**
	 * 转到修改菜单页面
	 * @param id
	 * @param mm
	 * @return
	 */
	@RequestMapping("editMwnuPage")
	public String editMwnuPage(String id,Model mm) {
		//根据id查菜单
		SysMenu menu = menuService.queryMenuById(id);
		mm.addAttribute("menu", menu);
		return "system/menu/menu_edit";
	}
	/**
	 * 修改菜单
	 * @param id
	 * @param mm
	 * @return
	 */
	@RequestMapping("/editMenu")
	public @ResponseBody boolean editMenu(SysMenu menu,Model mm) {
		boolean bj = false;
		int count = menuService.edit(menu);
		if (count > 0) {
			bj = true;
		} else {
			bj = false;
		}
		return bj;
	}
	/**
	 * 跳转增加页面
	 * @return
	 */
	@RequestMapping("addMwnuPage")
	public String addMwnuPage(String sysMenuId,Model model) {
		model.addAttribute("sysMenuId", sysMenuId);
		return "system/menu/menu_add";
	}
	/**
	 * 添加菜单
	 * @param menu
	 * @param mm
	 * @return
	 */
	@RequestMapping("addMenu")
	public @ResponseBody boolean addMenu(SysMenu menu,Model mm) {
		boolean bj = false;
		int count = menuService.add(menu);
		if (count > 0) {
			bj = true;
		} else {
			bj = false;
		}
		return bj;
	}
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	@RequestMapping("delMenu")
	public @ResponseBody Map<String, Object> delMenu(String id){
		Map<String, Object> map = new HashMap<>();
		//删除
		int count = menuService.del(id); 
		if (count > 0) {
			map.put("success", true);
		} else {
			map.put("success", false);
			map.put("msg", "删除失败!");
		}
		return map;
	}
	/**
	 * 验证菜单名称是否重复
	 * @param sysMenuId
	 * @param menuName
	 * @param menuId
	 * @return
	 */
	@RequestMapping("validateMenuName")
	public @ResponseBody boolean validateMenuName(String sysMenuId,String menuName,String menuId){
		//删除
		int count = menuService.validateMenuName(sysMenuId,menuName,menuId); 
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}
}
