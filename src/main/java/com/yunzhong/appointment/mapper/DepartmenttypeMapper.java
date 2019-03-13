package com.yunzhong.appointment.mapper;




import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.util.SelectOptions;

public interface DepartmenttypeMapper {
    int deleteByPrimaryKey(String dplId);

    int insert(Departmenttype record);

    int insertSelective(Departmenttype record);

    Departmenttype selectByPrimaryKey(String dplId);

    int updateByPrimaryKeySelective(Departmenttype record);

    int updateByPrimaryKey(Departmenttype record);
	/**
	 * 查询科目类别
	 * @return
	 */
    @Select("SELECT departmenttype.dpl_id,departmenttype.dpl_name\n" + 
    		"FROM departmenttype")
    @ResultMap("BaseResultMap")
	List<Departmenttype> query();
/**
 * 查询大科室
 * @return
 */
	List<SelectOptions> queryAllDeptByTop();
@Select("SELECT COUNT(*) FROM departmenttype\n" + 
		"where departmenttype.dpl_name=#{param1}")
int validDeptName(String deptName);
/**
 * 
 * @param deptName
 * @return
 */
@Select("SELECT\n" + 
		"departmenttype.dpl_name,departmenttype.dpl_id\n" + 
		"FROM departmenttype\n" + 
		"where departmenttype.dpl_name=#{param1}")
@ResultMap("BaseResultMap")
Departmenttype selectByDplName(String deptName);

/**
 * 根据科室id查询科室类别
 * @param departmentId
 * @return
 */
@Select("SELECT\n" + 
		"	departmenttype.dpl_id,\n" + 
		"	departmenttype.dpl_name\n" + 
		"FROM\n" + 
		"	departmenttype\n" + 
		"INNER JOIN department ON department.dpl_id = departmenttype.dpl_id\n" + 
		"WHERE\n" + 
		"	department.dp_id = #{0}")
@ResultMap("BaseResultMap")
Departmenttype queryByDeptTypeByDeptId(String departmentId);
    
    
}