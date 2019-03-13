package com.yunzhong.appointment.mapper;


import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.yunzhong.appointment.entity.Patient;
import com.yunzhong.appointment.entity.SysUser;

public interface PatientMapper {
    int deleteByPrimaryKey(String patientId);

    int insert(Patient record);

    int insertSelective(Patient record);

    Patient selectByPrimaryKey(String patientId);

    int updateByPrimaryKeySelective(Patient record);

    int updateByPrimaryKey(Patient record);
    /**
     * 
     * @methodName updateUserInfo
     * @description 修改患者中的用户信息
     * @author 石洪刚
     * @time 2017年10月5日 下午7:22:37
     * @param user
     */
    @Update("UPDATE patient SET user_name = #{userName} where user_id=#{userId}")
	void updateUserInfo(SysUser user);
    /**
     * 
     * @methodName updateUserInfoNullByUserId
     * @description 设置用户信息为NULL
     * @author 石洪刚
     * @time 2017年10月5日 下午7:37:46
     * @param id
     */
    @Update("UPDATE patient SET user_name = NULL,user_id = NULL where user_id=#{id}")
	void updateUserInfoNullByUserId(String id);
     /**
      * 验证是否存在患者信息
      * @param name
      * @param uid
      * @param tel
      * @return
      */
    @Select("SELECT\n" + 
    		"COUNT(*)\n" + 
    		"FROM\n" + 
    		"patient\n" + 
    		"WHERE  patient.patient_name = #{param1}  AND patient.patient_uid = #{param2} AND patient.patient_tel = #{param3}")
	int verifyByNameAndUidOrTel(String name, String uid, String tel);
    /**
     * 根据角色名查询患者信息
     * @param userName
     * @return
     */
    @Select("SELECT patient.patient_id, patient.user_id, patient.user_name, patient.patient_name, patient.patient_tel, patient.patient_sex, \n" + 
    		"patient.patient_uid,patient.patient_birth,patient.province_id, patient.province_name, patient.city_id, \n" + 
    		"patient.city_name,patient.area_id,patient.area_name, patient.patient_time, patient.standby, patient.patient_pic\n" + 
    		"FROM\n" + 
    		"patient \n" + 
    		"WHERE patient.patient_tel = #{param1}\n" + 
    		"")
    @ResultMap("BaseResultMap")
	Patient queryPatientByuserName(String userName);
    /**
     * 根据id修改患者头像路径
     * @param image
     * @param id
     * @return
     */
    @Update("UPDATE patient\n" + 
    		"SET\n" + 
    		"patient.patient_pic = #{param1}\n" + 
    		"WHERE patient.patient_id = #{param2}")
	int updateImgUrl(String image, String id);
    
}