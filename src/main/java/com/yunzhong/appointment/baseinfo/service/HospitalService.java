package com.yunzhong.appointment.baseinfo.service;

import java.util.List;

import com.yunzhong.appointment.entity.Hostipal;

public interface HospitalService {


/**
 * 查询医院简介
 * @return
 */
	List<Hostipal> query();
/**
 * 查询医院修改信息
 * @param id
 * @return
 */
Hostipal queryById(String id);
/**
 * 修改医院简介
 * @return
 */
int editsaveHospital(Hostipal hospital);

}
