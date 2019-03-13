package com.yunzhong.appointment.system.service.impl;

import java.util.List;
import java.util.UUID;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Professional;
import com.yunzhong.appointment.mapper.DepartmentMapper;
import com.yunzhong.appointment.mapper.DepartmenttypeMapper;
import com.yunzhong.appointment.mapper.DoctorIllnessMapper;
import com.yunzhong.appointment.mapper.PersonMapper;
import com.yunzhong.appointment.mapper.ProfessionalMapper;
import com.yunzhong.appointment.mapper.SchedulingMapper;
import com.yunzhong.appointment.mapper.SysUserMapper;
import com.yunzhong.appointment.mapper.VisitsettimeMapper;
import com.yunzhong.appointment.system.service.PersonService;
import com.yunzhong.appointment.util.FileUtils;
import com.yunzhong.appointment.util.PageData;
/**
 * 人员模型层
 * @author 冯建辉
 * 2019年3月5日17:06:33
 */
@Service
public class PersonServiceImpl implements PersonService {
	/**
	 * 人员mapper
	 */
	@Autowired
	private  PersonMapper mapper;
	/**
	 * 科室类别mapper
	 */
	@Autowired
	private  DepartmenttypeMapper deptMapper;
	/**
	 * 科室mapper
	 */
	@Autowired
	private  DepartmentMapper dept2Mapper;
	/**
	 * 用户mapper
	 */
	@Autowired
	private  SysUserMapper userMapper;
	/**
	 * 医生疾病mapper
	 */
	@Autowired
	private  DoctorIllnessMapper docTllMapper;
	/**
	 * 出诊时间mapper
	 */
	@Autowired
	private  VisitsettimeMapper visiMapper;
	/**
	 * 排班mapper
	 */
	@Autowired
	private SchedulingMapper sechMapper;
	/**
	 * 职称mapper
	 */
	@Autowired
	private ProfessionalMapper proMapper;
	/**
	 *  查询人员
	 */
	@Override
	public List<Person> listPerson(PageData pd) {
		pd.setPageData(pd);
		List<Person> perList = mapper.queryAll(pd);
		if (null != perList && !perList.isEmpty()) {
			for (Person person : perList) {
				String ppInfo = person.getPpInfo();
				//如果长度大于8 截取8个汉字
				if (ppInfo.length()>8) {
					ppInfo = ppInfo.substring(0, 8)+"...";
					person.setPpInfo(ppInfo);
				}
			}	
		}
		return perList;
	}
	/**
	 * 查询科室类别
	 */
	@Override
	public List<Departmenttype> queryDepartmentType() {
		return deptMapper.query();
	}
	/**
	 * 添加person
	 */
	@Override
	@Transactional()
	public int addPerson(Person person, MultipartFile picFile) {
		person.setPpId(UUID.randomUUID().toString());
		//查看用户是否被使用了
		if (  null !=  person.getUserId() && person.getUserId() !="") {
			int count = mapper.queryCountByUserId(person.getUserId());
			if (count > 0) {
				return -1;
			}
		}
		//科室id不是null就添加查询科室名
		if (StringUtils.isNotBlank(person.getDepartmentId())) {
			//根据科室id获取科室名
			Department dept = dept2Mapper.selectByPrimaryKey(person.getDepartmentId());
			person.setDepartmentName(dept.getDpName());
		}
		//职位id不是null就添加查询职位名
		if (StringUtils.isNotBlank(person.getProfessionalId() )) {
			//根据职位id获取职位名称名
			Professional pro = proMapper.selectByPrimaryKey(person.getProfessionalId());
			person.setDepartmentName(pro.getProfessionalName());
		}
		person.setPpState("A");
		int count = mapper.insertSelective(person);
		//如果数据添加成功添加图片
		if (count > 0) {
			//如果图片不是空就上传图片
			if (!picFile.isEmpty()) {
				String ppPic = FileUtils.saveFile(picFile);
				Person person2 = new Person();
				person2.setPpId(person.getPpId());
				person2.setPpPic(ppPic);
				return mapper.updateByPrimaryKeySelective(person2);		
			}else {
				return count;
			}
		}
		return 0;
	}
	/**
	 * 根据id查询人员
	 */
	@Override
	public Person queryById(String id) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(id);
	}
	/**
	 * 根据科室id查询科室类别
	 */
	@Override
	public Departmenttype queryByDeptTypeByDeptId(String departmentId) {
		// TODO Auto-generated method stub
		return deptMapper.queryByDeptTypeByDeptId(departmentId);
	}
	/**
	 * 修改人员
	 */
	@Override
	@Transactional()
	public int editPerson(Person person, MultipartFile picFile) {
		//科室id不是null就添加查询科室名
		if (StringUtils.isNotBlank(person.getDepartmentId())) {
			//根据科室id获取科室名
			Department dept = dept2Mapper.selectByPrimaryKey(person.getDepartmentId());
			person.setDepartmentName(dept.getDpName());
		}
		//职位id不是null就添加查询职位名
		if (StringUtils.isNotBlank(person.getProfessionalId() )) {
			//根据职位id获取职位名称名
			Professional pro = proMapper.selectByPrimaryKey(person.getProfessionalId());
			person.setDepartmentName(pro.getProfessionalName());
		}
		int count = mapper.updateByPrimaryKeySelective(person);
		//如果数据添加成功添加图片
		if (count > 0) {
			//如果图片不是空就上传图片
			if (!picFile.isEmpty()) {
				String ppPic = FileUtils.saveFile(picFile);
				Person person2 = new Person();
				person2.setPpId(person.getPpId());
				person2.setPpPic(ppPic);
				//修改前取出文件地址
				Person person3 = mapper.selectByPrimaryKey(person.getPpId()); 
				//修改pic字段
			    mapper.updateByPrimaryKeySelective(person2);	
			    //删除图片
			    FileUtils.deleteFileByUrl(person3.getPpPic());
			    return 1;
			}else {
				return count;
			}
		}
		return 0;
	}
	/**
	 * 删除人员
	 */
	@Override
	@Transactional()
	public int delPerson(String ids) {
		int count = 0;
		String[] str = ids.split(",");
		for (String id : str) {
			//根据人员id删除医生疾病表
			docTllMapper.deleteByPersonId(id);
			//根据人员 id 删除出诊时间表
			visiMapper.deleteByPersonId(id);
			//根据人员is删除排班表
			sechMapper.deleteByPersonId(id);
			//根据id查询person
			Person person = mapper.selectByPrimaryKey(id);
			int  count2 = mapper.deleteByPrimaryKey(id);
			count +=count2;
			if (count2 > 0) {
				FileUtils.deleteFileByUrl(person.getPpPic());
			}
		}
		return count;
	}

}
