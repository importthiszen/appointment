package com.yunzhong.appointment.illness.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import com.yunzhong.appointment.config.Const;
import com.yunzhong.appointment.entity.Appointmentorder;
import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Professional;
import com.yunzhong.appointment.illness.service.DepartmentService;
import com.yunzhong.appointment.mapper.AppointmentorderMapper;
import com.yunzhong.appointment.mapper.DepartmentMapper;
import com.yunzhong.appointment.mapper.DepartmenttypeMapper;
import com.yunzhong.appointment.mapper.PersonMapper;
import com.yunzhong.appointment.mapper.ProfessionalMapper;
import com.yunzhong.appointment.util.PageData;
@Service
public class DepartmentServiceImpl implements DepartmentService {

	@Autowired
	private DepartmenttypeMapper deptTypeMapper;
	@Autowired
	private DepartmentMapper deptMapper;
	@Autowired
	private AppointmentorderMapper apMapper;
	@Autowired 
	private PersonMapper personMapper;
	@Autowired
	private ProfessionalMapper proMapper;
	/**
	 * redis 接口
	 */
	@Autowired
    private RedisTemplate<String,Object> RedisTemplate;
	@Override
	public List<Departmenttype> queryDepartmenttype() {
		// TODO Auto-generated method stub
		return deptTypeMapper.query();
	}

	@Override
	public List<Department> queryDepartment() {
		// TODO Auto-generated method stub
		return deptMapper.queryDepartment();
	}
	/**
	 * 查询热门科室
	 */
		@Override
		public List<Appointmentorder> queryAppointmentorder() {
			// TODO Auto-generated method stub
			return apMapper.queryAppointmentorder();
		}
	/**
	 * 查询科室下9天内出诊的医生
	 */
	@Override
	public List<Person> querydeptDoctor(PageData pd) {
		pd.setPageData(pd);
		return personMapper.querydeptDoctor(pd);
	}
	/**
	 * 查询科室,根据ID
	 */
	@Override
	public Department queryById(PageData pd) {
		String departmentId=pd.get("departmentId").toString();
		return deptMapper.selectByPrimaryKey(departmentId);
	}
	/**
	 * 根据类别查询科室
	 */
	@Override
	public List<Department> queryDeptBydplId(String dplId) {
		// TODO Auto-generated method stub
		return deptMapper.queryDeptBydplId(dplId);
	}
	/**
	 * 冯建辉
	 * 根据科室查询职务
	 * 2019年3月7日15:01:17
	 */
	@Override
	public List<Professional> queryProByDeptId(String departmentId) {
		// TODO Auto-generated method stub
		return proMapper.queryProByDeptId(departmentId);
	}
	/**
	 * 冯建辉
	 * 根据职务id查询出诊费用
	 * 2019年3月7日15:38:05
	 */
	@Override
	public Double queryProfessionalFeeById(String professionalId) {
		// TODO Auto-generated method stub
		return proMapper.queryProfessionalFeeById(professionalId);
	}
   /**
    * 查询大科室和小科室
    */
	@Override
	public List<Departmenttype> selectDeptmenttype() {
		ListOperations opsForList = RedisTemplate.opsForList();
		List<Departmenttype> list = opsForList.range(Const.DEPEPARTMENTTYPE, 0, -1);
		return list;
	}

}
