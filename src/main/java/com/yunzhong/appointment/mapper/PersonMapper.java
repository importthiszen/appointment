package com.yunzhong.appointment.mapper;


import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.util.PageData;

public interface PersonMapper {
    int deleteByPrimaryKey(String ppId);

    int insert(Person record);

    int insertSelective(Person record);

    Person selectByPrimaryKey(String ppId);

    int updateByPrimaryKeySelective(Person record);

    int updateByPrimaryKey(Person record);
   
	/**
	 * 
	 * @methodName setUserIdNullByUserId
	 * @description 设置用户主键为NULL
	 * @author 石洪刚
	 * @time 2017年10月5日 下午7:35:48
	 * @param id
	 */
	@Update("update person set user_id = NULL where user_id = #{id}")
	void updateUserIdNullByUserId(String id);
/**
 * 点击疾病选择医生
 * @param illtpId
 * @return
 */
    List<Person> querylistDoctor(PageData pd);
	/**
	 * 根据搜索框内容查询对应的医生
	 * @param liName 科室/疾病名称
	 * @param sel 搜索内容
	 * @return
	 */
	List<Person> queryByillnessOrdoctor(PageData pd);
/**
 * 查询科室下9天内出诊的医生
 * @param pd
 * @return
 */
	List<Person> querydeptDoctor(PageData pd);
/**
 * 查询热门疾病对应的九天内出诊的医生
 * @param illName
 * @return
 */
List<Person> queryByName(PageData pd);
/**
 * 根据用户主键上传人员头像
 * @param fileName
 * @param userId
 * @return
 */
@Update("UPDATE person\n" + 
		"SET person.pp_pic = #{param1}\n" + 
		"WHERE person.user_id = #{param2}")
int updateImgUrl(String fileName, String userId);

List<Person> queryAll(PageData pd);
/**
 * 当修改科室后更新人员信息
 * @param deptName
 * @param deptId
 */
@Update("UPDATE person\n" + 
		"	SET person.department_name=#{param1}\n" + 
		"	WHERE person.department_id =#{param2}")
void updateBydpId(String deptName, String deptId);

/**
 * 冯建辉
 * 通过userid查询条数
 * @param userId
 * @return
 */
@Select("select COUNT(*) from person where person.user_id=#{0}")
int queryCountByUserId(String userId);
/**
 * 获得不能删除的职称信息
 * @param id
 * @return
 */
@Select("SELECT person.department_name,person.professional_name\n" + 
		"FROM person WHERE professional_id=#{param1}")
@ResultMap("BaseResultMap")
Person getProNameDpNameById(String id);
/**
 * 根据角色id得到人员
 * @param userId
 * @return
 */
@Select("SELECT\n" + 
		"person.pp_id, person.user_id, person.pp_name, person.pp_info, person.doctor_domain, person.pp_state,\n" + 
		"person.pp_time, person.department_id, person.department_name, person.professional_id, person.professional_name,\n" + 
		"person.doctor_pay, person.pp_pic, person.standby FROM person WHERE user_id = #{param1}")
@ResultMap("BaseResultMap")
Person selectByuserId(String userId);
}