package com.xwh.service.impl;

import com.xwh.dao.DepartmentMapper;
import com.xwh.entity.Department;
import com.xwh.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    @Override
    public List<Department> getDepts() {
        return departmentMapper.getDepts();
    }
}
