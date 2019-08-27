package com.xwh.controller;

import com.xwh.entity.Department;
import com.xwh.entity.ResultData;
import com.xwh.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/dept")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
     * 返回所有部门信息
     *
     * @return
     */
    @RequestMapping("/queryDept")
    @ResponseBody
    public ResultData queryDept() {
        List<Department> departments = departmentService.getDepts();
        return ResultData.success().add("depts", departments);
    }

}
