package com.yunzhong.appointment.illness.service;

import java.util.List;

import com.yunzhong.appointment.entity.Appointmentorder;
import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Professional;
import com.yunzhong.appointment.util.PageData;

public interface DepartmentService {
/**
 * 查询所有的科目类别
 * @return
 */
	List<Departmenttype> queryDepartmenttype();
/**
 * 查询详细科室
 * @return
 */
List<Department> queryDepartment();
/**
 * 查询热门科室
 * @return
 */
List<Appointmentorder> queryAppointmentorder();
/**
 * 查询小科室下医生信息(九天内出诊)
 * @param pd
 * @return
 */
List<Person> querydeptDoctor(PageData pd);
/**
 * 根据ID查询科室
 * @param pd
 * @return
 */
Department queryById(PageData pd);
/**
 * 根据类别查询科室
 * @param dplId
 * @return
 */
List<Department> queryDeptBydplId(String dplId);
/**
 * 根据科室查询职务
 * @param departmentId
 * @return
 */
List<Professional> queryProByDeptId(String departmentId);
/**
 * 根据职务id查询出诊费用
 * @param professionalId
 * @return
 */
Double queryProfessionalFeeById(String professionalId);
/**
 * 查询大科室and小科室
 * @return
 */
List<Departmenttype> selectDeptmenttype();
		
}
