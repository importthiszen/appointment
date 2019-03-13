package com.yunzhong.appointment.register.service;

import java.util.List;

import com.yunzhong.appointment.entity.City;
import com.yunzhong.appointment.entity.Patient;
import com.yunzhong.appointment.entity.Province;

public interface RegisterService {
    /**
     * 查询省下拉框
     * @return
     */
	List<Province> queryProvince();
    /**
     * 患者注册添加
     * @param pt
     * @return
     */
	int registerAddSave(Patient pt);
	/**
	 * 验证手机号是否存在
	 * @param account
	 * @return
	 * 2019年3月1日13:59:16
	 * boolean
	 */ 
	int NameRepetition(String account);
	/**
	 * 验证患者信息是否存在
	 * @param pt
	 * @return
	 * 2019年3月1日18:21:04
	 * boolean
	 */
	Boolean verify(Patient pt);
	/**
	 * 重置密码
	 * @param pt
	 * @return int
	 * 2019年3月1日19:42:28
	 * 
	 */
	int recoverpass(Patient pt);
   
}
