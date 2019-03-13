package com.yunzhong.appointment.mapper;



import org.apache.ibatis.annotations.Delete;

import com.yunzhong.appointment.entity.Visitsettime;

public interface VisitsettimeMapper {
    int deleteByPrimaryKey(String visitstId);

    int insert(Visitsettime record);

    int insertSelective(Visitsettime record);

    Visitsettime selectByPrimaryKey(String visitstId);

    int updateByPrimaryKeySelective(Visitsettime record);

    int updateByPrimaryKey(Visitsettime record);
    /**
     * 根据人员 id 删除出诊时间表
     * @param id
     */
    @Delete("delete from scheduling where scheduling.doctor_id=#{0}")
	int  deleteByPersonId(String id);
    
}