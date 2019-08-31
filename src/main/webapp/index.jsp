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

	<!-- 员工修改的模态框 -->
	<div class="modal fade" id="updateEmpModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">修改员工信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="lastName_update_static"></p>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_update" placeholder="email@kayoshi.top"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_update_1" value="1" checked="checked">
									女
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_update_0" value="0"> 男
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<!-- 部门提交部门id即可 -->
								<select class="form-control" name="dId" id="dept_update_list">

								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						id="updateEmpModal_updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 员工添加的模态框 -->
	<div class="modal fade" id="addEmpModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">姓名</label>
							<div class="col-sm-10">
								<input type="text" name="lastName" class="form-control"
									id="lastName_add" placeholder="姓名"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="text" name="email" class="form-control"
									id="email_add" placeholder="email@kayoshi.top"> <span
									class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender_add_1" value="1" checked="checked">
									女
								</label> <label class="radio-inline"> <input type="radio"
									name="gender" id="gender_add_0" value="0"> 男
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">部门</label>
							<div class="col-sm-4">
								<!-- 部门提交部门id即可 -->
								<select class="form-control" name="dId" id="dept_add_list">

								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"
						id="addEmpModal_saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 确认删除静态框 -->
	<div class="modal fade" id="delEmpModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">删除模块</h4>
				</div>
				<div class="modal-body">
					<h4>确定要删除此条员工信息吗？</h4>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消删除</button>
					<button type="button" class="btn btn-danger"
						id="delEmpModal_delBtn">确认删除</button>
				</div>
			</div>
		</div>
	</div>


	<!---------------------------------------------------------------------- -->
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
				<button class="btn btn-default btn-sm" id="addemp">
					<span class="glyphicon glyphicon-pencil" aria-hidden="true">新增
					
				</button>
				<button class="btn btn-danger btn-sm" id="delemps">
					<span class="glyphicon glyphicon-trash" aria-hidden="true">删除
					
				</button>
			</div>
		</div>
		<!-- 表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-bordered table-hover" id="emps_table">
					<!-- 表头 -->
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all"></th>
							<th>id</th>
							<th>Name</th>
							<th>Email</th>
							<th>Gender</th>
							<th>DepartmentName</th>
							<th>操作</th>
						</tr>
					</thead>
					<!-- 数据 -->
					<tbody>

					</tbody>
				</table>
			</div>
		</div>
		<!-- 分页和分页条 -->
		<div class="row">
			<!-- 分页 -->
			<div class="col-md-6" id="page_info"></div>
			<!-- 分页条 -->
			<div class="col-md-6" id="page_nav"></div>
		</div>
	</div>



	<!-- Ajax -->
	<script type="text/javascript">
		var totalRecord;
		var currentPage;

		$(function() {
			toClickPage(1);
		})

		function toClickPage(pn) {
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn=" + pn,
				type : "GET",
				success : function(result) {
					//解析数据
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
			})
		}

		function build_emps_table(result) {
			//清空table
			$("#emps_table tbody").empty();
			//--------------------------------------------------------------------
			var emps = result.extend.PageInfo.list;
			$.each(emps, function(index, item) {
				//构建单元格
				var checkBox = $("<td><input type='checkbox' class='check_item'/></td>");
				var empId = $("<td></td>").append(item.id);
				var empName = $("<td></td>").append(item.lastName);
				var empGender = $("<td></td>").append(
						item.gender == "1" ? "女" : "男");
				var empEmail = $("<td></td>").append(item.email);
				var empDepartment = $("<td></td>").append(
						item.department.deptName);
				var editBtn = $("<button></button>").addClass(
						"btn btn-primary btn-sm edit_btn").append(
						$("<span></span>").addClass(
								"glyphicon glyphicon-pencil")).append("编辑");
				//id
				editBtn.attr("edit_empId",item.id);
				
				var delBtn = $("<button></button>").addClass(
						"btn btn-danger btn-sm delete_btn").append(
						$("<span></span>")
								.addClass("glyphicon glyphicon-trash")).append(
						"删除");
				delBtn.attr("del_empId",item.id);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(
						delBtn);
				$("<tr></tr>").append(checkBox).append(empId).append(empName).append(empGender)
						.append(empEmail).append(empDepartment).append(btnTd)
						.appendTo("#emps_table tbody");
			})
		}

		function build_page_info(result) {
			//清空
			$("#page_info").empty();
			//--------------------------------------------------------------------
			//总记录
			var total = result.extend.PageInfo.total;
			//当前页数
			var pageNum = result.extend.PageInfo.pageNum;
			//总页数
			var pages = result.extend.PageInfo.pages
			$("#page_info").append(
					"当前" + pageNum + "页,共" + pages + "页,共" + total + "记录.");

			totalRecord = total;
			currentPage = pageNum;

		}

		function build_page_nav(result) {
			//清空
			$("#page_nav").empty();
			//--------------------------------------------------------------------
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPage = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));
			var previous = $("<li></li>")
					.append($("<a></a>").append("&laquo;"));
			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;"));
			var lastPage = $("<li></li>").append(
					$("<a></a>").append("尾页").attr("href", "#"));
			//判断是否有上一页,如有则绑定点击翻页事件
			if (result.extend.PageInfo.hasPreviousPage == false) {
				firstPage.addClass("disabled");
				previous.addClass("disabled");
			} else {
				firstPage.click(function() {
					toClickPage(1);
				});
				previous.click(function() {
					toClickPage(result.extend.PageInfo.pageNum - 1);
				});
			}
			//判断是否有下一页,如有则绑定点击翻页事件
			if (result.extend.PageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPage.addClass("disabled");
			} else {
				nextPageLi.click(function() {
					toClickPage(result.extend.PageInfo.pageNum + 1);
				});
				lastPage.click(function() {
					toClickPage(result.extend.PageInfo.pages);
				});
			}
			//拼接分页条
			ul.append(firstPage).append(previous)
			$.each(result.extend.PageInfo.navigatepageNums, function(index,
					item) {
				var pagenum = $("<li></li>").append($("<a></a>").append(item));
				if (result.extend.PageInfo.pageNum == item) {
					pagenum.addClass("active");
				}
				pagenum.click(function() {
					toClickPage(item);
				});
				ul.append(pagenum);
			});
			ul.append(nextPageLi).append(lastPage)
			//将分页条插入html中进行显示
			var navDis = $("<nav></nav>").append(ul);
			navDis.appendTo("#page_nav");
		}

		function reset_form(ele){
			//清空表单内容
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-success has-error");
			$(ele).find(".help-block").text("");
		}
		
		//新增按钮点击事件
		$("#addemp").click(function() {
			//先清除数据保证数据的有效性,清空样式等
			reset_form("#addEmpModal form");
			
			//向数据库提交请求获得所有部门信息
			getAllDept("#dept_add_list");
			$('#addEmpModal').modal({
				backdrop : "static"

			})
		})

		//向数据库提交请求获得所有部门信息
		function getAllDept(ele) {
			$(ele).empty();
			$.ajax({
				url : "${APP_PATH}/getAllDept",
				type : "GET",
				success : function(result) {
					/* console.log(result) */
					//显示部门信息下拉列表dept_add_list
					$.each(result.extend.allDept.list, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					})
				}
			})
		}
		
		<!--getEmpWithDeptById-->
		//向数据库提交请求获得对应Id的Employee对象
		 function getEmp(id){
			$.ajax({
				url : "${APP_PATH}/getEmpWithDeptById/"+id,
				type : "GET",	
				success:function(result){
					//console.log(result);
					$("#lastName_update_static").text(result.extend.EmpWithDept.lastName);
					$("#email_update").val(result.extend.EmpWithDept.email);
					$("#updateEmpModal input[name=gender]").val([result.extend.EmpWithDept.gender]);
					$("#updateEmpModal select").val(result.extend.EmpWithDept.department.deptId);
				}
			})
		} 
		
	
		//校验数据
		function validate_add_form() {
			//使用正则表达式进行校验表单提交的姓名
			var lastName_add = $("#lastName_add").val();
			var lastName_exp = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if (!lastName_exp.test(lastName_add)) {
				show_expmsg("#lastName_add", "error",
						"用户名是2-5位中文或者6-16位英文和数字的组合");
				return false;
			} else {
				show_expmsg("#lastName_add", "success", "");
			}
			//校验邮箱
			var email_add = $("#email_add").val();
			var email_exp = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!email_exp.test(email_add)) {
				show_expmsg("#email_add", "error", "邮箱格式错误，请重新输入");
				return false;
			} else {
				show_expmsg("#email_add", "success", "");
			}
			return true;
		}

		function show_expmsg(ele, status, msg) {
			//清除当前元素的校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if (status == "success") {
				$(ele).parent().addClass("has-success")
				$(ele).next("span").text(msg)
			} else if (status == "error") {
				$(ele).parent().addClass("has-error")
				$(ele).next("span").text(msg)
			}
		}
	
		//姓名重复性检查
		$("#lastName_add").change(function(){
			//当改变是发送ajax请求进行重复性检查
			var lastName = this.value;
			$.ajax({
				url : "${APP_PATH}/checkLastName",
				type : "POST",
				data : "lastName="+lastName,
				success:function(result){
					if(result.code == 1){
						show_expmsg("#lastName_add","success","用户名可用");
						$("#addEmpModal_saveBtn").attr("ajax-checkcode","success");
					}else{
						show_expmsg("#lastName_add","error",result.extend.check_msg);
						$("#addEmpModal_saveBtn").attr("ajax-checkcode","error");
					}
				}
			})
		})
		
		
		
		//新增保存按钮点击事件，将填写的表单数据提交给服务器进行保存
		$("#addEmpModal_saveBtn").click(function() {
			//alert($("#addEmpModal form").serialize());
			//前端检验数据
			if (!validate_add_form()) {
				return false;
			}
			//判断是否可以点击发送请求
			if($(this).attr("ajax-checkcode") =="error"){
				return false;	
			}
			$.ajax({
				url : "${APP_PATH}/emp",
				type : "POST",
				data : $("#addEmpModal form").serialize(),
				success : function(result) {
					if(result.code == 1){
						$("#addEmpModal").modal('hide');
						toClickPage(totalRecord);
					}else{
						//失败显示相关错误信息(后端检验)
						//console.log(result);
						if(undefined != result.extend.error.email){
							//显示邮箱错误信息
							show_expmsg("#email_add", "error", result.extend.error.email)
						}
						if(undefined != result.extend.error.lastName){
							//显示名字错误信息
							show_expmsg("#lastName_add", "error",
									result.extend.error.lastName);
						}
					}
				}
			})
		})
		
		//点击修改事件，弹出模态框并数据回显
		$(document).on("click",".edit_btn",function(){
			getAllDept("#dept_update_list");
			getEmp($(this).attr("edit_empid"))	
			//传递员工id
			$("#updateEmpModal_updateBtn").attr("edit_empid",$(this).attr("edit_empid"))
			$('#updateEmpModal').modal({
				backdrop : "static"
			})
		})
		
		//更新按钮事件
		$("#updateEmpModal_updateBtn").click(function(){
			var update_email = $("#email_update").val();
			var email_exp = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!email_exp.test(update_email)) {
				show_expmsg("#email_update", "error", "邮箱格式错误，请重新输入");
				return false;
			} else {
				show_expmsg("#email_update", "success", "");
			}
			$.ajax({
				url : "${APP_PATH}/emp/"+$(this).attr("edit_empid"),
				type : "PUT",
				data : $("#updateEmpModal form").serialize(),
				success:function(result){
					//console.log(result)
				 	//1、关闭对话框+"&_method=PUT"
					$("#updateEmpModal").modal("hide");
					//2、回到本页面
					toClickPage(currentPage); 
				}
			})
		})
	
		//点击删除事件，弹出模态框并数据回显
		$(document).on("click",".delete_btn",function(){
			getAllDept("#dept_update_list");
			getEmp($(this).attr("del_empId"))	
			//传递员工id给模态框的确定删除按钮
			$("#delEmpModal_delBtn").attr("del_empId",$(this).attr("del_empId"))
			$('#delEmpModal').modal({
				backdrop : "static"
			})
		})
		
		//模态框里的确定删除按钮事件
		$("#delEmpModal_delBtn").click(function(){
			$.ajax({
				url : "${APP_PATH}/emp/"+$(this).attr("del_empid"),
				type : "DELETE",
				success:function(result){
					//console.log(result)
				 	//1、关闭对话框+"&_method=PUT"
					$("#delEmpModal").modal("hide");
					//2、回到本页面
					toClickPage(currentPage);  
				}
			})
		})
		
		//全选及全不选功能
		//完成全选/全不选功能
		$("#check_all").click(function(){
			//attr获取checked是undefined;
			//我们这些dom原生的属性；attr获取自定义属性的值；
			//prop修改和读取dom原生属性的值
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//check_item
		$(document).on("click",".check_item",function(){
			//判断当前选择中的元素是否5个
			var flag = $(".check_item:checked").length==$(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除，就批量删除
		$("#delemps").click(function(){
			//
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				//this
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				//组装员工id字符串
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除empNames多余的,
			empNames = empNames.substring(0, empNames.length-1);
			//去除删除的id多余的-
			del_idstr = del_idstr.substring(0, del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】吗？")){
				//发送ajax请求删除
				$.ajax({
					url:"${APP_PATH}/emp/"+del_idstr,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						//回到当前页面
						toClickPage(currentPage);
					}
				});
			}
		});
		
		
	</script>
</body>
</html>