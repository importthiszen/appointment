package com.yunzhong.appointment.entity;


public class Illnessposition {
    private String illtpId;

    private String illtpName;
    

    public String getIlltpId() {
        return illtpId;
    }

    public void setIlltpId(String illtpId) {
        this.illtpId = illtpId == null ? null : illtpId.trim();
    }

    public String getIlltpName() {
        return illtpName;
    }

    public void setIlltpName(String illtpName) {
        this.illtpName = illtpName == null ? null : illtpName.trim();
    }

	@Override
	public String toString() {
		return "Illnessposition [illtpId=" + illtpId + ", illtpName="
				+ illtpName + "]";
	}
}