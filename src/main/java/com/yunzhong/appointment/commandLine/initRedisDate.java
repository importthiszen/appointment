package com.yunzhong.appointment.commandLine;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.data.redis.core.ListOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;

import com.yunzhong.appointment.config.Const;
import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.mapper.DepartmentMapper;
import com.yunzhong.appointment.mapper.DepartmenttypeMapper;

/**
 * 初始化redis查询科室 
 * @author 峰
 *
 */
@Component
public class initRedisDate implements CommandLineRunner {
    @Autowired
    private RedisTemplate<String,Object> RedisTemplate;
    /**
     * 科室大类别接口
     */
    @Autowired
    private  DepartmenttypeMapper depetypeMapper;
    /**
     * 科室小类别类口
     */
    @Autowired
    private DepartmentMapper deptMapper;
	@Override
	public void run(String... arg0) throws Exception {
		RedisTemplate.delete(Const.DEPEPARTMENTTYPE);
		ListOperations opsForList = RedisTemplate.opsForList();
		//查询大科室
		List<Departmenttype> deptTypeList = depetypeMapper.query();
		for (int i = 0; i < deptTypeList.size(); i++) {
			Departmenttype dpl = deptTypeList.get(i);
			List<Department> deptList = deptMapper.queryDeptBydplId(dpl.getDplId());
			dpl.setDepeList(deptList);//装入小类别
			opsForList.rightPush(Const.DEPEPARTMENTTYPE, dpl);//装入redis
		}

		
	}

	
}
