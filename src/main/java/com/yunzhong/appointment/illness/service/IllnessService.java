package com.yunzhong.appointment.illness.service;

import java.util.List;

import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Illness;
import com.yunzhong.appointment.entity.Illnessposition;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.util.PageData;

public interface IllnessService {

	/**
	 * 查询疾病页面(大类)
	 * @return
	 */
	List<Illnessposition> queryIllnessposition();
/**
 * 查询疾病页面(小类)
 * @param pd
 * @return
 */
	List<Illness> queryIllness();
/**	
 * 点击疾病选择医生
 * @param pd
 * @return
 */
	List<Person> querylistDoctor(PageData pd);

	Illness queryById(String illId);
	/**
	 * 根据搜索框内容查询对应的医生
	 * @param liName 科室/疾病名称
	 * @param sel 搜索内容
	 * @param pd
	 * @return
	 */
	List<Person> queryByillnessOrdoctor(PageData pd);
	/**
	 * 根据pd内封装的ID查询对应的疾病信息
	 * @param pd
	 * @return
	 */
	Illness queryById(PageData pd);
	/**
	 * 根据illName查询对应的疾病信息
	 * @param illName
	 * @return
	 */
	List<Illness> queryByillName(String illName);
	/**
	 * 查询热门疾病对应的医生
	 * @param illName
	 * @return
	 */
	List<Person> queryByName(PageData pd);
	/**
	 * 根据illName查询对应的疾病信息(热门疾病)
	 * @param pd
	 * @return
	 */
	Illness queryInfo(PageData pd);
	/**
	 * 模糊查询科室名称List
	 * @param departmentName
	 * @return
	 */
	List<Department> queryBydeptName(String departmentName);
	/**
	 *查询疾病
	 * @param pd
	 * @return
	 */
	List<Illness> querySmallIllness(PageData pd);
	/**
	 * 查询疾病类别
	 * @param pd
	 * @return
	 */
	List<Illnessposition> queryBigIllness(PageData pd);
	/**
	 * 验证疾病类别是否重复
	 * @param illtpName
	 * @return
	 */
	int validatBigName(String illtpName);








}
