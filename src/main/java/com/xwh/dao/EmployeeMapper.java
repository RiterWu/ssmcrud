package com.xwh.dao;

import com.xwh.entity.Employee;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmployeeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Employee employee);

    int insertSelective(Employee employee);

    Employee selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Employee employee);

    int updateByPrimaryKey(Employee employee);

    /**
     * 查询所有员工信息
     *
     * @return
     */
    List<Employee> getAll();

    boolean checkuser(@Param("empName") String empName);

    int deleteBath(List<Integer> ids);

}