<%@page import="com.yunzhong.appointment.config.SessionConst"%>
<%@page import="com.yunzhong.appointment.entity.SysMenu"%>
<%@page import="com.yunzhong.appointment.config.Const"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
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
		.ks-left{
			border: 1px solid #66AFE9;
			border-radius: 10px;
			margin-right: 0px;
		}
		.ks-right{
			border: 0px solid #66AFE9;
			border-radius: 10px;
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
			<shiro:guest>
				<div class="col-sm-6" style="margin-top: 15px;">
					<form method="post" name="form1" class="form form-horizontal">
						<div class="input-group">
					      	<div class="input-group-btn">
						       <button id="index_search_btn" type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">科室 <span class="caret"></span></button>
						        <ul class="dropdown-menu" role="menu">
						          <li><a href="javascript:search_yuyue('科室')">科室</a></li>
						          <li><a href="javascript:search_yuyue('疾病')">疾病</a></li>
						        </ul>
					      	</div><!-- /btn-group -->
					      	<input type="text" class="form-control" placeholder="请输入搜索内容"  id="sel">
					      	<div class="input-group-btn">
	        					<button type="button" class="btn btn-warning" onclick="tiaojian_search()"><span class="glyphicon glyphicon-search"></span></button>
					    	</div>
					      	</div><!-- /input-group -->
				    </form>
				</div>
			</shiro:guest>
			<shiro:hasRole name="patient">
				<div class="col-sm-6" style="margin-top: 15px;">
					<form method="post" name="form1" class="form form-horizontal">
						<div class="input-group">
					      	<div class="input-group-btn">
						        <button id="index_search_btn" type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">科室 <span class="caret"></span></button>
						        <ul class="dropdown-menu" role="menu">
						          <li><a href="javascript:search_yuyue('科室')">科室</a></li>
						          <li><a href="javascript:search_yuyue('疾病')">疾病</a></li>
						        </ul>
					      	</div><!-- /btn-group -->
					      	<input type="text" class="form-control" placeholder="请输入搜索内容" id="sel">
					      	<div class="input-group-btn">
	        					<button type="button" class="btn btn-warning" onclick="tiaojian_search()"><span class="glyphicon glyphicon-search"></span></button>
					    	</div>
					    </div>
				    </form>
				</div>
			</shiro:hasRole>
		</div>
		<!--
        	作者：石洪刚
        	时间：2017年8月10日17:04:47
        	描述：导航条   游客可见(在dashboard页) ：按科室挂号  按疾病挂号  最新公告
        -->
		<div class="container" style="margin-top: 10px;">
			<ul class="nav nav-pills guahao" role="tablist" style="background-color:lightcyan">
			  	<li ><a href="<%=request.getContextPath()%>/">首页</a></li>
			  	<li ><a href="<%=ctx%>/appointment/listDept">按科室预约</a></li>
				<li class="active"><a href="<%=request.getContextPath()%>/appointment/listIllness">按疾病预约</a></li>
				<li ><a href="<%=ctx%>/baseinfo/listNewAnnoucement">最新公告</a></li>
			</ul>
		</div>
		<!--
        	作者：石洪刚 
        	时间：2017年8月20日21:51:22
        	描述：显示热门疾病 及所有疾病
        -->
        <div class="container">
        	<div class="text-left">
        		<h4 class="btn btn-warning">热门疾病</h4>
        	</div>
        	<div class="piaoyikuang" style="padding: 5px;height: 100px;">
        	<div class="piaoyi"><a href="<%=ctx%>/appointment/queryByName?illName=癫痫">癫痫</a></div>	
        	<div class="piaoyi"><a href="<%=ctx%>/appointment/queryByName?illName=腹股沟疝">腹股沟疝</a></div>	
        	<div class="piaoyi"><a href="<%=ctx%>/appointment/queryByName?illName=儿童白血病">儿童白血病</a></div>	
        	</div>
        </div>
	<div class="container" style="margin-top: 10px;">
        <div class="container" style="margin-top: 10px;">
        	<!-- panel start -->
        	<div class="panel panel-default">
        	<c:forEach items="${IllnesspositionList}" var="illtp">
        		<div class="panel-heading">       		
        			<h6>${illtp.illtpName}</h6>		       			 
        		</div>
        		   <div class="panel-body">
    				<div>
    					<c:forEach items="${illnessList}" var="t">   
		    				<c:if test="${illtp.illtpId==t.illtpId}"> 
		    				<div class="piaoyi"><a href="<%=request.getContextPath()%>/appointment/listDoctor?illId=${t.illId}">${t.illName}</a></div>	
		    			   </c:if>   	
		        		</c:forEach>       	
		        	</div>
        		</div>       		
        		</c:forEach>
        	</div>
        	<!-- panel end -->
	</body>
	<script type="text/javascript">
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

	</script>
</html>