<%@page import="com.yunzhong.appointment.config.SessionConst"%>
<%@page import="com.yunzhong.appointment.entity.SysMenu"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.yunzhong.appointment.config.Const"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="../common/common.jsp" %>
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
							<li><a href="../personal/personal.html">个人中心</a></li>
							<li><a href="#"><span class="glyphicon glyphicon-user"></span>欢迎您：${sessionScope.userName}</a></li>
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
			  	<li><a href="#">首页</a></li>
			  	<li><a href="#">按科室挂号</a></li>
			  	<li><a href="#">按疾病挂号</a></li>
			  	<li class="active" ><a href="#">最新公告</a></li>
			</ul>
		</div>
		<!--
        	作者：石洪刚 
        	时间：2017年8月14日21:05:08
        	描述：显示对应菜单信息
        -->
        <div class="container">
        	<div class="text-left">
        		<h4 class="btn btn-warning">最新公告</h4>
        	</div>
        	<form action="/baseinfo/listNewAnnoucement" method="post">
	        	<ul class="list-group">
	        	<c:forEach items="${pageInfo.list }" var="t">
					<li class="list-group-item">
					<input type="hidden" name="noticeId" value="${t.noticeId }">
						<span class="badge"><fmt:formatDate value="${t.noticeTime }" pattern="yyyy-MM-dd"/></span>
						<a href="javascript:pageAnnouncement('${t.noticeId }')">${t.noticeTitle }</a> 
					</li>	   
				</c:forEach> 
	        	</ul>
	        	<div align="center">
					<yzpage:page pageName="pageInfo" url="/baseinfo/listNewAnnoucement"></yzpage:page>
				</div>
        	</form>
        </div>
	</body>
		<script type="text/javascript">
		//最新公告详情
		function pageAnnouncement(id){
			location.href="/baseinfo/pageAnnouncement?id="+id;
		}
		//搜索框
		function search_yuyue(tiaojian){
			$("#index_search_btn").html(tiaojian+" <span class=\"caret\"></span>");
		}
		//挂号导航
		$(".guahao a").bind("click",function(){
			if ("首页"==$(this).html()) {
				location.href = "<%=ctx%>/";
			} else if("按科室挂号"==$(this).html()){
				location.href = "<%=ctx%>/appointment/listDept";
			}else if("按疾病挂号"==$(this).html()){
				location.href = "<%=request.getContextPath()%>/appointment/listIllness";
			}else if("最新公告"==$(this).html()){
				location.href = "<%=ctx%>/baseinfo/listNewAnnoucement.action";
			}
		});
		//搜索框条件查询
		function tiaojian_search(){
			var tiaojian = $("#index_search_btn").html();
			if (tiaojian.indexOf("科室")>-1) {
				location.href = "../../yuyue_keshi.html";
			} else{
				location.href = "../../yuyue_jibing.html";
			}
		}
		//患者登录
		function huanzhe_login(){
			location.href = "../../index.html";
		}
		//注册新用户
		function huanzhe_zhuce(){
			location.href = "<%=request.getContextPath()%>/register/add";
		}
	</script>
</html>