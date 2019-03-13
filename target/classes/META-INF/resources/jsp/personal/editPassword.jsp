<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="com.yunzhong.appointment.config.SessionConst"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="/jsp/common/common.jsp"%>
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
		

      
			<form class="form form-horizontal" name="passwordForm" method="post" action="javaScript:doSub()">
			  <div id="tjdiv" class="container" style="margin-top: 10px;">
			        <input name="patientTel" id="uer" value="${userName}"class="form-control" type="hidden" />
			        <div class="form-group">
						<label class="control-label col-sm-3 col-sm-offset-1">原密码：</label>
						<div class="col-sm-4">
							<input name ="Pass" class="form-control" type="password"   placeholder="请输入新密码" />
						</div>
					</div>	
					<div class="form-group">
						<label class="control-label col-sm-3 col-sm-offset-1">设置新密码：</label>
						<div class="col-sm-4">
							<input name ="userPass" id="userPass" class="form-control" type="password"   placeholder="请输入新密码" />
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
	//表单验证
	$(function(){
	$("form[name='passwordForm']").validate({
		rules: {	
			Pass: {
				required : true
			},
			userPass: {
				required : true,
				pass:true
			},
			userPass2: {
				required : true,
				equalTo: "#userPass"	//两个密码必须一致
			}
		},
		//下面的messages可以修改提示文字.
		messages:{
			Pass: {
				required : "请输入原密码",
			},
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
		//提交
		function doSub(){
						
			bootbox.confirm("是否要修改密码？",function(result){
				if(result){
					url = "<%=ctx%>/personal/editpass";
					data = $("form[name='passwordForm']").serialize();
					$.post(url,data,function(r){
						if (r.success) {
							bootbox.confirm({
								title:"提示",
								message:"密码修改成功,请重新登陆",
								size:"small",
								buttons: {  
									cancel: {  
										label: '取消',  
										className: 'btn-default'  
									},
									confirm: {  
										label: '确定',  
										className: 'btn-primary'  
									}
								},
								callback: function(r) {  
									if(r) {  
										 window.parent.location.href='<%=ctx%>/logout';
									}else{
										 window.parent.location.href='<%=ctx%>/logout';
									}
								}
							});                     
						} else {
		                    bootbox.alert(r.msg);
						}
					},"json");
				}
			})
		}
	
	</script>
</html>
