package com.yunzhong.appointment.mapper;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.SysMenu;
import com.yunzhong.appointment.util.SelectOptions;

public interface SysMenuMapper {
    int deleteByPrimaryKey(String menuId);

    int insert(SysMenu record);

    int insertSelective(SysMenu record);

    SysMenu selectByPrimaryKey(String menuId);

    int updateByPrimaryKeySelective(SysMenu record);

    int updateByPrimaryKey(SysMenu record);
    
    /**
     * @description 根据用户主键查询用户拥有的合法请求
     * @author 石洪刚
     * @time 2017年8月10日11:36:42
     * @param userId
     * @return
     */
    @Select("select sm.MENU_URL from sys_menu sm "+
			"  left join sys_role_menu srm on sm.MENU_ID=srm.MENU_ID "+
			"  left join sys_role sr on srm.ROLE_ID=sr.ROLE_ID "+
			"  left join sys_user_role sur on sr.ROLE_ID=sur.ROLE_ID "+
			"  where sur.USER_ID=#{userId}")
    @ResultType(Set.class)
	Set<String> listPermissionsByUserId(String userId);
    
    /**
     * @description 根据父菜单查询下级子菜单
     * @author 石洪刚
     * @time 2017年8月10日13:51:29
     * @param menu
     * @return
     */
    @Select("select menu_id, sys_menu_id, menu_name, menu_url, menu_islink, menu_sequ, menu_state, menu_info from sys_menu where sys_menu_id=#{menuId} order by menu_sequ")
    @ResultMap("BaseResultMap")
	List<SysMenu> listMenuByPar(SysMenu menu);
    
    /**
     * @description 根据用户主键查询一级菜单
     * @author 石洪刚
     * @time 2017年8月10日19:36:04
     * @param userId
     * @return
     */
    @Select("select sm.menu_id, sm.sys_menu_id, sm.menu_name, sm.menu_url, sm.menu_islink, sm.menu_sequ, sm.menu_state, sm.menu_info from sys_menu sm "+
			"  left join sys_role_menu srm on sm.MENU_ID=srm.MENU_ID "+
			"  left join sys_role sr on srm.ROLE_ID=sr.ROLE_ID "+
			"  left join sys_user_role sur on sr.ROLE_ID=sur.ROLE_ID "+
			"  where sur.USER_ID=#{userId} and sm.menu_islink=1"
			+ " order by sm.menu_sequ")
    @ResultMap("BaseResultMap")
	List<SysMenu> listTopMenuByUserId(String userId);
    /**
     * @description 查询游客一级菜单
     * @author 石洪刚
     * @time 2017年8月29日20:36:32
     * @return
     */
    @Select("select sm.menu_id, sm.sys_menu_id, sm.menu_name, sm.menu_url, sm.menu_islink, sm.menu_sequ, sm.menu_state, sm.menu_info from sys_menu sm "+
			"  left join sys_role_menu srm on sm.MENU_ID=srm.MENU_ID "+
			"  left join sys_role sr on srm.ROLE_ID=sr.ROLE_ID "+
			"  left join sys_user_role sur on sr.ROLE_ID=sur.ROLE_ID "+
			"  left join sys_user su on sur.USER_ID=su.USER_ID "+
			"  where su.USER_NAME='GUEST' and sm.menu_islink=1"
			+ " order by sm.menu_sequ")
    @ResultMap("BaseResultMap")
	List<SysMenu> listGuestTopMenu();
	/**
	 * @description 根据上级菜单主键及用户查出该用户所属的下级菜单
	 * @author 石洪刚
	 * @time 2017年8月29日20:22:26
	 * @param m
	 * @return
	 */
	@Select("SELECT menu_id, sys_menu_id, menu_name, menu_url, menu_islink, menu_sequ, menu_state, menu_info FROM sys_menu WHERE sys_menu_id = #{menuId} and menu_id in (SELECT menu_id FROM sys_role_menu WHERE role_id in (SELECT role_id FROM sys_user_role WHERE user_id = #{userId})) order by menu_sequ")
	@ResultMap("BaseResultMap")
	List<SysMenu> listMenuByParIdAndUserId(Map m);
	/**
	 * @description 得到游客特定菜单所有下级菜单
	 * @author 石洪刚
	 * @time 2017年8月29日20:43:18
	 * @param menu
	 * @return
	 */
	@Select("SELECT menu_id, sys_menu_id, menu_name, menu_url, menu_islink, menu_sequ, menu_state, menu_info FROM sys_menu WHERE sys_menu_id = #{menuId} and menu_id in (SELECT menu_id FROM sys_role_menu WHERE role_id in (SELECT role_id FROM sys_user_role WHERE user_id = (select user_id from sys_user where user_name='GUEST'))) order by menu_sequ")
	@ResultMap("BaseResultMap")
	List<SysMenu> listGuestMenuByParId(SysMenu menu);
	
