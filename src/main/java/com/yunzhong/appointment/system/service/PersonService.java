package com.yunzhong.appointment.system.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.util.PageData;

public interface PersonService {
	/**
	 *  查询人员
	 * @param pd
	 * @return
	 */
	List<Person> listPerson(PageData pd);
	/**
	 * 查询科室类别
	 * @return
	 */
	List<Departmenttype> queryDepartmentType();
	/**
	 * 添加person
	 * @param person
	 * @param picFile
	 * @return
	 */
	int addPerson(Person person, MultipartFile picFile);
	/**
	 * 根据id查询人员
	 * @param id
	 * @return
	 */
	Person queryById(String id);
	/**
	 * 根据科室id查询科室类别
	 * @param departmentId
	 * @return
	 */
	Departmenttype queryByDeptTypeByDeptId(String departmentId);
	/**
	 * 修改人员
	 * @param person
	 * @param picFile
	 * @return
	 */
	int editPerson(Person person, MultipartFile picFile);
	/**
	 * 删除人员
	 * @param ids
	 * @return
	 */
	int delPerson(String ids);

}
