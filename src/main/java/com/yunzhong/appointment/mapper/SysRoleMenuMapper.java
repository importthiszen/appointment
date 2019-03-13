package com.yunzhong.appointment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;

import com.yunzhong.appointment.entity.SysRoleMenu;

public interface SysRoleMenuMapper {
    int deleteByPrimaryKey(String rmId);

    int insert(SysRoleMenu record);

    int insertSelective(SysRoleMenu record);

    SysRoleMenu selectByPrimaryKey(String rmId);

    int updateByPrimaryKeySelective(SysRoleMenu record);

    int updateByPrimaryKey(SysRoleMenu record);
/**
 * 删除菜单角色表中相关数据
 * @param id RoleId
 */
    @Delete("DELETE FROM sys_role_menu where role_id=#{param1}")
	void removeByRoleId(String id);
/**
 * 根据roleId查询菜单角色中间表信息
 * @param id
 * @return
 */
List<SysRoleMenu> queryMenuByRoleId(String id);
}