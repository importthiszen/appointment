package com.yunzhong.appointment.util;
/**
 * ajax返回结果封装类
 * @author 于占峰
 *2019年2月28日11:26:55
 */
public class ResultJson {
	private boolean success;
	private String msg;
	private Object obj;
	
	public boolean isSuccess() {
		return success;
	}
	public void setSuccess(boolean success) {
		this.success = success;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
}
