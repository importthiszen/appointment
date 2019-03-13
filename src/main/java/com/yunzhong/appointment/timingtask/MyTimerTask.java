package com.yunzhong.appointment.timingtask;

import java.util.Date;
import java.util.TimerTask;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.yunzhong.appointment.illness.service.ApptService;
import com.yunzhong.appointment.util.ApplicationContextUtil;
/**
 * 定时删除未付款订单
 * @author 峰
 *
 */
public class MyTimerTask extends TimerTask{
	private String apId;
	
	private ApptService service;
    
	public MyTimerTask(String apId) {
		this.apId = apId;
		service = (ApptService) ApplicationContextUtil.getBean("ApptServiceImpl");
	}
	
	@Override
	public void run( ) {
		System.err.println(apId);
		int  tiao = service.TimeToDeleteOrder(apId);
		System.err.println("时间:"+new Date()+"自动检测订单"+apId+"是否超时未付款");
	}

	public String getApId() {
		return apId;
	}

	public void setApId(String apId) {
		this.apId = apId;
	}
	
	
}
