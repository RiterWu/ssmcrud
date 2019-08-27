package com.xwh.service;

import com.xwh.entity.Employee;

import java.util.List;

public interface EmployeeService {

    List<Employee> getAll();

    boolean add(Employee employee);

    boolean deleteById(Integer id);

    boolean checkuser(String empName);

    Employee getEmp(Integer id);

    boolean editEmp(Employee employee);

    boolean deleteBath(List<Integer> ids);
}
