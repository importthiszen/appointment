package com.yunzhong.appointment.entity;

import java.util.Date;

public class Person {
    private String ppId;

    private String userId;

    private String userName;
    
    private String ppName;

    private String ppInfo;

    private String doctorDomain;

    private String ppState;

    private Date ppTime;

    private String departmentId;

    private String departmentName;

    private String professionalId;

    private String professionalName;

    private Double doctorPay;

    private String ppPic;

    private String standby;
    
    private String illName;
    private String illInfo;
    private String visitPlan;
    private String illId;
    private Date schedulingDate;

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName==null?null:userName.trim();
	}
	public String getPpId() {
		return ppId;
	}

	public void setPpId(String ppId) {
		this.ppId = ppId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPpName() {
		return ppName;
	}

	public void setPpName(String ppName) {
		this.ppName = ppName;
	}

	public String getPpInfo() {
		return ppInfo;
	}

	public void setPpInfo(String ppInfo) {
		this.ppInfo = ppInfo;
	}

	public String getDoctorDomain() {
		return doctorDomain;
	}

	public void setDoctorDomain(String doctorDomain) {
		this.doctorDomain = doctorDomain;
	}

	public String getPpState() {
		return ppState;
	}

	public void setPpState(String ppState) {
		this.ppState = ppState;
	}

	public Date getPpTime() {
		return ppTime;
	}

	public void setPpTime(Date ppTime) {
		this.ppTime = ppTime;
	}

	public String getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(String departmentId) {
		this.departmentId = departmentId==null?null:departmentId.trim();
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName==null?null:departmentName.trim();
	}

	public String getProfessionalId() {
		return professionalId;
	}

	public void setProfessionalId(String professionalId) {
		this.professionalId = professionalId==null?null:professionalId.trim();
	}

	public String getProfessionalName() {
		return professionalName;
	}

	public void setProfessionalName(String professionalName) {
		this.professionalName = professionalName==null?null:professionalName.trim();
	}

	public Double getDoctorPay() {
		return doctorPay;
	}

	public void setDoctorPay(Double doctorPay) {
		this.doctorPay = doctorPay;
	}

	public String getPpPic() {
		return ppPic;
	}

	public void setPpPic(String ppPic) {
		this.ppPic = ppPic;
	}

	public String getStandby() {
		return standby;
	}

	public void setStandby(String standby) {
		this.standby = standby;
	}


	public String getIllName() {
		return illName;
	}

	public void setIllName(String illName) {
		this.illName = illName;
	}

	public String getIllInfo() {
		return illInfo;
	}

	public void setIllInfo(String illInfo) {
		this.illInfo = illInfo;
	}

	public String getVisitPlan() {
		return visitPlan;
	}

	public void setVisitPlan(String visitPlan) {
		this.visitPlan = visitPlan;
	}

	public String getIllId() {
		return illId;
	}

	public void setIllId(String illId) {
		this.illId = illId;
	}

	public Date getSchedulingDate() {
		return schedulingDate;
	}

	public void setSchedulingDate(Date schedulingDate) {
		this.schedulingDate = schedulingDate;
	}

   
}