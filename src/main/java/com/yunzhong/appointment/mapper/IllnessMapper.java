package com.yunzhong.appointment.mapper;



import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import com.yunzhong.appointment.entity.Illness;
import com.yunzhong.appointment.util.PageData;

public interface IllnessMapper {
    int deleteByPrimaryKey(String illId);

    int insert(Illness record);

    int insertSelective(Illness record);

    Illness selectByPrimaryKey(String illId);

    int updateByPrimaryKeySelective(Illness record);

    int updateByPrimaryKey(Illness record);
/**
 * 查询疾病页面列表
 * @return
 */
    @Select("SELECT\n" + 
    		"illness.ill_id,\n" + 
    		"illness.illtp_id,\n" + 
    		"illness.ill_name,\n" + 
    		"illness.ill_info\n" + 
    		"FROM\n" + 
    		"illness")
    @ResultMap("BaseResultMap")
	List<Illness> query();
   /**
    * 根据疾病名称查询相关信息 
    * @param illName
    * @return
    */
    List<Illness> queryByillName(String illName);
	/**
	 * 根据illName查询对应的疾病信息(热门疾病)
	 * @param pd
	 * @return
	 */
    @Select("SELECT\n" + 
    		"illness.ill_id,illness.ill_name,illness.ill_info\n" + 
    		"FROM illness WHERE illness.ill_name=#{param1}")
    @ResultMap("BaseResultMap")
    Illness queryInfo(String illName);
    /**
     * 查询疾病
     * @param pd
     * @return
     */
	List<Illness> querySmallIllness(PageData pd);
    
}