package com.yunzhong.appointment.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.mapper.DepartmentMapper;
import com.yunzhong.appointment.mapper.DepartmenttypeMapper;
import com.yunzhong.appointment.mapper.PersonMapper;
import com.yunzhong.appointment.mapper.ProfessionalMapper;
import com.yunzhong.appointment.system.service.SystemDepartmentService;
import com.yunzhong.appointment.util.SelectOptions;
@Service
public class SystemDepartmentServiceImpl implements SystemDepartmentService {
	@Autowired
	private DepartmentMapper deptMapper;
	@Autowired
	private DepartmenttypeMapper deptTypeMapper;
	@Autowired
	private PersonMapper personMapper;
	@Autowired
	private ProfessionalMapper proMapper;
/**
 * 	查询科室列表
 */
	@Override
	public List<SelectOptions> queryAllList() {
		List<SelectOptions> topDeptList = deptTypeMapper.queryAllDeptByTop();
		List<SelectOptions> rvList = new ArrayList<SelectOptions>();
		for (SelectOptions dept : topDeptList) {
			SelectOptions rv = this.recursiveDeptByTopDept(dept);
			rvList.add(rv);
		}
		return rvList;
	}

	private SelectOptions recursiveDeptByTopDept(SelectOptions dept) {
			List<SelectOptions> childDepts = deptMapper.queryDeptByOne(dept);
		for (SelectOptions sdept : childDepts) {
			dept.getSelectList().add(sdept);
		}
		return dept;
	}

	@Override
	public Departmenttype queryById(String id) {
		// TODO Auto-generated method stub
		return deptTypeMapper.selectByPrimaryKey(id);
	}
/**
 * 
 */
	@Override
	public int validDeptName(String deptName, String deptId) {
		int count=deptTypeMapper.validDeptName(deptName);
		int count2=deptMapper.validDeptName(deptName);
		return count+count2;
	}
/**
 * 添加保存
 */
@Override
@Transactional
public int addsaveDept(String deptPar, String deptName) {
	if(deptPar.equals("0")) {
		Departmenttype dpt=new Departmenttype();
		dpt.setDplId(UUID.randomUUID().toString());
		dpt.setDplName(deptName);
		return deptTypeMapper.insertSelective(dpt);
	}		
		Department dept =new Department();
		dept.setDpId(UUID.randomUUID().toString());
		dept.setDplId(deptPar);
		dept.setDpName(deptName);
		return deptMapper.insertSelective(dept);
	}
/**
 * 查询小科室信息
 */
//@Override
//public Department queryBydpId(String id) {
//	// TODO Auto-generated method stub
//	Department dept=deptMapper.selectByPrimaryKey(id);
//	if(dept!=null) {
//		return deptMapper.selectByPrimaryKey(id);
//	}
//	return null;
//	}

@Override
public Departmenttype queryDeptType(String deptName) {
	// TODO Auto-generated method stub
	return deptTypeMapper.selectByDplName(deptName);
}

@Override
public Department queryBydpName(String deptName) {
	Department dept=deptMapper.selectBydeptName(deptName);
	if(dept!=null) {
		return deptMapper.selectBydeptName(deptName);
	}
	return null;
}
/**
 * 修改保存
 */
@Override
@Transactional
public int editsaveDept(String deptPar, String deptName, String deptId, String parDeptName) {
	if(deptPar.equals("0")) {
		Departmenttype dpt=new Departmenttype();
		dpt.setDplName(deptName);
		return deptTypeMapper.updateByPrimaryKeySelective(dpt);
	}
	//修改科室
	Department dept =new Department();
	dept.setDpId(deptId);
	dept.setDpName(deptName);
	int tiao=deptMapper.updateByPrimaryKeySelective(dept);
	//修改人员
	if(tiao>0) {
		personMapper.updateBydpId(deptName,deptId);
	}
	return tiao;
}
/**
 * 判断是否可以删除,删除大科室的同时删除小科室
 */
@Override
@Transactional
public String deleteDept(String id, String deptName) {
	String names="";
	//根据名字查询要删除的是大科室还是小科室
	Department dept=deptMapper.selectBydeptName(deptName);
	if(dept!=null) {//小科室
		//判断是否有被占用的科室
		int count=deptMapper.validateFordelete(id);
		if(count>0) {
			String	deptsmallName=deptMapper.getdeptNameById(id);
			names=names+deptsmallName+",";
		}else {
			//删除科室下的职称
			proMapper.deleteBydeptId(id);
			deptMapper.deleteByPrimaryKey(id);					
		}		
	}else {//大科室
		System.err.println("%%%%%%%%%%%%"+id);
		//根据大科室ID查询下面的子科室
		List<Department>depList=deptMapper.queryAlldeptById(id);
		System.err.println("-******************"+depList);
		if(depList.size()>0) {//大科室下有子科室
			for (Department department : depList) {
				int count=deptMapper.validateFordelete(department.getDpId());
				if(count>0) {
					String	deptsmallName=deptMapper.getdeptNameById(department.getDpId());
					names=names+deptsmallName+",";
				}else {
					//删除科室下的职称
					proMapper.deleteBydeptId(department.getDpId());
					deptMapper.deleteByPrimaryKey(department.getDpId());	
					deptTypeMapper.deleteByPrimaryKey(department.getDplId());
				}		
				List<Department>list=deptMapper.queryDeptBydplId(department.getDplId());
				if(list==null) {
					deptTypeMapper.deleteByPrimaryKey(department.getDplId());
				}
			}	
			
		}else {
			//大科室下无子科室
			System.err.println("----------------------"+id);
			deptTypeMapper.deleteByPrimaryKey(id);
		}
	}
	return names;
}

}
