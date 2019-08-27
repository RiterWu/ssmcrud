package com.xwh.entity;

import org.hibernate.validator.constraints.Length;
import sun.misc.Regexp;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

/**
 * 员工
 */
public class Employee {
    private Integer id;
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",
            message = "用户名必须是6-16位英文和数字或者2-5位中文的组合")
    private String empName;

    private String gender;
    //@Email
    @Pattern(regexp = "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$",
            message = "邮箱格式不正确!")
    private String email;

    private Integer deptId;

    private Department department;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender == null ? null : gender.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Employee() {
    }

    public Employee(Integer id, String empName, String gender, String email, Integer deptId) {
        this.id = id;
        this.empName = empName;
        this.gender = gender;
        this.email = email;
        this.deptId = deptId;
    }
}