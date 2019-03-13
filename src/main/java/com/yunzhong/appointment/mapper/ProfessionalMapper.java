package com.yunzhong.appointment.mapper;



import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.yunzhong.appointment.entity.Professional;
import com.yunzhong.appointment.util.PageData;

public interface ProfessionalMapper {
    int deleteByPrimaryKey(String professionalId);

    int insert(Professional record);

    int insertSelective(Professional record);

    Professional selectByPrimaryKey(String professionalId);

    int updateByPrimaryKeySelective(Professional record);

    int updateByPrimaryKey(Professional record);
    /**
     * 根据科室id查询职务
     * @param departmentId
     * @return
     */
    @Select("SELECT\n" + 
    		"professional.professional_id,\n" + 
    		"professional.dp_id,\n" + 
    		"professional.professional_name,\n" + 
    		"professional.professional_fee\n" + 
    		"FROM\n" + 
    		"professional\n" + 
    		"where professional.dp_id = #{0}")
    @ResultMap("BaseResultMap")
	List<Professional> queryProByDeptId(String departmentId);
    /**
     * 根据职务id查询出诊费用
     * @param professionalId
     * @return
     */
    @Select("SELECT\n" + 
    		"professional.professional_fee\n" + 
    		"FROM\n" + 
    		"professional\n" + 
    		"where professional.professional_id = #{0}")
	Double queryProfessionalFeeById(String professionalId);
/**
 * 删除科室时同时删除科室下的职称
 * @param id
 */
    @Delete("DELETE from professional where dp_id=#{param1}")
	void deleteBydeptId(String id);
/**
 * 查询职称列表
 * @param pd
 * @return
 */
List<Professional> querylistPro(PageData pd);
/**
 * 根据ID查一条职称信息
 * @param id
 * @return
 */
@Select("SELECT professional.professional_id,professional.dp_id,\n" + 
		"professional.professional_name,professional.professional_fee,\n" + 
		"department.dp_name\n" + 
		"FROM department\n" + 
		"INNER JOIN professional ON professional.dp_id = department.dp_id\n" + 
		"WHERE professional.professional_id=#{param1}")
@ResultMap("BaseResultMap")
Professional queryById(String id);
/**
 * 验证职称是否重复
 * @param professionalName
 * @param dpId
 * @return
 */
@Select("SELECT COUNT(*) FROM professional\n" + 
		"WHERE professional_name=#{param1} AND dp_id=#{param2}")
int validProName(String professionalName, String dpId);

/**
 * 修改职称对应的人员
 * @param professionalName
 * @param professionalFee
 * @param professionalId
 */
@Update("update person set  professional_name=#{param1},doctor_pay=#{param2}  where professional_id=#{param3}")
void updateByproId(String professionalName, Double professionalFee, String professionalId);
/**
 * 查询此职称是否可被删除
 * @param id
 * @return
 */
@Select("SELECT COUNT(*) FROM person where professional_id=#{param1}")
int validateForProDelete(String id);
/**
 * 查询不能删除的职称名称
 * @param id
 * @return
 */


    
}