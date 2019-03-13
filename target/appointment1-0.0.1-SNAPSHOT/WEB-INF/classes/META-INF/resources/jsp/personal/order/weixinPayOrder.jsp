<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../../common/common.jsp" %>
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../../static/css/bootstrap.min.css"/>
		<script type="text/javascript" src="../../../static/js/jquery-2.2.4.min.js"></script>
		<script type="text/javascript" src="../../../static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="../../../static/js/bootstrap.min.js" ></script>
		<script src="../../../static/js/qrcode.js"></script>
		<meta charset="UTF-8">
		<title></title>
	</head>
	<body>
		<div class="container">
			<div class="col-sm-6">
				<div style="width: 400px;height: 400px;border: 10px solid gray;">
					<div style="background-color:#002A80;color: white;font-size: 20px;height: 36px;vertical-align: middle;">支付：28元</div>
					<div style="font-size: 22px;text-align: center;margin-top: 10px;">
						微信扫码支付
					</div>
					<div style="text-align: center;">
						<div align="center" id="qrcode"></div>
					</div>
					<hr />
				</div>
			</div>
			<div class="col-sm-6">
				<img src="../../../static/img/2.png"/>
			</div>
		</div>
	</body>
	<script type="text/javascript">
	    //这个地址是Demo.java生成的code_url,这个很关键
	    var url = "${codeUrl}";
	    //参数1表示图像大小，取值范围1-10；参数2表示质量，取值范围'L','M','Q','H'
	    var qr = qrcode(10, 'M');
	    qr.addData(url);
	    qr.make();
	    var dom=document.createElement('DIV');
	    dom.innerHTML = qr.createImgTag();
	    var element=document.getElementById("qrcode");
	    element.appendChild(dom);
	
	    //定时器，查询订单支付状态，订单状态改变，清除页面定时器，页面跳转  
	    //$(document).ready() 方法含义
	    // 当 DOM（文档对象模型） 已经加载，并且页面（包括图像）已经完全呈现时，会发生 ready 事件。
	    $(document).ready(function () {
	        setInterval("checkOut()", 3000);
	    });
		function  checkOut() {
	        var id='${id}';
	        var url ="/personal/getPayedOrderById";
	        var data={"id":id};
	        $.post(url,data,function (result) {
	        	console.info(result);
	            if(result==1){
	            	location.href="<%=request.getContextPath()%>/personal/listOrder";
	            }
	        },"json");
    	}
	</script>
</html>
