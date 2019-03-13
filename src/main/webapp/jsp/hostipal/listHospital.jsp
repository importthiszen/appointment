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
		<style type="text/css">
		html body{
			width: 100%;
		}
		.kuang{
			border:1px solid gainsboro;
			/*圆角*/
			border-radius: 10px ;
			margin: 0px;
		}
		.info_left{
			border: 1px solid gainsboro;
			/*圆角*/
			border-radius: 10px ;
		}
	</style>
	</head>

	<body>
		<div class="main-container" id="main-container">
			<!-- /section:basics/sidebar -->
			<div class="main-content">
				<div class="main-content-inner">
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12">
								
							<form  method="post" name="infoForm" action="/baseinfo/listAnnouncement">
								<div class="container" style="height: 40%;">
								<div style="height: 30px;">
									<p class="text-center " ><p>${hospital.hospitalPic}</p></p>
									<%-- <img src="<%=request.getContextPath() %>/static/img/22.png" style="width: 100%;"/> --%>
								</div>
								</div>
								<div class="container">
									<div class="col-sm-4" style="margin-top: 45px;">
										<div class="input-group">
											<label><h3 class="text-primary" >${hospital.hospitalName}</h3></label>
									    </div>
							    	</div>
							    	<div class="col-sm-6"></div>
							    </div>
								<thead>
									<div class="container">
									<p class="">
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										${hospital.hospitalInfo}
										</p>
										<div class="text-right">
											<a href="<%=request.getContextPath()%>/baseinfo/editHospital?id=${hospital.hospitalId}">修改医院简介>></a>
										</div>
										 </div>
									</thead>															
									<tbody>
									<div class="">
										<h5>我院地址<span class="glyphicon glyphicon-hand-down"></span></h5>
										<div class="container">
											<img src="<%=request.getContextPath() %>/static/img/3.png" style="height: 30%;"/>
										</div>
									</div>
									</tbody>
							</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	function editpage(id){
		location.href = "/baseinfo/editAnnouncementPage?id="+id;
	}
	function addpage(){
		location.href = "/baseinfo/addAnnouncementPage";
	}
	//删除一个
	function delOne(id){
		bootbox.confirm("确定要删除吗?", function(result) {
			if(result){
				var url = "<%=request.getContextPath()%>/baseinfo/del.action";
				var data = {"ids":id};
				//post请求     没有缓存     异步   没有error
				$.post(url, data, function(r) {
					if (r) {
						location.href="<%=request.getContextPath()%>/baseinfo/listAnnouncement.action";
					} else {
						bootbox.alert("删除失败");
					}
				}, "json")
			}
		})
	}
	
	function doSearch(){
		$("form[name='infoForm']").prop("action","<%=request.getContextPath()%>/baseinfo/listAnnouncement.action");
		$("form[name='infoForm']").submit();
	}
	//全选
	function selectAll(){
		var inpts = $("input[name='ids']");
		for(var i=0;i<inpts.length;i++){
			if(inpts[i].checked!=true){
				inpts[i].checked=true;
			}else{
				inpts[i].checked=false;
			}
		}
	}
	
	//批量操作
	function del(){
		var ids=[];
		var idInps = $("input[name='ids']:checked");
		if (idInps.length==0) {
			bootbox.alert("请选择需要删除的记录!");
			return ;
		}
		for (var i = 0; i < idInps.length; i++) {
			ids.push(idInps[i].value);
		}
		bootbox.confirm("确定要删除吗?", function(result) {
			if(result){
				var url = "<%=request.getContextPath()%>/baseinfo/del.action";
				var data = {"ids":ids.join(",")};
				//post请求     没有缓存     异步   没有error
				$.post(url, data, function(r) {
					if (r) {
						location.href="<%=request.getContextPath()%>/baseinfo/listAnnouncement.action";
					} else {
						bootbox.alert("删除失败");
					}
				}, "json")
			}
		})
	};
	</script>
</html>