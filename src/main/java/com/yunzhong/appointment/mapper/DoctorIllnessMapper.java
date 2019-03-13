package com.yunzhong.appointment.mapper;


import org.apache.ibatis.annotations.Delete;

import com.yunzhong.appointment.entity.DoctorIllness;

public interface DoctorIllnessMapper {
    int deleteByPrimaryKey(String docillId);

    int insert(DoctorIllness record);

    int insertSelective(DoctorIllness record);

    DoctorIllness selectByPrimaryKey(String docillId);

    int updateByPrimaryKeySelective(DoctorIllness record);

    int updateByPrimaryKey(DoctorIllness record);
    /**
     * 根据人员id删除医生疾病表
     * @param id
     */
    @Delete("delete from doctor_illness\n" + 
    		"where doctor_illness.doctor_id=#{0}")
	void deleteByPersonId(String id);
    
}