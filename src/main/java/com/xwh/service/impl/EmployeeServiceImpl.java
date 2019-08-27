package com.xwh.service.impl;

import com.xwh.dao.EmployeeMapper;
import com.xwh.entity.Employee;
import com.xwh.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;


    @Override
    public List<Employee> getAll() {
        return employeeMapper.getAll();
    }

    @Override
    public boolean add(Employee employee) {
        return employeeMapper.insertSelective(employee) == 1 ? true : false;
    }

    @Override
    public boolean deleteBath(List<Integer> ids) {
        return employeeMapper.deleteBath(ids) == 1 ? true : false;
    }

    @Override
    public boolean deleteById(Integer id) {
        return employeeMapper.deleteByPrimaryKey(id) == 1 ? true : false;
    }

    @Override
    public boolean checkuser(String empName) {
        return employeeMapper.checkuser(empName);
    }

    @Override
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    @Override
    public boolean editEmp(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee) == 1 ? true : false;
    }
}
