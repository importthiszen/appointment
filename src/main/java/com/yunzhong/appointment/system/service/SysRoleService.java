package com.yunzhong.appointment.system.service;

import java.util.List;
import java.util.UUID;

import org.apache.shiro.crypto.hash.SimpleHash;

import com.yunzhong.appointment.config.Const;
import com.yunzhong.appointment.entity.SysRole;
import com.yunzhong.appointment.entity.SysUser;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.SelectOptions;

public interface SysRoleService {

	List<SysRole> listRole(PageData pd);
/**
 * 根据ID查角色信息
 * @param id
 * @return
 */
	SysRole getRoleById(String id);
	/**
	 * 验证角色名称是否重复
	 * @param roleName
	 * @return
	 */
	int getRoleByRoleName(String roleName);
/**
 * 增加或修改用户信息
 * @param role
 */
	void saveOrUpdateRole(SysRole role);
/**
 * 
 * @param ids
 */
void removeRole(String[] ids);
/**
 * 查询授权菜单
 * @param id
 * @return
 */
List<SelectOptions> queryRoleMenu(String id);
/**
 * 提交授权
 * @param roleId
 * @param menuIds
 * @return 
 */
SysRole roleMenu(String menuIds,String roleId);

}
