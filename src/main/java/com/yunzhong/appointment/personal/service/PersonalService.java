package com.yunzhong.appointment.personal.service;

import java.util.List;

import com.yunzhong.appointment.entity.Appointmentorder;
import com.yunzhong.appointment.entity.Patient;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Province;
import com.yunzhong.appointment.util.PageData;

public interface PersonalService {
    /**
     * 根据用户名查询患者信息
     * @param userName
     * @return
     */
	Patient queryPatientByuserName(String userName);
    /**
     * 查询省
     * @return
     */
	List<Province> queryProvince();
	/**
	 * 修改患者个人信息
	 * @param pt
	 * @return
	 */
	int editPatient(Patient pt);
	/**
	 * 上传图片
	 * @param image
	 * @return
	 */
	int addimg(String image,String id,String uerName);
	/**
	 * 
	 * @param pt
	 * @return
	 */
	int editpass(Patient pt,String pass);
	/**
	 * 查询患者订单
	 * @param order_state
	 * @return list
	 */
	List<Appointmentorder> querylistOrder(PageData pd,String order_state);
	/**
	 * 根据订单id取消订单
	 * @param id
	 * @return
	 */
	int cancelOrder(String id);
	/**
	 * 根据用户名查询人员
	 * @param userName
	 * @return
	 */
	Person queryPersonByuserName(String userName);
	

}
