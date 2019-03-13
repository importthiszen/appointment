package com.yunzhong.appointment.system.service.impl;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Professional;
import com.yunzhong.appointment.mapper.DepartmentMapper;
import com.yunzhong.appointment.mapper.PersonMapper;
import com.yunzhong.appointment.mapper.ProfessionalMapper;
import com.yunzhong.appointment.system.service.ProfessionalService;
import com.yunzhong.appointment.util.PageData;

@Service
public class ProfessionalServiceImpl implements ProfessionalService {

	@Autowired
	private ProfessionalMapper proMapper;
	@Autowired
	private DepartmentMapper deptMapper;
	@Autowired
	private PersonMapper personMapper;
	
	@Override
	public List<Professional> listPro(PageData pd) {
		pd.setPageData(pd);
		return proMapper.querylistPro(pd);
	}
/**
 * 查询科室列表
 */
	@Override
	public List<Department> queryDept() {
		// TODO Auto-generated method stub
		return deptMapper.queryAll();
	}
	/**
	 * 根据Id查询职称信息
	 */
@Override
public Professional getproById(String id) {
	// TODO Auto-generated method stub
	return proMapper.queryById(id);
}
	@Override
	public int validProName(String professionalName, String dpId) {
		// TODO Auto-generated method stub
		return proMapper.validProName(professionalName,dpId);
	}
	/**
	 * 保存(添加/修改)
	 */
	@Override
	@Transactional
	public void saveOrUpdatePro(Professional pro) {
		if("".equals(pro.getProfessionalId())){
			pro.setProfessionalId(UUID.randomUUID().toString());
			proMapper.insertSelective(pro);
		}else{
			//修改角色的数据			
			proMapper.updateByPrimaryKeySelective(pro);
			//同时修改人员的相关信息
			proMapper.updateByproId(pro.getProfessionalName(),pro.getProfessionalFee(),pro.getProfessionalId());
		}	
		
	}
	/**
	 * 删除职称相关信息
	 */
	@Override
	@Transactional
	public String removePro(String ids) {
		String names = "";
		String[] idsStr = ids.split(",");
		for (String id : idsStr) {
			int count = proMapper.validateForProDelete(id);
			System.err.println("%%%%%%%%%%%%%%%"+names);
			if (count > 0) {
				Person prolist = personMapper.getProNameDpNameById(id);
				String pName=prolist.getProfessionalName();
				String dName=prolist.getDepartmentName();
				names = names + (dName+"内"+pName) + ",";
			}else {
				proMapper.deleteByPrimaryKey(id);
			}
		}
		System.err.println("%%%%%%%%%%%%%%%"+names);
		return names;
	}
	@Override
	public Department queryDeptNameById(String dpId) {
		// TODO Auto-generated method stub
		return deptMapper.selectByPrimaryKey(dpId);
	}

}
