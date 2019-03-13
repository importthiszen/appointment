<%@page import="com.yunzhong.appointment.entity.SysMenu"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="com.yunzhong.appointment.config.SessionConst"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../../common/common.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>云众科技网上预约挂号系统</title>
	</head>
	<style type="text/css">
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
		.docInfo{
			border: 1px solid #66AFE9;
			border-radius: 10px;
			margin-top: 10px;
			padding: 10px;
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
					<ul class="nav navbar-nav">
						<li><a href="">联系电话：0451-87362836</a></li>
						<!-- 下面的代码需要登录后才能显示 -->
						<shiro:authenticated>
						<%
						 	Subject currentUser = SecurityUtils.getSubject();
							String userName = (String)currentUser.getSession().getAttribute(SessionConst.SESSION_USERNAME);
							SysMenu personalMenu = (SysMenu)currentUser.getSession().getAttribute(SessionConst.SESSION_PERSONAL_MENU);
						%>
							<li><a href="javascript:showMenu('<%=personalMenu.getMenuId()%>')">个人中心</a></li>
							<li><a href="#"><span class="glyphicon glyphicon-user"></span>欢迎您：<%=userName %></a></li>
                            <input name="userName"  type="hidden" value="<%=userName %>"></input>
						</shiro:authenticated>
					</ul>

					<!-- 导航尾，登录后不再显示 -->
					<shiro:notAuthenticated>
						<div class="nav navbar-right">
							<ul class="nav navbar-nav">
								<li><a href="<%=request.getContextPath() %>/login">登录</a></li>
								<li><a href="<%=request.getContextPath()%>/register/add">注册</a></li>
							</ul>
						</div>
					</shiro:notAuthenticated>
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
						          <li><a href="javascript:search_yuyue('科室')">科室</a></li>
						          <li><a href="javascript:search_yuyue('疾病')">疾病</a></li>
						        </ul>
					     </div><!-- /btn-group -->
					     <input type="text" class="form-control" placeholder="请输入搜索内容"  id="sel">
					     <div class="input-group-btn">
	        					<button type="button" class="btn btn-warning" onclick="tiaojian_search()"><span class="glyphicon glyphicon-search"></span></button>
					    </div>
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
			  	<li ><a href="<%=ctx%>/">首页</a></li>
			  	<li class="active"><a href="<%=ctx%>/appointment/listDept">按科室预约</a></li>
				<li ><a href="<%=ctx%>/appointment/listIllness">按疾病预约</a></li>
				<li ><a href="<%=ctx%>/baseinfo/listNewAnnoucement">最新公告</a></li>
			</ul>
		</div>
		<!--
        	作者：石洪刚 
        	时间：2017年8月20日21:51:22
        	描述：显示科室名称及科室内医生
        -->
        <form method="post" >
        	<input type="hidden" value="${pd.departmentId}" name="departmentId"/>
        	<input type="hidden" value="${pd.departmentName}" name="departmentName"/>
	        <!-- 当前搜索的疾病 -->
			<div class="container" style="margin-top: 20px;">
				<div class="panel panel-default">
					<div class="panel-heading">
						<h4>
							<c:if test="${pd.departmentName!=null}" >							
								<label>${pd.departmentName}</label>								
							</c:if>
							<label>${dept.dpName}</label>
							<span>
								<a href="<%=ctx%>/appointment/listDept">选择其他科室</a>							
							</span>
						</h4>
					</div>
				</div>
			</div>
		
        	<form method="post">
			<!-- 医生信息 -->
			
			<div class="container docInfo">
	        	<div class="col-sm-2">	
       				<img src="<%=ctx %>/appointment/down?location=${pp.ppPic}" width="130px" height="150px;"/>
	        	</div>
	        	<div class="col-sm-9">
	        		<h4 class="list-group-item-heading">${pp.ppName}<span style="color: #D58512;">${pp.professionalName}</span></h4>
						    <h4 class="list-group-item-text">${pp.departmentName}</h4>
						    <h4 class="list-group-item-text">医生简介：${pp.ppInfo}</h4>
						    <h4 class="list-group-item-text">擅长领域：${pp.doctorDomain}</h4>
						    <h4 class="list-group-item-text">
	        	</div>
	        </div>
	        <!--
        	作者：石洪刚
        	时间：2017年8月28日23:33:38
        	描述：预约  时间选择
        -->
        <div class="container">
        	<h4 class="text-warning">选择时间开始预约，预约期限9天</h4>
        </div>
        <div class="container">
        	<table class="table table-hover table-striped table-bordered">
        		<tr class="warning">
        			<th>日期/时间/剩余人数</th>
        			<c:forEach items="${list}" var="t" >
        			<th><fmt:formatDate value="${t.schedulingDate}" pattern="yyyy-MM-dd"/><br><fmt:formatDate value="${t.schedulingDate}" pattern="EE"/></th>
        			</c:forEach>
        		</tr>
        		<tr>
	        		<td>上午 08:00-09:00</td>
	        		<c:forEach items="${list}" var="t" >
	        		<td >
	        			<c:if test="${t.count1 > 0}"><a href="javascript:startApp('<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy-MM-dd"/>','<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy年MM月dd日"/>','${t.schedulingId}','1')">预约</c:if><span class="badge pull-right">${t.count1}</span></a>	
	        		</td>
	        		</c:forEach>
	        	</tr>
        		<tr>
	        		<td>上午 9:00-10:00</td>
	        		<c:forEach items="${list}" var="t" >
	        		<td >
	        			<c:if test="${t.count2 > 0}"><a href="javascript:startApp('<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy-MM-dd"/>','<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy年MM月dd日"/>','${t.schedulingId}','2')">预约</c:if><span class="badge pull-right">${t.count2}</span></a>	
	        		</td>
	        		</c:forEach>
	        	</tr>
        		<tr>
	        		<td>上午 10:00-11:00</td>
	        		<c:forEach items="${list}" var="t" >
	        		<td >
	        			<c:if test="${t.count3 > 0}"><a href="javascript:startApp('<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy-MM-dd"/>','<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy年MM月dd日"/>','${t.schedulingId}','3')">预约</c:if><span class="badge pull-right">${t.count3}</span></a>	
	        		</td>
	        		</c:forEach>
	        	</tr>
        		<tr>
	        		<td>下午 13:00-14:00</td>
	        		<c:forEach items="${list}" var="t" >
	        		<td >
	        			<c:if test="${t.count4 > 0}"><a href="javascript:startApp('<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy-MM-dd"/>','<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy年MM月dd日"/>','${t.schedulingId}','4')">预约</c:if><span class="badge pull-right">${t.count4}</span></a>	
	        		</td>
	        		</c:forEach>
	        	</tr>
        		<tr>
	        		<td>下午 14:00-15:00</td>
	        		<c:forEach items="${list}" var="t" >
	        		<td >
	        			<c:if test="${t.count5 > 0}"><a href="javascript:startApp('<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy-MM-dd"/>','<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy年MM月dd日"/>','${t.schedulingId}','5')">预约</c:if><span class="badge pull-right">${t.count5}</span></a>	
	        		</td>
	        		</c:forEach>
	        	</tr>
        		<tr>
	        		<td>下午 15:00-16:00</td>
	        		<c:forEach items="${list}" var="t" >
	        		<td >
	        			<c:if test="${t.count6 > 0}"><a href="javascript:startApp('<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy-MM-dd"/>','<fmt:formatDate value="${t.schedulingDate}" pattern="yyyy年MM月dd日"/>','${t.schedulingId}','6')">预约</c:if><span class="badge pull-right">${t.count6}</span></a>	
	        		</td>
	        		</c:forEach>
	        	</tr>
        	</table>
        </div>
        </form>
        <!-- 模态框 -->
        <div class="remodal" data-remodal-id="modal" role="dialog" aria-labelledby="modal1Title" aria-describedby="modal1Desc">
			<button data-remodal-action="close" class="remodal-close" aria-label="Close"></button>
		  	<div>
		    	<h2 id="modal1Title"></h2>
		    	<p id="modal1Desc">
		     
		    	</p>
		  	</div>
		  	<br>
		  	<button data-remodal-action="confirm" class="remodal-confirm" onclick="appSave()">提交</button>
			<button data-remodal-action="cancel" class="remodal-cancel">取消</button>
        </div>
	</body>
	<script type="text/javascript"> 
	     var sj;
	     var free;
	     var date;
	     var m;
	     var count;
	     var apId;
		function startApp(da,dd,adid,num){
              m = countToDate(num);
			  date = da+" "+sj+":00";
              free = ${pp.doctorPay + basefee}; 
              count = "count"+num;
              apId = adid;
              var ppName = "${pp.ppName}";
              var prname = "${pp.professionalName}";
			  //如果当前时间已超过预约的时间段
		      var cc= getDate(date);
		      var daa = new Date();
			  if (daa > cc) {
				bootbox.alert("当前时段已无法进行预约");
				return;
			}
			var inst = $('[data-remodal-id=modal]').remodal();
			$("#modal1Title").html("提示");
			$("#modal1Desc").html("您将于"+dd+" "+m+"找"+ppName+"("+prname+")就诊,挂号服务费"+free+"元");
			
			inst.open();
		}
		
		function appSave(){
			var userName = $("input[name='userName']").val();
			url= "<%=ctx%>/appt/apptadd";
			data = {
					"date":date,
					"ppId":'${pp.ppId}',
					"free":free,
					"userName":userName,
					"count":count,
					"apId":apId,
					"type":"dept"
			       };
			$.post(url,data,function(r){
				if (r.success) {
                    location.href="<%=ctx%>/personal/list?type=ap";
				} else {
                   bootbox.alert(r.msg);
				}
			},"json");
		}
		//搜索框
		function search_yuyue(tiaojian){
			$("#index_search_btn").html(tiaojian);
		}
		//搜索框条件查询
		function tiaojian_search(){
			var tiaojian = $("#index_search_btn").html();
			var sel = $("#sel").val();
			if (tiaojian.indexOf("科室")>-1) {
				location.href = "<%=request.getContextPath()%>/appointment/queryByillnessOrdoctor?departmentName="+sel;
			} else{
				location.href = "<%=request.getContextPath()%>/appointment/queryByillnessOrdoctor?illName="+sel;
			}
		}
		function countToDate(count){
			var count = parseInt(count);
			if (count == 1 ) {
				sj = "08:00";
				m = "上午"+sj+"-09:00";
			}if(count == 2 ) {
                sj = "09:00";
                m = "上午"+sj+"-10:00";
			}
			 if(count == 3 ) {
                sj = "10:00";
                m = "上午"+sj+"-11:00";
			}
			  if(count == 4 ) {
                sj = "13:00";
                m = "下午"+sj+"-14:00";
			}
			  if(count == 5 ) {
                sj = "14:00";
                m = "下午"+sj+"-15:00";
			}
			  if(count == 6 ) {
                sj = "15:00";
                m = "下午"+sj+"-16:00";
			}
			return m;
		}  
		function getDate(strDate){
			  var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,
			   function (a) { return parseInt(a, 10) - 1; }).match(/\d+/g) + ')');
			  return date;
			}
		//禁用游览器后退键
		$(function() {
			　　if (window.history && window.history.pushState) {
			　　$(window).on('popstate', function () {
			　　window.history.pushState('forward', null, '#');
			　　window.history.forward(1);
			　　});
			　　}
			　　window.history.pushState('forward', null, '#'); //在IE中必须得有这两行
			　　window.history.forward(1);
			　　})
	</script>
</html>