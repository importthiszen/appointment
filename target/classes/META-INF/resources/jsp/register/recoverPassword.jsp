<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="com.yunzhong.appointment.config.SessionConst"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../jsp/common/common.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<%--bootbox --%>
		<script src="../../static/js/bootbox.js"></script>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>云众科技网上预约挂号系统</title>
	</head>
	<style>
		html body{
			width: 100%;
		}
		.piaoyikuang{
			border: 1px solid #66AFE9;
			border-radius: 10px;
		}
		.piaoyi{
			float: left;
			width: 100px;
			height: 30px;
			border: 0px solid #66AFE9;
			text-align: center;
		}
		.ks-left{
			border: 1px solid #66AFE9;
			border-radius: 10px;
			margin-right: 0px;
		}
		.ks-right{
			border: 0px solid #66AFE9;
			border-radius: 10px;
		}
		 label.error {
			color: red;
			margin-left: 0px;
			width: auto;
			display: inline;
	      }
	</style>
	<body>
		
		<!--
        	作者：石洪刚
        	时间：2017年8月10日14:12:50
        	描述：个人中心	联系我们	登录	注册
        -->
		<div class="container">
			<nav class="nav navbar-default navbar-fixed-top container-fluid" role="navigation" style="background-color:aquamarine;">
				<div class="nav navbar-header">
					<!-- 导航头 -->
					<a class="navbar-brand" href="#">云众科技</a>
					<button class="navbar-toggle" data-toggle= "collapse" data-target="#mynav">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				</div>
				<div class="collapse navbar-collapse" id="mynav">
					<!-- 导航内容 -->
