package com.yunzhong.appointment.mapper;

import java.util.List;
import java.util.Set;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.SysRole;
import com.yunzhong.appointment.util.PageData;

public interface SysRoleMapper {
    int deleteByPrimaryKey(String roleId);

    int insert(SysRole record);

    int insertSelective(SysRole record);

    SysRole selectByPrimaryKey(String roleId);

    int updateByPrimaryKeySelective(SysRole record);

    int updateByPrimaryKey(SysRole record);
   
    /**
     * @description 根据角色名称查询角色信息
     * @author 石洪刚
     * @time 2017年8月10日11:11:23
     * @param roleId
     * @return
     */
    @Select("select role_name from sys_role where role_id=#{roleId}")
	String getRoleNameById(String roleId);
    /**
     * @description 根据用户主键查询用户所有角色名称
     * @author 石洪刚
     * @time 2017年8月10日11:12:27
     * @param userId
     * @return
     */
    @Select("SELECT role_name FROM sys_role WHERE role_id IN (SELECT role_id FROM sys_user_role WHERE user_id = #{userId})")
    @ResultType(Set.class)
	Set<String> listRoleNamesByUserId(String userId);
    /**
     * 
     * @methodName listRole
     * @description 得到角色数据
     * @author 石洪刚
     * @time 2017年10月6日 上午11:44:06
     * @return
     */
    @Select("select role_id,role_name from sys_role")
    @ResultMap("BaseResultMap")
	List<SysRole> listRole();
    /**
     * 
     * @methodName listRoleByUserId
     * @description 根据用户主键得到用户关联的角色主键
     * @author 石洪刚
     * @time 2017年10月6日 上午11:21:20
     * @param id
     * @return
     */
    @Select("select sr.role_id from sys_role sr left join sys_user_role sur on sr.role_id = sur.role_id where sur.user_id=#{id}")
	@ResultType(String.class)
    List<String> listRoleByUserId(String id);
     /**
      * 查询角色id
      * @return
      */
    @Select("SELECT\n" + 
    		"sys_role.role_id\n" + 
    		"FROM\n" + 
    		"sys_role\n" + 
    		"WHERE sys_role.role_name = 'patient'")
	String queryRoleId();
/**
 * 查询角色列表
 * @param pd
 * @return
 */
	List<SysRole> querylistRole(PageData pd);
/**
 * 验证角色名称是否重复
 * @param roleName
 * @return
 */
    int getRoleByRoleName(String roleName);
/**
 * 根据userid查询用户角色名和角色描述
 * @param userId
 * @return
 */
    @Select("SELECT\n" + 
    		"sys_role.role_id,\n" + 
    		"sys_role.role_name,\n" + 
    		"sys_role.role_state,\n" + 
    		"sys_role.role_info\n" + 
    		"FROM\n" + 
    		"sys_role\n" + 
    		"INNER JOIN sys_user_role ON sys_user_role.role_id = sys_role.role_id\n" + 
    		"where sys_user_role.user_id=#{0} ")
    @ResultMap("BaseResultMap")
    List<SysRole> queryRoleNameAndInfoByUserId(String userId);

    
}