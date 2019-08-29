<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/8/21 0021
  Time: 16:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    pageContext.setAttribute("ctx",request.getContextPath());
%>
<html>
<head>
    <title>员工列表</title>
    <!-- 引入jquery-->
    <script type="application/javascript" src="${ctx}/static/js/jquery/jquery-3.4.1.min.js"></script>
    <!-- 引入样式-->
    <link href="${ctx}/static/js/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <!-- 加载 Bootstrap 的所有 JavaScript 插件。你也可以根据需要只加载单个插件。 -->
    <script type="application/javascript" src="${ctx}/static/js/bootstrap-3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<div>
    <!-- 员工添加模态框Modal -->
    <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName" class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="empName" id="empName" placeholder="请输入员工姓名">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email" placeholder="email@qq.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_male" value="M" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_lady" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">部门</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="dept_info" name="deptId">
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 员工修改模态框Modal -->
    <div class="modal fade" id="empEditModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">员工添加</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="empName" class="col-sm-2 control-label">姓名</label>
                            <div class="col-sm-10">
                                <p class="form-control-static" id="empName_update"></p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="email" class="col-sm-2 control-label">Email</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="email" id="email_update" placeholder="email@qq.com">
                                <span class="help-block"></span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">性别</label>
                            <div class="col-sm-10">
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_male_update" value="M" checked> 男
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="gender" id="gender_lady_update" value="F"> 女
                                </label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">部门</label>
                            <div class="col-sm-3">
                                <select class="form-control" id="dept_info_update" name="deptId">
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                </div>
            </div>
        </div>
    </div>

    <div class="container">
            <%--标题--%>
        <div class="row">
            <div class="col-md-12"><h1>SSM-CRUD</h1></div>
        </div>
            <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary" id="emp_add_modal">新增</button>
                <button class="btn btn-danger" id="emp_detele_all">删除</button>
            </div>
        </div>
            <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover" id="emps_table">
                    <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all">
                            </th>
                            <th>员工编号</th>
                            <th>员工姓名</th>
                            <th>性别</th>
                            <th>email</th>
                            <th>所属部门</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>

                    </tbody>
                </table>
            </div>
        </div>
            <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6" id="page_info_area">

            </div>
            <%--分页条信息--%>
            <div class="col-md-6" id="page_nav_area">

            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    var totalRecord,currentPage;
    $(function () {
        //首页
        to_page(1);

        //删除员工
        $("#btn_delete").click(function () {
            alert("您确定要删除此记录吗?"+empId);
            $.ajax({
                url:"${ctx}/emp/delete",
                type:"POST",
                data:empId,
                success:function (result) {
                    alert(result.msg);
                }
            })
        })
    })

    //跳转到第pageNum页
    function to_page(pageNum){
        $.ajax({
            url:"${ctx}/emp/queryAll",
            data:"pageNum="+pageNum,
            type:"post",
            success:function (result) {
                //console.log(result);
                //员工数据
                build_emp_table(result);
                //分页信息
                build_page_info(result);
                //分页栏
                build_page_nav(result);
            }
        });
    }

    //表格信息
    function build_emp_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.data.page.list;
        $.each(emps,function (index,item) {
            //alert(item.empName);
            var  checkBox_td = $("<td><input type='checkbox' class='check_item'/></td>");
            var empId_td = $("<td></td>").append(item.id);
            var empName_td = $("<td></td>").append(item.empName);
            var gender_td = $("<td></td>").append(item.gender=='M'?"男":"女");
            var email_td = $("<td></td>").append(item.email);
            var deptName_td = $("<td></td>").append(item.department.deptName);
               /* <button class="btn btn-primary btn-sm">
                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑
                </button>*/
            var btn_edit = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-pencil")
                .append("编辑").attr("empId",item.id);
            var btn_delete = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")
                .append("删除")).attr("empId",item.id);
            var btn_td = $("<td></td>").append(btn_edit).append(" ").append(btn_delete);
            $("<tr></tr>").append(checkBox_td).append(empId_td).append(empName_td).append(gender_td)
                .append(email_td).append(deptName_td).append(btn_td).appendTo("#emps_table tbody");

        })
    }
    //分页信息
    function build_page_info(result) {
        $("#page_info_area").empty();
        var pageNum = result.data.page.pageNum;
        var pages = result.data.page.pages;
        var total = result.data.page.total;
        $("#page_info_area").append( "当前第"+ pageNum+"页，" +
            "总共"+pages+"页（总共"+total+"条记录）");
        totalRecord = total;
        currentPage = pageNum;
    }
    //分页栏
    function build_page_nav(result) {
        $("#page_nav_area").empty();
        var ul = $("<ul></ul>").addClass("pagination");
        var firstpage_li = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
        var prepage_li = $("<li></li>").append($("<a></a>").append("&laquo;"));
        if (result.data.page.hasPreviousPage == false) {
            firstpage_li.addClass("disabled");
            prepage_li.addClass("disabled");
        }else {
            firstpage_li.click(function () {
                to_page(1);
            });
            prepage_li.click(function () {
                to_page(result.data.page.pageNum-1);
            });
        }
        ul.append(firstpage_li).append(prepage_li);
        $.each(result.data.page.navigatepageNums, function (index, item) {
            var num_li = $("<li></li>").append($("<a></a>").append(item));
            if (result.data.page.pageNum == item) {
                num_li.addClass("active");
            }
            num_li.click(function () {
                to_page(item);
            });
            ul.append(num_li);
        });
        var nextpage_li = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastpage_li = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
        if (result.data.page.hasNextPage == false) {
            nextpage_li.addClass("disabled");
            lastpage_li.addClass("disabled");
        }else{
            nextpage_li.click(function () {
                to_page(result.data.page.pageNum+1);
            });
            lastpage_li.click(function () {
                to_page(result.data.page.pages);
            });
        }
        ul.append(nextpage_li).append(lastpage_li);
        var nav_ele = $("<nav></nav>").append(ul);
        nav_ele.appendTo("#page_nav_area");
    }

    //清除表单数据和样式
    function reset_form(ele){
        //清除表单数据
        $(ele)[0].reset();
        //清除表单样式
        $(ele).find("*").removeClass("has-error has-sueecss");
        $(ele).find(".help-block").text("");

    }

    //点击新增按钮，弹出模态框
    $("#emp_add_modal").click(function () {
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({
            backdrop:"static"
        });
    });
    //发送ajax请求，查出部门信息，显示在下拉列表中
    function getDepts(ele) {
        //清除之前下拉列表的值
        $(ele).empty();
        $("#dept_info").empty();
        $.ajax({
            url:"${ctx}/dept/queryDept",
            type:"post",
            success:function (result) {
                //console.log(result);
                //显示在下拉列表中
                $.each(result.data.depts,function (index, item) {
                    var html = $("<option value='"+item.id+"'>"+item.deptName+"</option>");
                    $("#dept_info_update").append(html);
                })

            }
        });
    }

    //检验用户名是否可用
    $("#empName").change(function () {
        var empName = this.value;
        $.ajax({
            url:"${ctx}/emp/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function(result){
                if(result.code == 100){
                    show_validate_msg("#empName","success","用户名可用");
                    $("#emp_save_btn").attr("ajax-va","success");
                }else {
                    show_validate_msg("#empName","error",result.data.va_msg);
                    $("#emp_save_btn").attr("ajax-va","error");
                }
            }
        });
    })

    //前端数据校验
    function validate_add_from(){
        //1 校验姓名
        var empName = $("#empName").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if(!regName.test(empName)){
            show_validate_msg("#empName","error","用户名可以是2-5位中文或者6-16位英文和数字的组合！");
            return false;
        }else{
            show_validate_msg("#empName","success","");
        }
        //2 校验Email
        var email = $("#email").val();
        var regEmail = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email","error","邮箱格式不正确!");
            return false;
        }else{
            show_validate_msg("#email","success","");
        }
        return true;
    }
    //封装验证信息
    function show_validate_msg(ele,status,msg){
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if("success" == status){
            $(ele).parent().addClass("has-success");
        }else if("error" == status){
            $(ele).parent().addClass("has-error");
        }
        $(ele).next("span").text(msg);
    }

    //添加员工
    $("#emp_save_btn").click(function () {

        //前端数据校验
        if(!validate_add_from()){
            return false;
        }
        //判断用户名检验是否成功，成功则发送add请求
        if($(this).attr("ajax-va")=="error"){
            return false;
        }
        //发送add请求
        $.ajax({
            url:"${ctx}/emp/add",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                //alert(result.msg);
                if(result.code == 100){
                    //保存成功
                    //1 关闭模态框
                    $("#empAddModal").modal('hide');
                    //2 来到最后一页，显示刚添加员工信息
                    to_page(totalRecord);
                }else {
                    //显示失败信息
                    //console.log(result);

                    // alert(result.data.errorFields.email);
                    // alert(result.data.errorFields.empName);
                    if(undefined != result.data.errorFields.email){
                        //显示邮箱错误信息
                        show_validate_msg("#email","error",result.data.errorFields.email);
                    }
                    if(undefined != result.data.errorFields.empName){
                        //显示用户名错误信息
                        show_validate_msg("#empName","error",result.data.errorFields.empName);
                    }
                }


            }
        })
    });

    //在按钮创建之前就绑定了click
    $(document).on("click",".edit_btn",function () {
        //alert("edit");
        getDepts("#empEditModal select");
        getEmp($(this).attr("empId"));
        $("#emp_update_btn").attr("empId",$(this).attr("empId"));
        //弹出模态框
        $("#empEditModal").modal({
            backdrop:"static"
        });
    });

    //查询员工信息
    function getEmp(id) {
        $.ajax({
            url:"${ctx}/emp/getEmp/"+id,
            type:"post",
            success:function (result) {
                //console.log(result);
                var empData = result.data.emp;
                $("#empName_update").text(empData.empName);
                $("#email_update").val(empData.email);
                $("#empEditModal input[name=gender]").val([empData.gender])
                $("#empEditModal select").val([empData.deptId]);

            }
        });
    }
    
    //点击更新，更新员工信息
    $("#emp_update_btn").click(function () {
        //alert("123");
        //1 验证邮箱
        var email = $("#email_update").val();
        var regEmail = /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.[a-zA-Z0-9]{2,6}$/;
        if(!regEmail.test(email)){
            show_validate_msg("#email_update","error","邮箱格式不正确!");
            return false;
        }else{
            show_validate_msg("#email_update","success","");
        }
        //2 发送ajax请求
        $.ajax({
            url:"/emp/edit/"+$(this).attr("empId"),
            type:"POST",
            data: $("#empEditModal form").serialize(),
            success:function (result) {
                //console.log(result.msg);
                if (result.code == 100) {
                    //保存成功
                    //1 关闭模态框
                    $("#empEditModal").modal('hide');
                    //2 来到最后一页，显示刚添加员工信息
                    to_page(currentPage);
                }
            }
         });
    })

    //删除单个员工
    $(document).on("click",".delete_btn",function () {
        //alert("delete");$(this).attr("empId")
        //此id员工姓名
        var empName = $(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确认删除【"+empName+"】吗？")){
            $.ajax({
                url:"/emp/delete/"+$(this).attr("empId"),
                type:"POST",
                success:function(result) {
                    //alert(result.msg);
                    to_page(currentPage);
                }
            });
        }
    });

    //checkBox全选/全不选功能
    $("#check_all").click(function () {
        //attr获取checked是undefined；
        //用prop修改和读取dom原生属性的值
        //alert($(this).prop("checked"));
        $(".check_item").prop("checked",$(this).prop("checked"));
    })

    $(document).on("click",".check_item",function () {
       //判断当前选中的元素是否5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    })
    
    //批量删除
    $("#emp_detele_all").click(function () {
        var empNames = "";
        var del_ids = "";
        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //拼接i为：8-5-3
            del_ids += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        empNames = empNames.substring(0,empNames.length-1);
        del_ids = del_ids.substring(0,del_ids.length-1);
        if(confirm("您确认删除【"+empNames+"】吗？")){
            //alert(del_ids);
            //发送ajax请求删除
            $.ajax({
                url:"${ctx}/emp/delete/"+del_ids,
                type:"POST",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });

        }
    })

</script>
</body>
</html>
