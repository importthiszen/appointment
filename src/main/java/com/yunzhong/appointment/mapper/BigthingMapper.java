package com.yunzhong.appointment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.Bigthing;
import com.yunzhong.appointment.util.PageData;

public interface BigthingMapper {
    int deleteByPrimaryKey(String bigthingId);

    int insert(Bigthing record);

    int insertSelective(Bigthing record);

    Bigthing selectByPrimaryKey(String bigthingId);

    int updateByPrimaryKeySelective(Bigthing record);

    int updateByPrimaryKey(Bigthing record);
    /**
     * 查询大事记
     * @param pd
     * @return
     */
	List<Bigthing> query(PageData pd);
	/**
	 * 查询跟数据库已有名称相同的条数
	 * @param bigthingTitle
	 * @return
	 */
	@Select("  	SELECT count(*)  FROM  bigthing where bigthing.bigthing_title=#{0}")
	int validatThingName(String bigthingTitle);


}