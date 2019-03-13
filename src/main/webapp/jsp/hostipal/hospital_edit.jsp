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
			<div class="container">
			<form class="form-horizontal text-center" style="position:relative;"  name="infoForm" action="javascript:doSub()" method="post" enctype="multipart/form-data">
				<input type="hidden" name="hospitalId" value="${hospital.hospitalId}">
				<div class="container" >
					<div class="form-group" height="10px" ></div>
				<div class="form-group" >
						<label class="control-label col-sm-2 col-md-2">医院名称:</label>
						<div class="col-md-7 col-sm-7">
							<input class="form-control" name="hospitalName" required value="${hospital.hospitalName}" placeholder="请输入医院名称" />
						</div>	
					</div> 
					<div class="form-group">
						<textarea id="pic" name="hospitalPic" style="width: 700px;height:250px;"> </textarea>
						<br />
						<script type="text/javascript">
						</script>
					</div>
						<div class="form-group" >
						<div class="col-md-7 col-sm-7">
							<textarea id="hospitalInfo" name="hospitalInfo" style="width: 700px;height:150px;">${hospital.hospitalInfo}</textarea>
						</div>	
					</div> 
					<div class="form-group">					
						<div class="col-lg-4 col-md-4 col-sm-2 col-xs-2">					
						</div>
						<div class=" col-lg-4 col-md-4 col-sm-8 col-xs-8" >
							<div class="col-md-6 col-sm-6">
								<input class="form-control btn-primary" type="submit" id="sub" value="提交" />
							</div>
							<div class="col-md-6 col-sm-6">
								<input class="form-control btn-primary" type="button" onclick="goBack()" value="返回" />
							</div>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-2 col-xs-2">							
						</div>
					</div>
				</div>
			</form>
			<hr/>
		</div>
	</body>
	<script type="text/javascript">
	//提交
	function doSub(){
		$("input[name='hospitalName']+span").remove();
		var hospitalName = $.trim( $("input[name='hospitalName']").val()  );
		if(hospitalName == "" || hospitalName == null){
			$("input[name='hospitalName']").after("<span style='color:red;'>医院名称不能为空!</span>");
			return;
		}
		bootbox.confirm("你确定要保存吗?",function(r){
			if (r) {
				var url = "<%=request.getContextPath()%>/baseinfo/editsaveHospital";
				var data = $("form[name='infoForm']").serialize();
				//post请求     没有缓存     异步   没有error
				$.post(url, data, function(r) {
					if (r.success) {
						location.href="<%=request.getContextPath()%>/baseinfo/showHospitalInfo";
					} else {
						bootbox.alert("修改失败!");
					}
				}, "json")			
			}
		})
	}
	var ue = UE.getEditor('pic');
	ue.ready(function() {
	    //设置编辑器的内容
	   ue.setContent('${hospital.hospitalPic}');
	    //获取html内容，返回: <p>hello</p>
	   var html = ue.getContent();
	    //获取纯文本内容，返回: hello
	    var txt = ue.getContentTxt();
	});

	
	//返回
	function goBack(){
		history.go(-1);
	}
	</script>
</html>