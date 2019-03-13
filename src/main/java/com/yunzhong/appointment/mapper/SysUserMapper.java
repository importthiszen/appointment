package com.yunzhong.appointment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.yunzhong.appointment.entity.SysUser;
import com.yunzhong.appointment.util.PageData;

public interface SysUserMapper {
    int deleteByPrimaryKey(String userId);

    int insert(SysUser record);

    int insertSelective(SysUser record);

    SysUser selectByPrimaryKey(String userId);

    int updateByPrimaryKeySelective(SysUser record);

    int updateByPrimaryKey(SysUser record);
    
    /**
     * @description 根据用户名和密码查询用户对象
     * @author 石洪刚
     * @time 2017年8月10日11:28:36
     * @param user1
     * @return
     */
    @Select("select * from sys_user where user_name = #{userName} and user_pass=#{userPass}")
    @ResultMap("BaseResultMap")
	SysUser getUserByNameAndPass(SysUser user1);
    
    /**
     * @description 根据用户名查询用户对象
     * @author 石洪刚
     * @time 2017年8月10日11:29:17
     * @param username
     * @return
     */
    @Select("select user_id, user_name, user_pass, user_nickname, user_state, user_info from sys_user where user_name = #{userName}")
    @ResultMap("BaseResultMap")
	SysUser getUserByName(String username);
    
    /**
	 * @description 查询未关联用户
	 * @author 石洪刚
	 * @time 2017年9月12日10:47:45
	 * @return
	 */
    @Select("SELECT su.user_id,su.user_name FROM sys_user su "+
    		" LEFT JOIN person p on su.user_id = p.user_id "+
    		" LEFT JOIN patient pat on su.user_id = pat.user_id "+
    		"WHERE "+
    		" p.user_id is null and pat.user_id is null and su.user_name <> 'GUEST'")
    @ResultMap("BaseResultMap")
	List<SysUser> listUserNotLinked();
    
    /**
	 * @description 根据医生主键查询被关联用户
	 * @param id
	 * @return
	 */
    @Select("select user_id,user_name from sys_user where user_id = (select user_id from person where pp_id = #{id})")
    @ResultMap("BaseResultMap")
	SysUser getLinkedUserByPpId(String id);
    /**
     * 
     * @methodName listUser
     * @description 查询用户数据
     * @author 石洪刚
     * @time 2017年10月2日 下午11:46:14
     * @param pd
     */
    List<SysUser> listUser(PageData pd);
    /**
     * 
     * @methodName getUSerByUserName
     * @description 根据登录名得到一个用户对象
     * @author 石洪刚
     * @time 2017年10月5日 上午8:12:57
     * @param userName
     * @return
     */
    @Select("select user_id from sys_user where user_name = #{userName}")
    @ResultMap("BaseResultMap")
	SysUser getUSerByUserName(String userName);
    /**
     * 查询手机号是否重复
     * @param account
     * @return
     */
    @Select("SELECT\n" + 
    		"COUNT(*)\n" + 
    		"FROM\n" + 
    		"sys_user WHERE sys_user.user_name = #{param1}")
	int NameRepetition(String account);
    /**
     * 根据用户名 修改 密码
     * @param userName
     * @param passwd
     * @return
     */
    @Update("UPDATE  sys_user\n" + 
    		"SET \n" + 
    		"sys_user.user_pass = #{param2}\n" + 
    		"WHERE sys_user.user_name = #{param1}")
	int recoverpass(String userName, String passwd);
    /**
     * 根据用户id获取用户名
     * @param userId
     * @return
     */
    @Select("select user_name  from sys_user where  user_id = #{0}")
	String getUserNameByUserId(String userId);
   
    /**
     * 没有被使用的用户并且角色并且不是患者或    (**)   可自己增加
     * @param pd 
     * @return
     */
	List<SysUser> queryUserByRoleNames(PageData pd);
    /**
     * 查询是否有非患者的用户
     * @param patient
     * @param guest
     * @return
     */
    @Select("SELECT\n" + 
    		"	count(*)\n" + 
    		"FROM\n" + 
    		"	sys_user_role\n" + 
    		"INNER JOIN sys_user ON sys_user_role.user_id = sys_user.user_id\n" + 
    		"INNER JOIN sys_role ON sys_user_role.role_id = sys_role.role_id\n" + 
    		"WHERE\n" + 
    		"	sys_user.user_id NOT IN (\n" + 
    		"		SELECT\n" + 
    		"			sys_user.user_id\n" + 
    		"		FROM\n" + 
    		"			sys_user\n" + 
    		"		INNER JOIN person ON person.user_id = sys_user.user_id\n" + 
    		"	)\n" + 
    		"AND sys_user.user_id NOT IN (\n" + 
    		"	SELECT\n" + 
    		"		sys_user.user_id\n" + 
    		"	FROM\n" + 
    		"		sys_user\n" + 
    		"	INNER JOIN patient ON patient.user_id = sys_user.user_id\n" + 
    		")\n" + 
    		" and sys_user.user_state = 'A'"+
    		"AND sys_role.role_name NOT IN (\n" + 
    		"	'guest','patient')")
	int queryPerUserCount();
    /**
     * 根据人员里的userid查询user
     * @param userId
     * @return
     */
    @Select("SELECT\n"+
    		"	sys_user.user_id,\n" + 
    		"	sys_user.user_name,\n" + 
    		"	sys_user.user_pass,\n" + 
    		"	sys_user.user_nickname,\n" + 
    		"	sys_user.user_state,\n" + 
    		"	sys_user.user_info,\n" + 
    		"	sys_role.role_id,\n" + 
    		"	sys_role.role_name,\n" + 
    		"	sys_role.role_state,\n" + 
    		"	sys_role.role_info\n" + 
    		"FROM\n" + 
    		"	sys_user_role\n" + 
    		"inner JOIN sys_user ON sys_user_role.user_id = sys_user.user_id\n" + 
    		"inner JOIN sys_role ON sys_user_role.role_id = sys_role.role_id\n" +
    		"where sys_user.user_id=#{0}")
    @ResultMap("BaseResultMap")
	List<SysUser> selectByPERUserid(String userId);
   
}