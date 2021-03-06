package com.yunzhong.appointment.util;

import java.util.ArrayList;
import java.util.List;


/**
 * 
 * @className SelectOptions
 * @description 用于页面的下拉
 * @author 石洪刚
 * @time 2017年10月6日 上午8:11:36
 */
public class SelectOptions {

	private String label;
	private String value;
	private Boolean selected;
	private List<SelectOptions> selectList = new ArrayList<SelectOptions>();
	
	
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public Boolean getSelected() {
		return selected;
	}
	public void setSelected(Boolean selected) {
		this.selected = selected;
	}
	@Override
	public String toString() {
		return "SelectOptions [label=" + label + ", value=" + value
				+ ", selected=" + selected + "]";
	}
	public List<SelectOptions> getSelectList() {
		return selectList;
	}
	public void setSelectList(List<SelectOptions> selectList) {
		this.selectList = selectList;
	}
}
