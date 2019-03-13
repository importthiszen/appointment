package com.yunzhong.appointment.system.service;

import java.util.List;

import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.util.SelectOptions;

public interface SystemDepartmentService {

	List<SelectOptions> queryAllList();
//查大科室
	Departmenttype queryById(String id);
/**
 * 名称不重复验证
 * @param deptName
 * @param deptId
 * @return
 */
	int validDeptName(String deptName, String deptId);
	/**
	 * 添加保存
	 * @param deptPar 大科室ID
	 * @param deptName
	 * @return
	 */
int addsaveDept(String deptPar, String deptName);
	
Departmenttype queryDeptType(String deptName);

Department queryBydpName(String deptName);
/**
 * 修改保存
 * @param deptPar 大
 * @param deptName 科室名称
 * @param deptId 科室Id
 * @param parDeptName 大科室名称
 * @return
 */
int editsaveDept(String deptPar, String deptName, String deptId, String parDeptName);
/**
 * 删除部门
 * @param id
 * @param deptName
 * @return
 */
String deleteDept(String id, String deptName);


}
