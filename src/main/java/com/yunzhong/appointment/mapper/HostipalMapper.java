package com.yunzhong.appointment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.Hostipal;

public interface HostipalMapper {
    int deleteByPrimaryKey(String hostipalId);

    int insert(Hostipal record);

    int insertSelective(Hostipal record);

    Hostipal selectByPrimaryKey(String hostipalId);

    int updateByPrimaryKeySelective(Hostipal record);

    int updateByPrimaryKey(Hostipal record);
/**
 * 查询医院简介信息
 * @return
 */
	List<Hostipal> query();
}