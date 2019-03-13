<%@page import="com.github.pagehelper.PageInfo"%>
<%@page import="com.yunzhong.appointment.entity.SysUser"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>云众科技网上预约挂号系统</title>
	</head>

	<body>
		<div class="main-container" id="main-container">
			<!-- /section:basics/sidebar -->
			<div class="main-content">
				<div class="main-content-inner">
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12">
								
							<!-- 检索  -->
							<form  method="post" name="infoForm" action="/sys/chooseUserPage">
								<div class="container">
									<div class="col-sm-4" style="margin-top: 20px;">
										<div class="input-group">
											<input type="text" class="form-control" name="userName" placeholder="请输入用户名称" value="${pd.userName }">
									      	<div class="input-group-btn">
					        					<button type="button" class="btn btn-warning" onclick="doSearch()"><span class="glyphicon glyphicon-search"></span></button>
									    	</div>
									    </div>
							    	</div>
							    	<div class="col-sm-6"></div>
							    	<div class="col-sm-2" style="margin-top: 20px;">
										<div class="form-group">
									    </div>
							    	</div>
							    </div>
								<table id="simple-table" class="table table-striped table-hover" style="margin-top:5px;">	
									<thead>
										<tr class="bg-primary">
											<td align="center"><a href="javascript:selectAll()"><font style="color: white;">全选</font></a></td>
											<td align="center">账号</td>
											<td align="center">用户角色</td>
											<td align="center">用户信息</td>
											<td align="center">操作</td>
										</tr>
									</thead>
															
									<tbody>
									<c:choose>
										<c:when test="${not empty pageInfo.list}">
											<c:forEach items="${pageInfo.list}" var="user" varStatus="i">
												<tr>
													<td align="center"><input type="checkbox" name="ids" value="${user.userId}"></td>
													<td align="center">${user.userName}</td>
													<td align="center">${user.roleName}</td>
													<td align="center">${user.userInfo}</td>
													<td  align="center">
														<button type="button" class="btn btn-primary" title="" onclick="chooSe('${user.userId}','${user.userName}')"><span >选择</span></button>
								                    </td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center" >没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
									</tbody>
								</table>
								<div align="center">
									<yzpage:page pageName="pageInfo" url="/sys/chooseUserPage"></yzpage:page>
								</div>
							</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	function chooSe(id,name){
		parent.document.getElementById("userName").value=name;
		parent.document.getElementById("userId").value=id;
		parent.disaBled();
		parent.clooseDiaLog();
	}
	function doSearch(){
		$("form[name='infoForm']").attr("action","/sys/chooseUserPage");
		$("form[name='infoForm']").submit();
	}

	</script>
</html>