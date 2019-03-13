<%@page import="com.yunzhong.appointment.entity.Person"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="utf-8" />
		<title></title>
	</head>
	<style type="text/css">
		label.error {
			color: red;
			margin-left: 10px;
			width: auto;
			display: inline;
		}
	</style>
	<body >
	
		<div class="container">
			<hr>
			<form class="form-horizontal text-center" id="infoForm" name="infoForm" action="javascript:tijiao()" method="post" enctype="multipart/form-data">
				<input type="hidden" name="ppId" value="${person.ppId }">
				<div class="container ">
					<div class="form-group">
						<div class="form-group col-md-7 col-sm-7">
							<div class="form-group ">
								<label class="control-label col-md-4 col-sm-4">用户名:</label>
								<div class="col-md-5 col-sm-5">
								 <input type="text" id="userName" name="userName" value="${person.userName }" placeholder="请输入用户名" class="form-control" oninput="disaBled()" readonly="readonly">
								 <input type="hidden" id="userId" name="userId"  value="${person.userId }">
								</div>
							</div>
							<div class="form-group ">
								<label class="control-label col-md-4 col-sm-4">人员名称:</label>
								<div class="col-md-5 col-sm-5">
									<input class="form-control" name="ppName"  value="${person.ppName }" placeholder="请输入人员名称" />
								</div>
							</div>
							<div class="form-group ">
								<label class="control-label col-md-4 col-sm-4">科室类别:</label>
								<div class="col-md-5 col-sm-5">
									<select name="dplId" class="form-control"    onchange="queryDepartment()">
										<option value="">===请选择===</option>
										<c:forEach items="${deptTypeList }" var="t" > 
											<option value="${t.dplId }" ${t.dplId == deptType.dplId ? "selected" :""}>${t.dplName }</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="form-group ">
								<label class="control-label col-md-4 col-sm-4">科室:</label>
								<div class="col-md-5 col-sm-5">
									<select name="departmentId" class="form-control" onchange="queryProByDeptId(this.value)"  >
										<option value="">===请选择===</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-4 col-sm-4">职位:</label>
								<div class="col-md-5 col-sm-5">
									<select name="professionalId" class="form-control"  onchange="queryProfessionalFeeById()" >
										<option value="">===请选择===</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-4 col-md-4">出诊费:</label>
								<div class="col-md-5 col-sm-5">
								<input class="form-control" name="doctorPay" value="" readonly="readonly" placeholder="请输入出诊费用" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-sm-4 col-md-4">人员状态:</label>
								<div class="col-md-5 col-sm-5">
									<input type="radio" name="ppState"  value="A"  ${person.ppState == 'A'?'checked':'' }>可用&nbsp;&nbsp;&nbsp;
									<input type="radio" name="ppState" value="N"  ${person.ppState == 'A'?'':'checked' } >不可用
								</div>
							</div>
						</div>
						<div class="col-md-4 col-sm-4">
							<div class="form-group ">
								<div class="col-md-5 col-sm-5">
								<img id="image" name="img" src="<%=ctx %>/personal/down?location=${person.ppPic }" width="240" height="240">
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-0.5 col-sm-0.5"></label>
								<div class="col-md-9 col-sm-9">
								<inuput type="hidden" name="pic2" value="${person.ppPic }">
								<input type="file" id="File" align="right" name="pic"  onchange="yuLan(this,'image','preview')" >
								</div>
							</div>
						</div>
						<label class="control-label text-left col-sm-1 col-md-1"></label>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2 col-md-2">人员简介:</label>
						<div class="col-md-9 col-sm-9">
							<textarea class="form-control" name="ppInfo" rows="3" placeholder="请输入人员简介" >${person.ppInfo }</textarea>
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2 col-md-2">擅长领域:</label>
						<div class="col-md-9 col-sm-9">
							<textarea class="form-control" name="doctorDomain" id="doctorDomain" rows="3" placeholder="请输入擅长领域" >${person.doctorDomain }</textarea>
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-3 col-md-3 col-sm-2 col-xs-2">
							
						</div>
						<div class=" col-lg-6 col-md-6 col-sm-8 col-xs-8" >
							<div class="col-md-6 col-sm-6">
								<input class="form-control btn-primary" type="submit" value="提交" />
							</div>
							<div class="col-md-6 col-sm-6">
								<input class="form-control btn-primary" type="button" onclick="goBack()" value="返回" />
							</div>
						</div>
						<div class="col-lg-3 col-md-3 col-sm-2 col-xs-2">
							
						</div>
					</div>
				</div>
			</form>
				<hr/>
		</div>
		
	</body>