<!-- 					<ul class="nav navbar-nav"> -->
<!-- 						<li><a href="">联系电话：0451-87362836</a></li> -->
<!-- 						下面的代码需要登录后才能显示	 -->
<%-- 						<% --%>
<!--  						 	Subject currentUser = SecurityUtils.getSubject(); -->
<!--  							String userName = (String)currentUser.getSession().getAttribute(SessionConst.SESSION_USERNAME); -->
<%-- 						%> --%>
<!-- 							<li><a href="huanzhe_personinfo.html">个人中心</a></li> -->
<%-- 							<li><a href="#"><span class="glyphicon glyphicon-user"></span>欢迎您：<%=userName %></a></li> --%>
<!-- 					</ul> -->
					<!-- 导航尾，登录后不再显示 -->
					<div class="nav navbar-right">
						<ul class="nav navbar-nav">
                            <li><a href="<%=ctx%>/login">登录</a></li>
							<li><a href="<%=ctx%>/register/add">注册</a></li>
						</ul>
					</div>	
				</div>
			</nav>
		</div>
		<!--
        	作者：石洪刚
        	时间：2017年8月10日14:32:38
        	描述：项目名称   搜索框 （搜索框只有游客或患者可见）
        -->
		<div class="container" style="margin-top: 50px;">
			<div class="col-sm-6" >
				<h2 class="text-primary" >云众科技网上预约挂号系统</h2>
			</div>
			
			<div class="col-sm-6" style="margin-top: 15px;">
				<form method="post" name="form1" class="form form-horizontal">
					<div class="input-group">
					     <div class="input-group-btn">
						    <button id="index_search_btn" type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">科室<span class="caret"></span></button>
						       <ul class="dropdown-menu" role="menu">
						         <li><a href="#">科室</a></li>
						         <li><a href="#">疾病</a></li>
						       </ul>
					     </div><!-- /btn-group -->
					     <input type="text" class="form-control" placeholder="请输入搜索内容" >
					     <span class="input-group-addon" style="background-color:#f0ad4e;cursor: pointer;" >
						   <span class="glyphicon glyphicon-search "></span>
					     </span>
					</div>
				 </form>
			</div>
			
		</div>
		<!--
        	作者：石洪刚
        	时间：2017年8月10日17:04:47
        	描述：导航条   游客可见(在dashboard页) ：按科室挂号  按疾病挂号  最新公告
        -->
		<div class="container" style="margin-top: 10px;">
			<ul class="nav nav-pills guahao" role="tablist" style="background-color:lightcyan">
			  	<li class="active"><a href="../dashboard.html">首页</a></li>
			  	<li ><a href="../appointment/dept/listDept.html">按科室预约</a></li>
				<li ><a href="../appointment/illness/listIllness.html">按疾病预约</a></li>
				<li ><a href="../newestAnnoucement/listAnnouncement.html">最新公告</a></li>
			</ul>
		</div>
		<!--
        	作者：石洪刚
        	时间：2017年10月26日11:44:45
        	描述：注册信息
        -->
       <form class="form form-horizontal" name="yzForm" method="post" action="javaScript:yzSub()">
       <div class="container" style="margin-top: 10px;">
	         <ul class="nav nav-tabs" role="tablist" id="myTab">
			  <li class="active"><a href="#huanze_login" role="tab" data-toggle="tab">找回密码</a></li>
			 </ul>
			<div id="yzdiv">
	         <div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">手机号码：</label>
					<div class="col-sm-4">
						<input name="patientTel" id="pt" class="form-control" type="text" placeholder="请输入注册时所填的手机号码" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">手机验证码：</label>
					<div class=" col-sm-4">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="请您输入手机验证码">
							<span class="input-group-btn">
								<button class="btn btn-primary" type="button">
									获取验证码
								</button>
							</span>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1" >姓名：</label>
					<div class="col-sm-4">
						<input name="patientName" class="form-control" type="text" placeholder="请输入注册时所填的姓名"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">身份证号：</label>
					<div class="col-sm-4">
						<input name="patientUid"  class="form-control" type="text"  placeholder="请输入注册时所填的身份证号"/>
					</div>
				</div>
				<div class="form-group text-center">
						<label class="control-label col-xs-2"></label>
						<div class="col-xs-5">
							<button class="btn btn-lg btn-warning" type="submit" >验&nbsp;&nbsp;证</button>
						</div>
				</div>
			 </div>
			</form>	
			<form class="form form-horizontal" name="passwordForm" method="post" action="javaScript:doSub()">
			  <div id="tjdiv" class="container" style="margin-top: 10px;display: none;">
			        <input name="patientTel" id="uer" class="form-control" type="hidden" />	
					<div class="form-group">
						<label class="control-label col-sm-3 col-sm-offset-1">设置新密码：</label>
						<div class="col-sm-4">
							<input name ="userPass" id="userPass"  class="form-control" type="password"   placeholder="请输入新密码" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-3 col-sm-offset-1">确认密码：</label>
						<div class="col-sm-4">
							<input name="userPass2" class="form-control" type="password"   placeholder="请确认登录密码"/>
						</div>
					</div>
					<div class="form-group text-center">
						<label class="control-label col-xs-2"></label>
						<div class="col-xs-5">
							<button class="btn btn-lg btn-success" type="submit" >提&nbsp;&nbsp;交</button>
						</div>
					</div>
			   </div>
			 </div> 
		    </form>
	</body>
	<script type="text/javascript">
	     var bj = false;
		//验证是否存在对应的身份和账户
		function yzSub(){
			url = "<%=ctx%>/register/verify";
			data = $("form[name='yzForm']").serialize();
			$.post(url,data,function(r){
				if (r.success) {
					bootbox.alert("验证通过,请设置新的密码");
					bj = true;
					var tel = $("#pt").val();
					$("#uer").val(tel);
					document.getElementById("yzdiv").style.display="none";
					document.getElementById("tjdiv").style.display="";
				} else {
                    bootbox.alert("您提交的信息不符,无法通过验证");
				}
			},"json");
		}
		//提交
		function doSub(){
			if (bj) {			
			bootbox.confirm("是否要修改密码？",function(result){
				url = "<%=ctx%>/register/recoverpass";
				data = $("form[name='passwordForm']").serialize();
				$.post(url,data,function(r){
					if (r.success) {
						bootbox.alert("重置密码成功,可以登录啦");
						location.href="<%=request.getContextPath() %>/login";
					} else {
	                    bootbox.alert("网络出了点小差请稍后重试");
					}
				},"json");
			})
			}
		}
		//表单验证
		$(function(){
		$("form[name='yzForm']").validate({
			rules: {	
				patientTel: {
					required : true,
					telphone : true
				},
				patientName: {
					required : true,
					chanese:true
				},
				patientUid: {
					required : true,
					idcard:true
				}
			},
			//下面的messages可以修改提示文字.
			messages:{
				patientTel: {
					required : "请输入手机号",
					telphone : "请输入正确的手机号"
				},
				patientName: {
					required : "请输入注册时所填的名字",
					chanese:"请填写汉字"
				},
				patientUid: {
					required : "请输入注册时所填的身份证号",
					idcard :"身份证格式错误"
				}
			 },
			submitHandler: function() {
				yzSub();
			},
	    	});
	    });
		//提交密码表单验证
		$(function(){
		$("form[name='passwordForm']").validate({
			rules: {	
				userPass: {
					required : true,
					pass: true
				},
				userPass2: {
					required : true,
					equalTo: "#userPass"	//两个密码必须一致
				}
			},
			//下面的messages可以修改提示文字.
			messages:{
				userPass: {
					required : "密码不能为空",
					pass:"密码至少包含大写字母，小写字母，数字，且不少于8位"
				},
				userPass2: {
					required : "确认密码不能为空",
					equalTo: "两次密码不一致"
				}
			 },
			submitHandler: function() {
				doSub();
			},
	    	});
	    });
	</script>
</html>
