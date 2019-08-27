package com.xwh.test;

import com.xwh.dao.DepartmentMapper;
import com.xwh.dao.EmployeeMapper;
import com.xwh.entity.Department;
import com.xwh.entity.Employee;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class MapperTest1 {
    public static void main(String[] args) {
        String config = "applicationContext.xml";
        ApplicationContext ac = new ClassPathXmlApplicationContext(config);

        DepartmentMapper departmentMapper = (DepartmentMapper) ac.getBean("departmentMapper");
        Department dept = new Department();
        dept.setDeptName("国安局");
        int row = departmentMapper.insert(dept);

        EmployeeMapper employeeMapper = (EmployeeMapper) ac.getBean("employeeMapper");
        Employee employee = new Employee();
        employee.setEmpName("zhangsan");
        employee.setGender("m");
        employee.setDeptId(4);
        employee.setEmail("riter123@qq.com");
        row = employeeMapper.insert(employee);


    }
}
