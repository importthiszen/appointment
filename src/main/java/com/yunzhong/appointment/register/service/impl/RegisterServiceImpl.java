package com.yunzhong.appointment.register.service.impl;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yunzhong.appointment.config.Const;
import com.yunzhong.appointment.entity.City;
import com.yunzhong.appointment.entity.Patient;
import com.yunzhong.appointment.entity.Province;
import com.yunzhong.appointment.entity.SysUser;
import com.yunzhong.appointment.entity.SysUserRole;
import com.yunzhong.appointment.mapper.CityMapper;
import com.yunzhong.appointment.mapper.PatientMapper;
import com.yunzhong.appointment.mapper.ProvinceMapper;
import com.yunzhong.appointment.mapper.SysRoleMapper;
import com.yunzhong.appointment.mapper.SysUserMapper;
import com.yunzhong.appointment.mapper.SysUserRoleMapper;
import com.yunzhong.appointment.register.service.RegisterService;

@Service
public class RegisterServiceImpl implements RegisterService {
	/**
	 * 省接口
	 */
	@Autowired
	private ProvinceMapper proMapper;
	/**
	 * 患者接口
	 */
	@Autowired
	private PatientMapper patientMapper;
	/**
	 * 用户接口
	 */
	@Autowired
	private SysUserMapper userMapper;
	/**
	 * 用户角色中间表接口
	 */
	@Autowired
	private SysUserRoleMapper urMapper;
	/**
	 * 角色接口
	 */
	@Autowired
	private SysRoleMapper roleMapper;

	/**
	 * 查询省下拉框
	 */
	@Override
	public List<Province> queryProvince() {
		return proMapper.queryAll();
	}

	/**
	 * 患者注册添加
	 */
	@Transactional
	@Override
	public int registerAddSave(Patient pt) {
		int tiao = 0;
		if (pt != null) { // 如果不为空
			SysUser user = new SysUser();
			// 添加用户
			user.setUserId(UUID.randomUUID().toString());
			user.setUserName(pt.getPatientTel());
			//加密密码
    		String passwd = new SimpleHash("SHA-1", pt.getUserPass(), pt.getUserPass()+Const.SALT).toString();
			user.setUserPass(passwd);
			user.setUserInfo("患者,可进行预约");
			user.setUserNickname(pt.getPatientName());
			user.setUserState("A");
			tiao = userMapper.insertSelective(user);
			if (tiao > 0) { // 如果添加用户成功
				// 添加患者
				pt.setPatientId(UUID.randomUUID().toString());
				pt.setUserId(user.getUserId());
				pt.setPatientTime(new Date());
				tiao = patientMapper.insertSelective(pt);
				if (tiao > 0) { // 如果添加患者成功
					// 关联用户患者角色
					SysUserRole UserRole = new SysUserRole();
					UserRole.setUrId(UUID.randomUUID().toString());
					UserRole.setUserId(user.getUserId());
					// 查询患者角色id
					String RoleId = roleMapper.queryRoleId();
					UserRole.setRoleId(RoleId);
					tiao = urMapper.insert(UserRole);
					if (tiao > 0) {// 如果关联角色成功
						return tiao;
					} else {
						return -3;//关联用户角色失败
					}
				} else {
					return -2;  //添加患者失败
				}

			} else {

				return -1; //添加用户失败
			}

		} else {
			return tiao;
		}

	}
    /**
     * 验证手机号是否重复
     */
	@Override
	public int NameRepetition(String account) {
		return userMapper.NameRepetition(account);
	}
	/**
	 * 验证患者信息是否存在
	 * @param pt
	 * @return
	 * 2019年3月1日18:21:04
	 * boolean
	 */
	@Override
	public Boolean verify(Patient pt) {
		boolean bj = false;
		String name = pt.getPatientName();
		String uid = pt.getPatientUid();
		String tel = pt.getPatientTel();
		int tiao = patientMapper.verifyByNameAndUidOrTel(name,uid,tel);
		if (tiao>0) {
			bj = true;
		}
		return bj; 
	}
    /**
     * 重置患者密码
     */
	@Override
	public int recoverpass(Patient pt) {
		String userName = pt.getPatientTel();
		//加密密码
		String passwd = new SimpleHash("SHA-1", pt.getUserPass(), pt.getUserPass()+Const.SALT).toString();
		return userMapper.recoverpass(userName,passwd);
	}

}
