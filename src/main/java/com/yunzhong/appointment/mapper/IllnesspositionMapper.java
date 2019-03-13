package com.yunzhong.appointment.mapper;



import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yunzhong.appointment.entity.Illnessposition;
import com.yunzhong.appointment.util.PageData;

public interface IllnesspositionMapper {
    int deleteByPrimaryKey(String illtpId);

    int insert(Illnessposition record);

    int insertSelective(Illnessposition record);

    Illnessposition selectByPrimaryKey(String illtpId);

    int updateByPrimaryKeySelective(Illnessposition record);

    int updateByPrimaryKey(Illnessposition record);
    @Select("SELECT\n" + 
		"illnessposition.illtp_id,\n" + 
		"illnessposition.illtp_name\n" + 
		"FROM\n" + 
		"illnessposition")
    @ResultMap("BaseResultMap")
	List<Illnessposition> query();
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
	@Select("SELECT count(*)\n" + 
			"   FROM\n" + 
			"illnessposition\n" + 
			"where illtp_name=trim(#{param1})")
	int validatBigName(String illtpName);
    
}