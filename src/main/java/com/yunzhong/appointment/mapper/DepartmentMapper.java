package com.yunzhong.appointment.mapper;



import java.util.List;

import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.Department;
import com.yunzhong.appointment.entity.Departmenttype;
import com.yunzhong.appointment.util.SelectOptions;

public interface DepartmentMapper {
    int deleteByPrimaryKey(String dpId);

    int insert(Department record);

    int insertSelective(Department record);

    Department selectByPrimaryKey(String dpId);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);
	/**
	 * 查询科室及对应的科室类别
	 * @return
	 */
    @Select("SELECT departmenttype.dpl_id,departmenttype.dpl_name,department.dp_id,\n" + 
    		"department.dpl_id,department.dp_name\n" + 
    		"FROM departmenttype\n" + 
    		"INNER JOIN department ON department.dpl_id = departmenttype.dpl_id")
    @ResultMap("BaseResultMap")
	List<Department> queryDepartment();
	/**
	 * 模糊查询科室信息
	 * @param departmentName
	 * @return
	 */
	List<Department> queryBydeptName(String departmentName);
	/**
	 * 根据类别id查询科室
	 * @param dplId
	 * @return
	 */
    @Select("	SELECT\n" + 
    		"	department.dp_id,\n" + 
    		"	department.dpl_id,\n" + 
    		"	department.dp_name\n" + 
    		"	FROM\n" + 
    		"	department\n" + 
    		"	where department.dpl_id = #{0}")
    @ResultMap("BaseResultMap")
	List<Department> queryDeptBydplId(String dplId);
/**
 * 
 * @param dept
 * @return
 */
    List<SelectOptions> queryDeptByOne(SelectOptions dept);
/**
 * 名称不重复验证
 * @param deptName
 * @param deptId
 * @return
 */
@Select("SELECT COUNT(*) FROM department\n" + 
		"where  dp_name=#{param1}")  
int validDeptName(String deptName);


Department queryByDplId(String id);

@Select("SELECT department.dp_id,\n" + 
		"department.dpl_id,department.dp_name\n" + 
		"FROM department where department.dp_name=#{param1}")
@ResultMap("BaseResultMap")
Department selectBydeptName(String deptName);
/**
 * 查询要删除的科室是否被人员占用
 * @param id
 * @return
 */
@Select("SELECT COUNT(*) FROM person where department_id=#{param1}")
int validateFordelete(String id);
/**
 * 查询不能删除的科室名称
 * @param id
 * @return
 */
@Select("SELECT department.dp_name FROM department\n" + 
		"where department.dp_id=#{param1}")
String getdeptNameById(String id);
/**
 * 
 * @param id 参数Id
 * @return
 */
@Select("SELECT department.dp_id,department.dpl_id,department.dp_name\n" + 
		"FROM  department\n" + 
		"where department.dpl_id=#{param1}")
@ResultMap("BaseResultMap")
List<Department> queryAlldeptById(String id);
/**
 * 科室列表
 * @return
 */
@Select("SELECT department.dp_id,department.dp_name FROM department")
@ResultMap("BaseResultMap")
List<Department> queryAll();


//List<Departmenttype> queryAllDeptByTop();

   
}