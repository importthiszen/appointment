package com.yunzhong.appointment.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Scheduling;

public interface SchedulingMapper {
    int deleteByPrimaryKey(String schedulingId);

    int insert(Scheduling record);

    int insertSelective(Scheduling record);

    Scheduling selectByPrimaryKey(String schedulingId);

    int updateByPrimaryKeySelective(Scheduling record);

    int updateByPrimaryKey(Scheduling record);
    /**
     * 根据医生id查询未来就天内的排班情况
     * @param ppId
     * @return list
     */
    @Select("SELECT\n" + 
    		"scheduling.scheduling_id,\n" + 
    		"scheduling.doctor_id,\n" + 
    		"scheduling.scheduling_date,\n" + 
    		"scheduling.time1,\n" + 
    		"scheduling.time2,\n" + 
    		"scheduling.time3,\n" + 
    		"scheduling.time4,\n" + 
    		"scheduling.time5,\n" + 
    		"scheduling.time6,\n" + 
    		"scheduling.count1,\n" + 
    		"scheduling.count2,\n" + 
    		"scheduling.count3,\n" + 
    		"scheduling.count4,\n" + 
    		"scheduling.count5,\n" + 
    		"scheduling.count6,\n" + 
    		"scheduling.standby\n" + 
    		"FROM\n" + 
    		"scheduling\n" + 
    		"where DATEDIFF(scheduling.scheduling_date,${param1}) < 9 AND DATEDIFF(scheduling.scheduling_date,${param1}) >=0 AND scheduling.doctor_id = #{param2}")
    @ResultMap("BaseResultMap")
	List<Scheduling> selectNineDayByPpid(String date,String ppId);
     /**
      * 根据排班id 和时段 减少一个预约名额
      * @param apId
      * @param count
      * 于占峰
      * 2019年3月8日14:08:51
      */
	void updateAppointmentorderCountByIdAndCount(String apId, String count);
    /**
     * 却笑订单后恢复一次预约名额
     * @param sdlid
     * @param count
     */
	@Update("UPDATE scheduling\n" + 
			"SET ${param2} = ${param2} + 1\n" + 
			"WHERE scheduling_id = #{param1} ")
	void RecoverytimesByIdOrCount(String sdlid, String count);
    /**
     * 根据人员id删除排班
     * @param id
     * @return
     */
	@Delete("delete from scheduling where scheduling.doctor_id=#{0}")
	int deleteByPersonId(String id);
}