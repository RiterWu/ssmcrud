package com.xwh.test;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.xwh.entity.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 测试请求功能，检验crud请求的正确性
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml", "classpath:springmvc.xml"})
public class MvcTest {
    //传入SpringMvc的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMokcMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders
                .post("/emp/queryAll")
                .param("pageNum", "5")).andReturn();
        //请求成功以后，请求域中会有pageinfo
        PageInfo page = (PageInfo) result.getRequest().getAttribute("page");
        System.out.println("当前页码：" + page.getPageNum());
        System.out.println("总页码：" + page.getPages());
        System.out.println("总记录数：" + page.getTotal());
        System.out.println("在页面需要连续显示的页码：");
        int[] nums = page.getNavigatepageNums();
        for (int i : nums) {
            System.out.println(" " + i);
        }

        //获取员工数据
        List<Employee> list = page.getList();
        for (Employee e : list) {
            System.out.println("Id:" + e.getId() + "==>Name:" + e.getEmpName() + "==>Email:" + e.getEmail());
        }
    }
}
