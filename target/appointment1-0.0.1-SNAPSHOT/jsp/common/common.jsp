<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://www.yunzhong.com/tag/page" prefix="yzpage" %>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<%-- 基本bootstrap --%> 
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/static/css/bootstrap.min.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-2.2.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery.tips.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap.min.js" ></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/static/js/remodal/remodal.css"/>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/static/js/remodal/remodal-default-theme.css"/>
		<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/remodal/remodal.min.js" ></script>
<%-- 日历 --%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/static/css/bootstrap-datetimepicker.min.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap-datetimepicker.min.js" ></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/bootstrap-datetimepicker.zh-CN.js" ></script>
<%-- 预览 --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/static/js/preview/preview.js" ></script>
<%--bootbox --%>
<script src="<%=request.getContextPath() %>/static/js/bootbox.js"></script>
<%--jedate --%>
<script src="<%=request.getContextPath() %>/static/js/jedate/jquery.jedate.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/static/js/jedate/skin/jedate.css"/>
<%--qrcode --%>
<script src="<%=request.getContextPath() %>/static/js/qrcode.js"></script>
 <%--vilidate --%>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/static/js/bootstrap-3.3.5-dist/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/static/js/bootstrap-3.3.5-dist/css/bootstrap-theme.min.css"/>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-validate/jquery.validate.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-validate/additional-methods-yuzhanfeng.js?v=1"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-validate/localization/messages_zh.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath() %>/static/js/jquery-validate/additional-methods-zhaogang.js?v=1"></script>
</head>
<%--富文本编辑器 --%>
<!-- 配置文件 -->
<script type="text/javascript" src="<%=request.getContextPath() %>/static/ueditor/ueditor.config.js"></script>
<!-- 编辑器源码文件 -->
<script type="text/javascript" src="<%=request.getContextPath() %>/static/ueditor/ueditor.all.js"></script>

<%
	String ctx = request.getContextPath();
%>
<script type="text/javascript">
	function showMenu(menuId){
		location.href = "<%=request.getContextPath()%>/sys/showMenu?id="+menuId;
	}
</script>