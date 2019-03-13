package com.yunzhong.appointment.system.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yunzhong.appointment.entity.SysMenu;
import com.yunzhong.appointment.mapper.SysMenuMapper;
import com.yunzhong.appointment.system.service.SysMenuService;
import com.yunzhong.appointment.util.TreeNode;

/**
 * 
 * @className SysMenuServiceImpl
 * @description 菜单模型层实现类
 * @author 石洪刚
 * @time 2017年10月2日 下午7:38:02
 */
@Service
public class SysMenuServiceImpl implements SysMenuService{

	@Autowired
	private SysMenuMapper menuMapper;
	@Override
	public List<SysMenu> listAllMenu() {
		//得到所有一级菜单
		List<SysMenu> topList = menuMapper.listTopMenu();
		List<SysMenu> rvList = new ArrayList<SysMenu>();
		for (SysMenu sysMenu : topList) {
			SysMenu rv = this.recursiveMenuByTopMenu(sysMenu);
			rvList.add(rv);
		}
		return rvList;
	}
	/**
	 * 
	 * @methodName recursiveMenuByTopMenu
	 * @description 递归得到一个菜单下的所有子菜单
	 * @author 石洪刚
	 * @time 2017年10月2日 下午7:47:28
	 * @param menu
	 * @return
	 */
	private SysMenu recursiveMenuByTopMenu(SysMenu menu) {
		List<SysMenu> childMenus = menuMapper.listMenuByPar(menu);
		for (SysMenu sysMenu : childMenus) {
			SysMenu m = recursiveMenuByTopMenu(sysMenu);
			menu.getChildrenMenuList().add(m);
		}
		return menu;
	}
	
	@Override
	public void removeMenu(String id) {
		SysMenu m = menuMapper.selectByPrimaryKey(id);
		SysMenu menu = this.recursiveMenuByTopMenu(m);
		//把所有菜单按顺序放在list中
		List<SysMenu> rmList = new ArrayList<SysMenu>();
		List<SysMenu> list = menu.getChildrenMenuList();
		while(list.size()>0){
			rmList.addAll(list);
			List<SysMenu> temList = new ArrayList<SysMenu>();
			for (int j = 0; j < list.size(); j++) {
				SysMenu temAdds = list.get(j);
				temList.addAll(temAdds.getChildrenMenuList());
			}
			list = temList;
		}
		//删除所有子集菜单
		for (int j = rmList.size()-1; j >= 0; j--) {
			menuMapper.deleteByPrimaryKey(rmList.get(j).getMenuId());
		}
		//删除菜单
		menuMapper.deleteByPrimaryKey(id);
	}
	@Override
	public SysMenu getMenuWithParNameById(String id) {
		return menuMapper.getMenuWithParNameById(id);
	}
	@Override
	public void saveOrUpdateMenu(SysMenu menu) {
		if("".equals(menu.getMenuId())){
			menu.setMenuId(UUID.randomUUID().toString());
			menu.setMenuState("A");
			menuMapper.insertSelective(menu);
		}else{
			menuMapper.updateByPrimaryKeySelective(menu);
		}
	}
	/**
	 * 查询树形菜单
	 */
	@Override
	public List<TreeNode> queryMeNuTree(String id) {
		List<TreeNode> nodeList = new ArrayList<>();
		//根据父id查询菜单
		List<SysMenu> menuList = menuMapper.queryMenuByFdId(id);
		for (SysMenu sysMenu : menuList) {
			TreeNode node = new TreeNode();
			node.setId(sysMenu.getMenuId());
			node.setText(sysMenu.getMenuName());
			List<SysMenu> childList = menuMapper.queryMenuByFdId(sysMenu.getMenuId());;
			if (childList  != null && !childList.isEmpty()) {
				node.setState("closed");
			} else {
				node.setState("open");
			}
			node.getAttributes().put("level",sysMenu.getMenuIslink());
			nodeList.add(node);
		}
		return nodeList;
	}
	/**
	 * 根据id查菜单
	 */
	@Override
	public SysMenu queryMenuById(String id) {
		return menuMapper.selectByPrimaryKey(id);
	}
	/**
	 * 修改菜单
	 */
	@Override
	@Transactional()
	public int edit(SysMenu menu) {
		return menuMapper.updateByPrimaryKeySelective(menu);
	}
	/**
	 * 添加菜单
	 */
	@Override
	@Transactional()
	public  int add(SysMenu menu) {
		menu.setMenuId(UUID.randomUUID().toString());
		//根据id查询菜单级别
		String parentLink = menuMapper.queryMenuIsLink(menu.getSysMenuId());
		//添加菜单级别
		int numLink = Integer.valueOf(parentLink)+1;
		if (numLink > 3) {
			return 0;
		}
		menu.setMenuIslink(String.valueOf(numLink));
		menu.setMenuState("A");
		return menuMapper.insertSelective(menu);
	}
	/**
	 * 删除
	 */
	@Override
	@Transactional()
	public synchronized int del(String id) {
		SysMenu menu = menuMapper.selectByPrimaryKey(id);
		if(menu != null) {
			//查询子菜单id
			List<SysMenu> listMenu = menuMapper.queryMenuByFdId(id);
			if (null != listMenu && listMenu.size()>0) {
				for (SysMenu sysMenu : listMenu) {
					menuMapper.deleteByPrimaryKey(sysMenu.getMenuId());
				}			
			}
			return menuMapper.deleteByPrimaryKey(id);
		}else {
			return 0;
		}

	}
	/**
	 * 验证菜单名称是否重复
	 */
	@Override
	public int validateMenuName(String sysMenuId, String menuName,String menuId) {
		if (sysMenuId != null) {
			//根据父id验证菜单名称是否重复
			int count = menuMapper.validateBysysMenuIdAndMenuName(sysMenuId,menuName);
			return count;
		} else {
			//根据子id查询父id
			sysMenuId = menuMapper.querySysMenuIdByMenuId(menuId);
			//根据父id验证菜单名称是否重复
			int count = menuMapper.validateBysysMenuIdAndMenuName(sysMenuId,menuName);
			return count;
		}
	}

}
