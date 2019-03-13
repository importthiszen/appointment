package com.yunzhong.appointment.entity;

import java.io.Serializable;
import java.util.List;

public class Departmenttype implements Serializable {
    private String dplId;

    private String dplName;
    
    private String dpId;
    
    private List<Department> depeList;

     
    @Override
	public String toString() {
		return "Departmenttype [dplId=" + dplId + ", dplName=" + dplName + ", dpId=" + dpId + ", depeList=" + depeList
				+ "]";
	}

	public List<Department> getDepeList() {
		return depeList;
	}

	public void setDepeList(List<Department> depeList) {
		this.depeList = depeList;
	}

	public String getDplId() {
        return dplId;
    }

    public void setDplId(String dplId) {
        this.dplId = dplId == null ? null : dplId.trim();
    }

    public String getDplName() {
        return dplName;
    }

    public void setDplName(String dplName) {
        this.dplName = dplName == null ? null : dplName.trim();
    }


	public String getDpId() {
		return dpId;
	}

	public void setDpId(String dpId) {
		this.dpId = dpId;
	}


	
}