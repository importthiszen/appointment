package com.yunzhong.appointment.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.Appointmentorder;
import com.yunzhong.appointment.entity.Illness;
import com.yunzhong.appointment.util.PageData;

public interface AppointmentorderMapper {
    int deleteByPrimaryKey(String appointmentId);

    int insert(Appointmentorder record);
    
    int insertSelective(Appointmentorder record);

    Appointmentorder selectByPrimaryKey(String appointmentId);

    int updateByPrimaryKeySelective(Appointmentorder record);

    int updateByPrimaryKey(Appointmentorder record);
/**
 * 查询热门科室
 * @return
 */
    @Select("SELECT count(a.department_id)shu,a.department_id,a.department_name from(\n" + 
    		"SELECT\n" + 
    		"appointmentorder.appointment_id,appointmentorder.department_id,appointmentorder.department_name\n" + 
    		"FROM appointmentorder)a\n" + 
    		"GROUP BY a.department_id\n" + 
    		"HAVING ROW_COUNT()<9\n" + 
    		"ORDER BY shu DESC")
    @ResultMap("BaseResultMap")
	List<Appointmentorder> queryAppointmentorder();
 /**
  * 查询订单 动态 未付款or所有
  * @param ap
  * @return
  */
 List<Appointmentorder> selectByPatientId(PageData pd);
/**
 * 根据预约时间 和科室id 患者id  查询该患者同一天内此科室的预约次数
 * @param date
 * @param departmentId
 * @return int
 * 2019年3月8日15:28:09
 * 于占峰
 */
 @Select("SELECT COUNT(*) FROM appointmentorder ap\n" + 
 		"WHERE TO_DAYS(ap.appointment_date) =  TO_DAYS( #{param1} ) AND ap.department_id = #{param2} AND ap.patient_id = #{param3}")
int countAppointmentorderByDayAndsetDoctorId(Date date, String departmentId,String prantId);
/**
 * 根据预约时间 和 患者id 查询这一天的预约次数总量
 * @param date
 * @param patientId
 * @return int
 * 于占峰
 */
 @Select("SELECT COUNT(*) FROM appointmentorder ap\n" + 
 		"WHERE TO_DAYS(ap.appointment_date) = TO_DAYS(#{param1})  AND ap.patient_id = #{param2} ")
int countAppointmentorderByDayAndPatientId(Date date, String patientId);
/**
 * 查询用户7日预约总量
 * @param patientId
 * @return int
 * 2019年3月8日15:44:01
 * 于占峰
 */
 @Select("SELECT COUNT(*) FROM appointmentorder \n" + 
 		"WHERE date_sub(curdate(), interval 7 day) <= appointment_time  AND patient_id = #{param1} ")
int CountAppointmentorderSevenDayByPatientId(String patientId);
/**
 * 查询用户是3个月内预约总量
 * @param patientId
 * @return int
 * 2019年3月8日16:19:27
 * 于占峰
 */
 @Select("SELECT COUNT(*) FROM appointmentorder \n" + 
	 		"WHERE date_add(curdate(), interval 90 day) <= appointment_time  AND patient_id = #{param1} ")
int countAppointmentorderThreemonthsByPatientId(String patientId);
/**
 * 查询用户3个月内的订单爽约次数
 * @param patientId
 * @return int
 * 2019年3月8日16:21:55
 * 于占峰
 */
 @Select("SELECT COUNT(*) FROM appointmentorder \n" + 
	 		"WHERE date_add(curdate(), interval 90 day) <= appointment_time  AND patient_id = #{param1} AND order_state = 'S'")
int CountAppointmentorderThreemonthsBreakByPatientId(String patientId);
/**
 * 查询当天最新的订单
 */
@Select("SELECT\n" + 
		"appointmentorder.paytype_orderid\n" + 
		"FROM\n" + 
		"appointmentorder\n" + 
		"WHERE paytype_orderid LIKE #{param1} \n" + 
		"ORDER BY paytype_orderid DESC\n" + 
		"LIMIT 1")
String selectOderNoToday(String dateStr);
/**
 * 根据患者id 疾病id 预约时间 查询当天内的预约次数
 * @param date
 * @param patientId
 * @param illId
 * @return
 */

@Select("SELECT COUNT(*) FROM appointmentorder ap\n" + 
		"WHERE TO_DAYS(ap.appointment_date) =  TO_DAYS( #{param1} ) AND ap.patient_id = #{param2} AND ap.illness_id = #{param3}")
int countAppointmentorderByDayAndillId(Date date, String patientId, String illId);
/**
 * 查询所有订单状态为未付款,并且超时30分钟的订单
 * @return
 */
@Select("SELECT\n" + 
		"appointmentorder.appointment_id\n" + 
		"FROM\n" + 
		"appointmentorder\n" + 
		"WHERE appointmentorder.order_state = 'N' AND SUBDATE(NOW(),INTERVAL 30 minute) > appointmentorder.appointment_time")
List<String> selectTimeout();


	
}