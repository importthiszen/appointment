package com.yunzhong.appointment.illness.service;

import java.util.List;

import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Scheduling;
import com.yunzhong.appointment.util.PageData;

public interface ApptService {
     /**
      * 根据医生id查询未来九天的排班
      * @param ppId
      * @return
      * 2019年3月7日14:01:31
      * list
      */
	List<Scheduling> queryDoctorSchedulingById(String ppId);
    /**
     * 根据主键查询医生
     * @param ppId
     * @return
     */
	Person selectDoctorByPpid(String ppId);
	/**
	 * 查询基础费用
	 * @return
	 */
	String quryBassfee();
	/**
	 * 添加预约订单
	 * 于占峰
	 * @param pd
	 * @return int
	 * 2019年3月8日11:55:28
	 */
	int addAppointmentorder(PageData pd);
	/**
	 * 自动删除订单
	 * @return
	 */
	int TimeToDeleteOrder(String apId);


}
