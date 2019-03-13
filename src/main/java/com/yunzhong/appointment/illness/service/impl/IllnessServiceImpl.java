package com.yunzhong.appointment.illness.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Illness;
import com.yunzhong.appointment.entity.Illnessposition;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.illness.service.IllnessService;
import com.yunzhong.appointment.mapper.AppointmentorderMapper;
import com.yunzhong.appointment.mapper.DepartmentMapper;
import com.yunzhong.appointment.mapper.IllnessMapper;
import com.yunzhong.appointment.mapper.IllnesspositionMapper;
import com.yunzhong.appointment.mapper.PersonMapper;
import com.yunzhong.appointment.util.PageData;
@Service
public class IllnessServiceImpl implements IllnessService {
	
	@Autowired
	private IllnessMapper mapper;
	@Autowired 
	private IllnesspositionMapper ipMapper;
	@Autowired 
	private PersonMapper personMapper;
	@Autowired 
	private AppointmentorderMapper apMapper;
	@Autowired 
	private DepartmentMapper deptMapper;
	/**
	 * 查询疾病页面列表(大类)
	 * @return
	 */
	@Override
	public List<Illnessposition> queryIllnessposition() {
		// TODO Auto-generated method stub
		return ipMapper.query();
	}
	/**
	 * 查询疾病预约(小类)
	 */
	@Override
	public List<Illness> queryIllness() {
		// TODO Auto-generated method stub
		return mapper.query();
	}
	/**	
	 * 点击疾病选择医生
	 * @param illtpId
	 * @param pd
	 * @return
	 */
	@Override
	public List<Person> querylistDoctor(PageData pd) {
		pd.setPageData(pd);
		List<Person> pl=personMapper.querylistDoctor(pd);	
		return strsubMessage(pl);			
	}
	/**
	 * 医生简介及擅长部分取30个字,其它用...代替
	 * @param pl
	 */
	private List<Person> strsubMessage(List<Person> pl) {
		for (Person person : pl) {
			String info = person.getPpInfo();
			String	doctorDomain=person.getDoctorDomain();
			if(info.length()>30) {
				String ppInfo=info.substring(0, 30)+"...";
				person.setPpInfo(ppInfo);
				List<Person> list=new ArrayList<>();
				list.add(person);
			}
			if(doctorDomain.length()>30) {
				String db=doctorDomain.substring(0, 30)+"...";
				person.setDoctorDomain(db);
				List<Person> list=new ArrayList<>();
				list.add(person);
				
			}if(info.length()<30&&doctorDomain.length()<30) {
				return pl;
			}		
		}
		return pl;
	}
	/**
	 * 查询疾病的相关信息
	 */
	@Override
	public Illness queryById(String illId) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(illId);
	}
	/**
	 * 根据搜索框内容查询对应的医生
	 * @param liName 科室/疾病名称
	 * @param sel 搜索内容
	 * @return
	 */
	@Override
	public List<Person> queryByillnessOrdoctor(PageData pd) {
		pd.setPageData(pd);
		List<Person> pl= personMapper.queryByillnessOrdoctor(pd);
		return strsubMessage(pl);			
	}
	/**
	 * 根据pd内封装的ID查询疾病信息
	 */
	@Override
	public Illness queryById(PageData pd) {
		String illId=pd.get("illId").toString();		
		return mapper.selectByPrimaryKey(illId);
	}
	/**
	 * 根据pd内封装的illName查询对应的疾病信息
	 * @param pd
	 * @return
	 */
	@Override
	public List<Illness> queryByillName(String illName) {	
		return mapper.queryByillName(illName);
	}
	/**
	 * 查询热门疾病对应的医生
	 */
	@Override
	public List<Person> queryByName(PageData pd) {
		List<Person> pl= personMapper.queryByName(pd);
		return strsubMessage(pl);	
	}
	/**
	 * 根据illName查询对应的疾病信息(热门疾病)
	 * @param pd
	 * @return
	 */
	@Override
	public Illness queryInfo(PageData pd) {
		// TODO Auto-generated method stub
		String illName=pd.get("illName").toString();		
		return mapper.queryInfo(illName);
	}
	/**
	 * 模糊查询科室信息
	 */
	@Override
	public List<Department> queryBydeptName(String departmentName) {
		return deptMapper.queryBydeptName(departmentName);
	}
	/**
	 *  查询疾病
	 */
	@Override
	public List<Illness> querySmallIllness(PageData pd) {
		pd.setPageData(pd);
		return mapper.querySmallIllness(pd);
	}
	/**
	 * 查询疾病类别
	 */
	@Override
	public List<Illnessposition> queryBigIllness(PageData pd) {
		pd.setPageData(pd);
		return ipMapper.queryBigIllness(pd);
	}
	/**
	 * 验证疾病类别是否重复
	 */
	@Override
	public int validatBigName(String illtpName) {
		// TODO Auto-generated method stub
		return ipMapper.validatBigName(illtpName);
	}



}
