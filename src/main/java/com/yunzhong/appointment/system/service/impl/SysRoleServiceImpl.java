package com.yunzhong.appointment.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yunzhong.appointment.entity.SysRole;
import com.yunzhong.appointment.entity.SysRoleMenu;
import com.yunzhong.appointment.entity.SysUser;
import com.yunzhong.appointment.mapper.SysMenuMapper;
import com.yunzhong.appointment.mapper.SysRoleMapper;
import com.yunzhong.appointment.mapper.SysRoleMenuMapper;
import com.yunzhong.appointment.mapper.SysUserRoleMapper;
import com.yunzhong.appointment.system.service.SysRoleService;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.SelectOptions;
@Service
public class SysRoleServiceImpl implements SysRoleService {

	@Autowired
	private SysRoleMapper roleMapper;
	@Autowired
	private SysUserRoleMapper userRoleMapper;
	@Autowired
	private SysRoleMenuMapper roleMenuMapper;
	@Autowired 
	private SysMenuMapper menuMapper;
	@Autowired 
	private SysRoleMenuMapper sysRoleMenuMapper;
	/**
	 * 查询角色列表
	 */
	@Override
	public List<SysRole> listRole(PageData pd) {
		pd.setPageData(pd);
		return roleMapper.querylistRole(pd);
	}
	/**
	 * 根据角色主键查询角色信息
	 */
	@Override
	public SysRole getRoleById(String id) {
		// TODO Auto-generated method stub
		return roleMapper.selectByPrimaryKey(id);
	}
	@Override
	public int getRoleByRoleName(String roleName) {
		// TODO Auto-generated method stub
		return roleMapper.getRoleByRoleName(roleName);
	}
	/**
	 * 增加或修改用户信息
	 */
	@Override
	public void saveOrUpdateRole(SysRole role) {
		if("".equals(role.getRoleId())){
					role.setRoleId(UUID.randomUUID().toString());
					role.setRoleState("A");
					roleMapper.insertSelective(role);
				}else{
					//修改角色的数据			
					roleMapper.updateByPrimaryKeySelective(role);
				}	
	}
	/**
	 * 删除角色信息
	 */
	@Override
	public void removeRole(String[] ids) {
		for (String id : ids) {
		//删除用户角色表中相关数据
			userRoleMapper.removeByRoleId(id);
		//删除菜单角色表中相关数据
			roleMenuMapper.removeByRoleId(id);
		//删除角色数据
			roleMapper.deleteByPrimaryKey(id);
		}		
	}
	/**
	 * 查询授权菜单
	 */
	@Override
	public List<SelectOptions> queryRoleMenu(String id) {
		// 查询导航模块信息
		List<SelectOptions> topList = menuMapper.queryTopMenu();
		//根据ID查询菜单角色表
		List<SysRoleMenu> srmList = sysRoleMenuMapper.queryMenuByRoleId(id);
		List<SelectOptions> rvList = new ArrayList<SelectOptions>();
		for (SelectOptions sp : topList) {
			for(int i = 0; i < srmList.size(); i++) {
				if(srmList.get(i).getMenuId().equals(sp.getLabel())) {
					sp.setSelected(true);
				}
			}
			SelectOptions rv = this.recursiveMenuByTopMenuWithOptions(srmList,sp);
			rvList.add(rv);
		}		
		return rvList;
	}
	//递归
	private SelectOptions recursiveMenuByTopMenuWithOptions(List<SysRoleMenu> srmList,SelectOptions sp) {
		//根据菜单Id查询大菜单下的子菜单
		List<SelectOptions> childMenus = menuMapper.queryMenuByOneWithOptions(sp);
		for (SelectOptions sysMenu : childMenus) {
			for (int i = 0; i < srmList.size(); i++) {
				if(srmList.get(i).getMenuId().equals(sysMenu.getLabel())){
					sp.setSelected(true);
					sysMenu.setSelected(true);
					break;
				}
			}
			SelectOptions m = recursiveMenuByTopMenuWithOptions(srmList,sysMenu);
			sp.getSelectList().add(m);
		}
		return sp;
	}
	/**
	 * 提交授权
	 * @return 
	 */
	@Override
	public SysRole roleMenu(String menuIds,String roleId) {
		sysRoleMenuMapper.deleteByPrimaryKey(roleId);
		System.err.println(menuIds);
		if(!"".equals(menuIds)){
			String[] ids = menuIds.split(",");
			for (int i = 0; i < ids.length; i++) {
				SysRoleMenu srm = new SysRoleMenu();
				srm.setRmId(UUID.randomUUID().toString());
				srm.setMenuId(ids[i]);
				srm.setRoleId(roleId);
				sysRoleMenuMapper.insertSelective(srm);
			}
		}
		return  roleMapper.selectByPrimaryKey(roleId);
		}
	


}
