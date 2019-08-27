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
    pageContext.setAttribute("ctx", request.getContextPath());
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
    <div class="container">
        <%--标题--%>
        <div class="row">
            <div class="col-md-12"><h1>SSM-CRUD</h1></div>
        </div>
        <%--按钮--%>
        <div class="row">
            <div class="col-md-4 col-md-offset-8">
                <button class="btn btn-primary">新增</button>
                <button class="btn btn-danger">删除</button>
            </div>
        </div>
        <%--显示表格数据--%>
        <div class="row">
            <div class="col-md-12">
                <table class="table table-hover">
                    <thead>
                    <tr>
                        <th>员工编号</th>
                        <th>员工姓名</th>
                        <th>性别</th>
                        <th>email</th>
                        <th>所属部门</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.list}" var="obj">
                        <tr>
                            <td>${obj.id}</td>
                            <td>${obj.empName}</td>
                            <td>${obj.gender=="M"?"男":"女"}</td>
                            <td>${obj.email}</td>
                            <td>${obj.department.deptName}</td>
                            <td>
                                <button class="btn btn-primary btn-sm">
                                    <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑
                                </button>
                                <button class="btn btn-danger btn-sm">
                                    <span class="glyphicon glyphicon-trash" aria-hidden="true"></span> 删除
                                </button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <%--显示分页信息--%>
        <div class="row">
            <%--分页文字信息--%>
            <div class="col-md-6">
                当前第${page.pageNum}页，总共${page.pages}页（总共${page.total}条记录）
            </div>
            <%--分页条信息--%>
            <div class="col-md-6">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li><a href="${ctx}/emp/queryAll?pageNum=1">首页</a></li>
                        <c:if test="${page.hasPreviousPage}">
                            <li>
                                <a href="${ctx}/emp/queryAll?pageNum=${page.pageNum-1}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach items="${page.navigatepageNums}" var="num">
                            <li  <c:if test="${num == page.pageNum}">
                                class="active"
                            </c:if> ><a href="${ctx}/emp/queryAll?pageNum=${num}">${num}</a></li>
                        </c:forEach>
                        <c:if test="${page.hasNextPage}">
                            <li>
                                <a href="${ctx}/emp/queryAll?pageNum=${page.pageNum+1}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <li><a href="${ctx}/emp/queryAll?pageNum=${page.pages}">末页</a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

</div>
</body>
</html>