	/**
	 * @description 查询个人中心菜单
	 * @author 石洪刚
	 * @time 2017年8月31日10:03:46
	 * @return
	 */
	@Select("select menu_id, sys_menu_id, menu_name, menu_url, menu_islink, menu_sequ, menu_state, menu_info from sys_menu where menu_name='个人中心'")
	@ResultMap("BaseResultMap")
	SysMenu getPersonalMenu();
	
	/**
	 * 
	 * @methodName listTopMenu
	 * @description 得到所有一级菜单
	 * @author 石洪刚
	 * @time 2017年10月2日 下午7:44:12
	 * @return
	 */
	 @Select("select sm.menu_id, sm.sys_menu_id, sm.menu_name, sm.menu_url, sm.menu_islink, sm.menu_sequ, sm.menu_state, sm.menu_info from sys_menu sm  where sm.menu_islink=1 order by sm.menu_sequ")
	 @ResultMap("BaseResultMap")
	List<SysMenu> listTopMenu();
	/**
	 * 
	 * @methodName getMenuWithParNameById
	 * @description 根据菜单主键得到菜单信息，及父菜单名称
	 * @author 石洪刚
	 * @time 2017年10月2日 下午10:43:45
	 * @param id
	 * @return
	 */
	 @Select("select menu.menu_id,menu.menu_info,menu.menu_islink,menu.menu_name,menu.menu_sequ,menu.menu_url,menu.sys_menu_id,parmenu.menu_name par_name from sys_menu menu "
	 		+ " left join sys_menu parmenu on menu.sys_menu_id=parmenu.menu_id "
	 		+ " where menu.menu_id=#{id}")
	 @ResultMap("BaseResultMap")
	SysMenu getMenuWithParNameById(String id);
	/**
	 * 根据父id查询子菜单 
	 * @param id
	 * @return
	 */
	@Select("SELECT sys_menu.menu_id,sys_menu.menu_name,sys_menu.sys_menu_id,\n" + 
			"sys_menu.menu_url,sys_menu.menu_islink,sys_menu.menu_sequ,\n" + 
			"sys_menu.menu_state,sys_menu.menu_info\n" + 
			"FROM sys_menu\n" + 
			"where sys_menu.sys_menu_id=#{0} and sys_menu.menu_id != '0'")
	@ResultMap("BaseResultMap")
	List<SysMenu> queryMenuByFdId(String id);
	/**
	 * 根据id查询菜单级别
	 * @param sysMenuId
	 * @return
	 */
	@Select("SELECT sys_menu.menu_islink FROM sys_menu where sys_menu.menu_id=#{0} ")
	String queryMenuIsLink(String sysMenuId);
	/**
	 * 根据父id查询子菜单数量
	 * @param id
	 * @return
	 */
	@Select("SELECT count(*) FROM sys_menu where sys_menu.sys_menu_id=#{0} ")
	int queryCountByParentId(String id);
	/**
	 * 根据父id和菜单名查询相同菜单条数
	 * @param sysMenuId
	 * @param menuName
	 * @return
	 */
	@Select("SELECT count(*) FROM sys_menu where sys_menu.sys_menu_id=#{param1} and sys_menu.menu_name=trim(#{param2}) ")
	int validateBysysMenuIdAndMenuName(String sysMenuId, String menuName);
	/**
	 * 根据子id查询父id
	 * @param menuId
	 * @return
	 */
	@Select("SELECT sys_menu_id FROM sys_menu where sys_menu.menu_id=#{0}")
	String querySysMenuIdByMenuId(String menuId);
/**
 * 查询导航栏菜单
 * @return
 */	
	List<SelectOptions> queryTopMenu();
/**
 * 查询子菜单
 * @param sp
 * @return
 */
List<SelectOptions> queryMenuByOneWithOptions(SelectOptions sp);
}