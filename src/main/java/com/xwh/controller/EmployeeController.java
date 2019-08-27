package com.xwh.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xwh.constant.StatusCodeConstant;
import com.xwh.entity.Employee;
import com.xwh.entity.ResultData;
import com.xwh.service.EmployeeService;
import org.hibernate.validator.internal.util.IdentitySet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import javax.validation.constraints.Email;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/emp")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    /**
     * 查找所有员工信息并以json格式返回
     * <p>
     * 后端校验
     * 1 支持JSR303校验
     * 2 导入Hibernate-Validator
     *
     * @param pageNum
     * @return
     */
    @RequestMapping("/queryAll")
    @ResponseBody
    public ResultData getEmps(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum) {
        //PageHelper分页插件
        PageHelper.startPage(pageNum, StatusCodeConstant.PAGESIZE);
        List<Employee> employees = employeeService.getAll();
        //封装分页信息,navigatePages:连续显示的页数
        PageInfo<Employee> page = new PageInfo<>(employees, StatusCodeConstant.NAVIGATEPAGES);
        return ResultData.success().add("page", page);
    }

   /* @RequestMapping("/queryAll")
    public String index(
            @RequestParam(value = "pageNum",defaultValue = "1") Integer pageNum,
            Model model){
        //PageHelper分页插件
        PageHelper.startPage(pageNum, StatusCodeConstant.PAGESIZE);
        List<Employee> employees = employeeService.getAll();
        //封装分页信息,navigatePages:连续显示的页数
        PageInfo<Employee> page = new PageInfo<>(employees,StatusCodeConstant.NAVIGATEPAGES);
        model.addAttribute("page",page);
        return "list";
    }*/

    /**
     * 添加员工
     *
     * @return
     */
    @RequestMapping("/add")
    @ResponseBody
    public ResultData add(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError e : errors) {
                System.out.println("错误的字段名:" + e.getField());
                System.out.println("错误的信息:" + e.getDefaultMessage());
                map.put(e.getField(), e.getDefaultMessage());
            }
            return ResultData.fail().add("errorFields", map);
        } else {
            boolean flag = employeeService.add(employee);
            return ResultData.success();
        }
    }

    /**
     * 检验用户名是否可用
     *
     * @param empName
     * @return
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public ResultData checkuser(@RequestParam("empName") String empName) {
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regx)) {
            return ResultData.fail().add("va_msg", "用户名必须是6-16位英文和数字或者2-5位中文的组合");
        }
        boolean count = employeeService.checkuser(empName);
        if (count) {
            return ResultData.fail().add("va_msg", "用户名不可用");
        } else {
            return ResultData.success();
        }
    }

    /**
     * 按照员工id查询员工
     *
     * @param id
     * @return
     */
    @RequestMapping("/getEmp/{id}")
    @ResponseBody
    public ResultData getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return ResultData.success().add("emp", employee);
    }

    /**
     * 员工更新
     *
     * @param employee
     * @return
     */
    @RequestMapping("/edit/{id}")
    @ResponseBody
    public ResultData editEmp(@PathVariable("id") Integer id, Employee employee) {
        employee.setId(id);
        boolean flag = employeeService.editEmp(employee);
        return ResultData.success();
    }

    /**
     * 按id删除员工
     * 批量删除：1-5-6
     * 单个删除：1
     *
     * @param del_ids
     * @return
     */
    @RequestMapping("/delete/{del_ids}")
    @ResponseBody
    public ResultData delete(@PathVariable("del_ids") String del_ids) {
        if (del_ids.contains("-")) {
            //批量删除
            List<Integer> ids = new ArrayList<>();
            String[] str_ids = del_ids.split("-");
            for (String id : str_ids) {
                ids.add(Integer.parseInt(id));
            }
           /* for (Integer i:ids){
                System.out.println(i+"===============");
            }*/
            boolean flag = employeeService.deleteBath(ids);
        } else {
            //单个删除
            Integer id = Integer.parseInt(del_ids);
            boolean flag = employeeService.deleteById(id);
        }
        return ResultData.success();

    }
}
