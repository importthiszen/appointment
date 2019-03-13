package com.yunzhong.appointment.system.service;

import java.util.List;

import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Professional;
import com.yunzhong.appointment.entity.SysUser;
import com.yunzhong.appointment.util.PageData;

public interface ProfessionalService {

	List<Professional> listPro(PageData pd);
/**
 * 查询科室
 * @return
 */
	List<Department> queryDept();
	/**
	 * 根据Id查询
	 * @param id
	 * @return
	 */
	Professional getproById(String id);
	/**
	 * 职称名称不重复验证
	 * @param professionalName
	 * @param dpId
	 * @return
	 */
	int validProName(String professionalName, String dpId);
	/**
	 * 保存(添加/修改)
	 * @param pro
	 */
	void saveOrUpdatePro(Professional pro);
	/**
	 * 删除职称信息,如果被人员使用则不能删除
	 * @param ids
	 * @return
	 */
	String removePro(String ids);
	
	Department queryDeptNameById(String dpId);

}
