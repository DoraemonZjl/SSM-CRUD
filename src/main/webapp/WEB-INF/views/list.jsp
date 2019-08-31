<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工信息</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- jQuery -->
<script type="text/javascript"
	src="${APP_PATH}/static/js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap -->
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-10">
				<button class="btn btn-default btn-sm">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true">编辑
					
				</button>
				<button class="btn btn-danger btn-sm">
					<span class="glyphicon glyphicon-trash" aria-hidden="true">删除
					
				</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-bordered table-hover">
					<!-- 表头 -->
					<tr>
						<th>id</th>
						<th>Name</th>
						<th>Email</th>
						<th>Gender</th>
						<th>DepartmentName</th>
						<th>操作</th>
					</tr>
					<!-- 数据 -->
					<c:forEach items="${PageInfo.list}" var="emp">
						<tr>
							<th>${emp.id}</th>
							<th>${emp.lastName}</th>
							<th>${emp.email}</th>
							<th>${emp.gender==1 ? "女" : "男"}</th>
							<th>${emp.department.deptName}</th>
							<th>
								<button class="btn btn-default btn-sm">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true">
										编辑
								</button>
								<button class="btn btn-danger btn-sm">
									<span class="glyphicon glyphicon-trash" aria-hidden="true">
										删除
								</button>
							</th>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>
		<!-- 分页 -->
		<div class="row">
			<div class="col-md-6">当前
				${PageInfo.pageNum}页,共${PageInfo.pages}页,共${PageInfo.total}记录.</div>
			<!-- 分页条 -->
			<div class="col-md-6">
				<nav aria-label="Page navigation">
					<ul class="pagination">
						<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
						<c:if test="${PageInfo.hasPreviousPage }">
							<li><a href="${APP_PATH}/emps?pn=${PageInfo.pageNum-1}"
								aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
							</a></li>
						</c:if>
						<c:forEach items="${PageInfo.navigatepageNums}" var="atPageNum">
							<c:if test="${atPageNum == PageInfo.pageNum}">
								<li class="active"><a href="#">${atPageNum}</a></li>
							</c:if>
							<c:if test="${atPageNum != PageInfo.pageNum}">
								<li><a href="${APP_PATH}/emps?pn=${atPageNum}">${atPageNum}</a></li>
							</c:if>
						</c:forEach>
						<c:if test="${PageInfo.hasNextPage}">
							<li><a href="${APP_PATH}/emps?pn=${PageInfo.pageNum+1}"
								aria-label="Next"> <span aria-hidden="true">&raquo;</span>
							</a></li>
						</c:if>
						<li><a href="${APP_PATH}/emps?pn=${PageInfo.pages}">尾页</a></li>

					</ul>
				</nav>
			</div>
		</div>
	</div>
</body>
</html>