</html>
<script type="text/javascript">
	$(function(){
		$("#infoForm").validate({
			rules: {
				ppName: {
					required : true,	//必输项
					//chaneseorenglish:true,
					minlength: 2,
					maxlength: 8		//最大长度
				},
				userId:{
					required  :true
				},
				ppInfo:{
					required  :true
				},
				userName:{
					required  :true
				}
			},
			//下面的messages可以修改提示文字.
			messages:{
				ppName: {
					required: "人员名称不能为空!"
				},
				userId:{
					required  :"请选择用户"
				},
				ppInfo:{
					required: "请输入简介!"
				},
				userName:{
					required   :"请选择用户"
				}
			},
			submitHandler: function() {
				//alert("submitted!");
				tijiao();
			},
			//dubug:true
		});
		disaBled();
		queryDepartment();
		var departmentId = "${person.departmentId}";
		queryProByDeptId(departmentId);
		queryProfessionalFeeById();
	})
	//判断用户角色禁用和解禁
	function disaBled(){
		var userId = $("#userId").val();
		if ( null !=  userId && userId != '') {
			$.ajax({
				type : "POST",
				url : "<%=request.getContextPath()%>/sys/queryUserRoles.action",
				data : {"userId":userId},
				dataType : "json",
				cache : false,
				async : false,
				success : function(r) {
					if (r) {
						$("#doctorDomain").prop("readonly",false);
						queryProfessionalFeeById();
					} else {
			 			$("textarea[name='doctorDomain']").val("");
			 			$("#doctorDomain").prop("readonly",true);
			 			$("input[name='doctorPay']").val("");
					}
				},
				error : function() {
					bootbox.alert("请求异常")
				}
			})
		}
	}
	//提交验证
	function tijiao(){
		$("input[name='pic']+span").remove();
		$.ajax({
			type : "POST",
			url : "<%=request.getContextPath()%>/sys/queryImgInfo.action",
			data : {"location":"${person.ppPic }"},
			dataType : "json",
			cache : false,
			async : false,
			success : function(r) {
				if (r) {
					var filepath = $("input[name='pic']").val();
					if (filepath == null || filepath == "") {
						doSub();
					}else{
				    	var filepath = $("input[name='pic']").val();
				    	//获得上传文件名
				    	var fileArr = filepath.split("\\");
				    	var fileTArr = fileArr[fileArr.length - 1].toLowerCase().split(".");
				    	var filetype = fileTArr[fileTArr.length - 1];
				    	//切割出后缀文件名
				    	if (filetype == "img" || filetype === "bmp" || filetype == "jpg" || filetype == "tiff" || filetype == "gif"||filetype =="svg" ||filetype =="psd"||filetype =="png")
				    	{  
				    		$("input[name='pic']+span").remove();
				    		doSub();
				    	}else{
				    		$("input[name='pic']").after("<span style='color:red;'>请选择一张图片!<span>");
				    		return;
				    	}
					}
				}else{
			    	var filepath = $("input[name='pic']").val();
			    	//获得上传文件名
			    	var fileArr = filepath.split("\\");
			    	var fileTArr = fileArr[fileArr.length - 1].toLowerCase().split(".");
			    	var filetype = fileTArr[fileTArr.length - 1];
			    	//切割出后缀文件名
			    	if (filetype == "img" || filetype === "bmp" || filetype == "jpg" || filetype == "tiff" || filetype == "gif"||filetype =="svg" ||filetype =="psd"||filetype =="png")
			    	{  
			    		$("input[name='pic']+span").remove();
			    		doSub();
			    	}else{
			    		$("input[name='pic']").after("<span style='color:red;'>请选择一张图片!<span>");
			    		return;
			    	}
				}
			},
			error : function() {
				bootbox.alert("请求异常")
			}
		})
	}
	//提交
	function doSub(){
		bootbox.confirm("你确定要" + "提交" + "吗?", function(r) {
			var formData = new FormData($("form")[0]);
			if (r) {
				$.ajax({
					type : "POST",
					url : "<%=request.getContextPath()%>/sys/editPerson.action",
					data :  formData,
					dataType : "json",
					cache : false,
					async : true,
			        processData: false, 
			        contentType: false,
					success : function(r) {
						if (r.success) {
							location.href="<%=ctx%>/sys/listPerson.action?pageNum=1";
						} else {
							bootbox.dialog({  
								title: "提示",  
								message: r.msg,  
								buttons: { 
									OK: {  
										label: "确定",  
										className: "btn-primary",  
										callback: function () {  
											//确定
										}  
									}  
								}  
							});
						}
					},
					error : function() {
						bootbox.alert("请求异常")
					}
				})
			}
		})
	}
	var bj2 = false;
	//根据科室类别查询科室
	function queryDepartment(){
		var dplId = $("select[name='dplId'] option:selected").val();
		$("select[name='departmentId']").empty();
		$("select[name='professionalId']").empty();
		$("input[name='doctorPay']").val("");
		$("select[name='professionalId']").append("<option value='' selected>===请选择===</option>");
		$("select[name='departmentId']").append("<option value='' selected>===请选择===</option>");
		if (dplId != "") {
			$.ajax({
				type : "POST",
				url : "<%=request.getContextPath()%>/appointment/queryDeptBydplId.action",
				data : {"dplId":dplId},
				dataType : "json",
				cache : false,
				async : false,
				success : function(r) {
					if (r != null) {
						for (var i = 0; i < r.length; i++) {
							var selectEd ="";
							if(r[i].dpId == "${person.departmentId}" && !bj2){
								bj2 = true;
								selectEd = "selected";
							}
							$("select[name='departmentId']").append("<option value="+r[i].dpId+"  "+selectEd+" >"+r[i].dpName+"</option>");
						}
					}

				},
				error : function() {
					bootbox.alert("请求异常")
				}
			})
		}
	}
	var bj = false;
	//根据科室查询职务
	function queryProByDeptId(departmentId){
		$("select[name='professionalId']").empty();
		$("input[name='doctorPay']").val("");
		$("select[name='professionalId']").append("<option value='' selected>===请选择===</option>");
		if (departmentId != "") {
			$.ajax({
				type : "POST",
				url : "<%=request.getContextPath()%>/appointment/queryProByDeptId.action",
				data : {"departmentId":departmentId},
				dataType : "json",
				cache : false,
				async : false,
				success : function(r) {
					if (r != null) {
						for (var i = 0; i < r.length; i++) {
							var selectEd ="";
							if(r[i].professionalId == "${person.professionalId}" && !bj){
								bj = true;
								selectEd = "selected";
							}
							$("select[name='professionalId']").append("<option value="+r[i].professionalId+"  "+selectEd+" >"+r[i].professionalName+"</option>");
						}
					}

				},
				error : function() {
					bootbox.alert("请求异常")
				}
			})
		}
	}
	//根据职务查询出诊费用
	function queryProfessionalFeeById(){
		var professionalId = $("select[name='professionalId'] option:selected").val();
		$("input[name='doctorPay']").val("");
		if (professionalId != "") {
			$.ajax({
				type : "POST",
				url : "<%=request.getContextPath()%>/appointment/queryProfessionalFeeById.action",
				data : {"professionalId":professionalId},
				dataType : "json",
				cache : false,
				async : false,
				success : function(r) {
					if (r != null) {
						$("input[name='doctorPay']").val(r);
						var userId = $("#userId").val();
						if ( null !=  userId && userId != '') {
							$.ajax({
								type : "POST",
								url : "<%=request.getContextPath()%>/sys/queryUserRoles.action",
								data : {"userId":userId},
								dataType : "json",
								cache : false,
								async : false,
								success : function(r) {
									if (r) {
										
									} else {
										$("input[name='doctorPay']").val("");
									}
								},
								error : function() {
									bootbox.alert("请求异常")
								}
							})
						}
					}
				},
				error : function() {
					bootbox.alert("请求异常")
				}
			})
		}
	}
	//返回	
	function goBack(){
		history.go(-1)
	}
	//关闭模态
	function clooseDiaLog(){
		diaLog.modal("hide");
	}
</script>