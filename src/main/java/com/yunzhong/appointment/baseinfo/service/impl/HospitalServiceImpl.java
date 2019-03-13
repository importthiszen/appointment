package com.yunzhong.appointment.baseinfo.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yunzhong.appointment.baseinfo.service.HospitalService;
import com.yunzhong.appointment.entity.Hostipal;
import com.yunzhong.appointment.mapper.HostipalMapper;

@Service
public class HospitalServiceImpl implements HospitalService {
	@Autowired
	private HostipalMapper hMapper;

	/**
	 * 查询医院简介信息
	 */
	@Override
	public List<Hostipal> query() {
		List<Hostipal> list = hMapper.query();
		return hMapper.query();
	}

	@Override
	public Hostipal queryById(String id) {
		// TODO Auto-generated method stub
		return hMapper.selectByPrimaryKey(id);
	}
/**
 * 修改保存
 */
	@Override
	public int editsaveHospital(Hostipal hospital) {
		// TODO Auto-generated method stub
		return hMapper.updateByPrimaryKeySelective(hospital);
	}


}
