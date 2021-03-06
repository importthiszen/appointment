package com.yunzhong.appointment.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yunzhong.appointment.config.Const;
import com.yunzhong.appointment.entity.SysRole;
import com.yunzhong.appointment.entity.SysUser;
import com.yunzhong.appointment.entity.SysUserRole;
import com.yunzhong.appointment.mapper.PersonMapper;
import com.yunzhong.appointment.mapper.PatientMapper;
import com.yunzhong.appointment.mapper.SysRoleMapper;
import com.yunzhong.appointment.mapper.SysUserMapper;
import com.yunzhong.appointment.mapper.SysUserRoleMapper;
import com.yunzhong.appointment.system.service.SysUserService;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.SelectOptions;
/**
 * 
 * @className SysUserServiceImpl
 * @description 用户模型层实现类
 * @author 石洪刚
 * @time 2017年10月2日 下午11:32:01
 */
@Service
public class SysUserServiceImpl implements SysUserService{

	@Autowired
	private SysUserMapper userMapper;
	@Autowired
	private PatientMapper patientMapper;
	@Autowired
	private SysUserRoleMapper userRoleMapper;
	@Autowired
	private PersonMapper doctorMapper;
	@Autowired
	private SysRoleMapper roleMapper;
	@Override
	public List<SysUser> listUser(PageData pd) {
		pd.setPageData(pd);
		return userMapper.listUser(pd);
	}
	@Override
	public SysUser getUserById(String id) {
		return userMapper.selectByPrimaryKey(id);
	}
	@Override
	public SysUser getUserByUserName(String userName) {
		return userMapper.getUSerByUserName(userName);
	}
	
	@Override
	public void saveOrUpdateUser(SysUser user) {
		if("".equals(user.getUserId())){
			user.setUserId(UUID.randomUUID().toString());
			user.setUserState("A");
			String pass = new SimpleHash("SHA-1", user.getUserPass(), user.getUserPass()+Const.SALT).toString();
			user.setUserPass(pass);
			userMapper.insertSelective(user);
		}else{
			//修改患者中的数据
			patientMapper.updateUserInfo(user);
			if(!"".equals(user.getUserPass())){
				String pass = new SimpleHash("SHA-1", user.getUserPass(), user.getUserPass()+Const.SALT).toString();
				user.setUserPass(pass);
			}else{
				user.setUserPass(null);
			}
			userMapper.updateByPrimaryKeySelective(user);
		}
	}
	@Override
	public void removeUser(String[] ids) {
		for (String id : ids) {
			//删除用户角色表中相关数据
			userRoleMapper.removeByUserId(id);
			//设置医生表中外键为null
			doctorMapper.updateUserIdNullByUserId(id);
			//设置患者表中外键及用户名称为null
			patientMapper.updateUserInfoNullByUserId(id);
			//删除用户数据
			userMapper.deleteByPrimaryKey(id);
		}
	}
	@Override
	public List<SelectOptions> listRoleByUserId(String id) {
		//得到医生关联的角色主键
		List<String> userRoleList = roleMapper.listRoleByUserId(id);
		//得到所有角色
		List<SysRole> roleList = roleMapper.listRole();
		List<SelectOptions> opts = new ArrayList<SelectOptions>();
		for (SysRole role : roleList) {
			SelectOptions opt = new SelectOptions();
			opt.setLabel(role.getRoleId());
			opt.setValue(role.getRoleName());
			if(userRoleList.contains(role.getRoleId())){
				opt.setSelected(true);
			}else{
				opt.setSelected(false);
			}
			opts.add(opt);
		}
		return opts;
	}
	@Override
	public void updateAuthUser(String roleIds, String userId) {
		//删除原有用户角色信息
		userRoleMapper.deleteByUserId(userId);
		//增加新的用户角色信息
		String[] roleids = roleIds.split("@");
		for (String roleId : roleids) {
			SysUserRole ur = new SysUserRole();
			ur.setUrId(UUID.randomUUID().toString());
			ur.setUserId(userId);
			ur.setRoleId(roleId);
			userRoleMapper.insertSelective(ur);
		}
	}
	/**
	 * 没有被使用的用户并且角色不是患者和游客或   (**)   
	 */
	@Override
	public List<SysUser> queyUserByRoles(PageData pd) {
		pd.setPageData(pd);
		//查询用户
		List<SysUser> userList = userMapper.queryUserByRoleNames(pd);
		if (null != userList && userList.size()>0) {
			for (SysUser sysUser : userList) {
				//根据userid查询用户角色名和角色描述
				List<SysRole> roleList =  roleMapper.queryRoleNameAndInfoByUserId(sysUser.getUserId());
				if (null != roleList && roleList.size()>0) {
					String roleName = "";
					for (SysRole sysRole : roleList) {
						roleName = roleName + sysRole.getRoleName() + " - ";
					}
					if (!roleName.equals("")) {
						roleName = roleName.substring(0,roleName.length()-3);
					}
					sysUser.setRoleName(roleName);
				}
			}
		}
		return userList;
	}
	/**
	 * 查询是否有非患者的用户
	 */
	@Override
	public int queryPerUserCount() {
		return userMapper.queryPerUserCount();
	}
	/**
	 * 根据人员里的userid查询user
	 */
	@Override
	public List<SysUser> queryByPERUserid(String userId) {
		// TODO Auto-generated method stub
		return userMapper.selectByPERUserid(userId);
	}
	/**
	 * 查询权限user权限是否是医生
	 */
	@Override
	public int queryUserRoles(String userId) {
		List<SysUser> userList = userMapper.selectByPERUserid(userId);
		for (SysUser sysUser : userList) {
			if (sysUser.getRoleId().equals("a166332c-2a1b-48ef-81d7-b37fdaa874r5")) {
				return 1;
			}
		}
		return 0;
	}
}
