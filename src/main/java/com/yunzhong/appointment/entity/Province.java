package com.yunzhong.appointment.entity;

public class Province {
    private String provinceId;

    private String provinceName;

    public String getProvinceId() {
        return provinceId;
    }

    public void setProvinceId(String provinceId) {
        this.provinceId = provinceId == null ? null : provinceId.trim();
    }

    public String getProvinceName() {
        return provinceName;
    }

    public void setProvinceName(String provinceName) {
        this.provinceName = provinceName == null ? null : provinceName.trim();
    }

	@Override
	public String toString() {
		return "Province [provinceId=" + provinceId + ", provinceName=" + provinceName + "]";
	}
}