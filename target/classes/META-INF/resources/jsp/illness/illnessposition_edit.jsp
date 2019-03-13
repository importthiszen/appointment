<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>云众科技网上预约挂号系统</title>
	<style type="text/css">
		   label.error {
			color: red;
			margin-left: 20px;
			width: auto;
			display: inline;
	      }
	</style>
</head>
<body style="background:linear-gradient(white,#ebebeb,white);">
	<div class="container">
			<hr>
			<form class="form-horizontal text-center" id="illtpinfoForm" name="infoForm" action="javascript:doSub()" method="post">
				<input type="hidden" name="illtpId" value="${illnesstp.illtpId}">
				<div class="container ">
					<div class="form-group">
						<label class="control-label col-sm-2 col-md-2">疾病类型:</label>
						<div class="col-md-9 col-sm-9">
							<input class="form-control" name="illtpName" value="${illnesstp.illtpName}" oninput="validatName(this.value)" onkeyup="this.value=this.value.replace(/\s+/g,'')" placeholder="请输入疾病名称" />
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
var bj=false;
function doSub(){
	if(bj){
		 return;	
		}
	 bootbox.confirm("确认提交吗?",function(r){
		 if(r){
			 $.ajax({
				type:"POST",
				url:"<%=request.getContextPath()%>/illnesstp/editsave.action",
				data:$("form[name='infoForm']").serialize(),
				dataType:"json",
				cache:false,
				async:true,
				success:function(r){
					if(r.success){
						location.href="<%=request.getContextPath()%>/illnesstp/listIllnesstp.action";
					}else{
						boot.alert("添加失败");
					}
				},
				arror:function(){
				  bootbox.alert("请求出现异常,请稍后再试!");	
				}
			 });
		 }
	 });
	}
//验证菜单名称是否重复
function validatName(){
	$("input[name='illtpName']+span").remove();
	var illtpName=$.trim( $("input[name='illtpName']").val() );
	if (illtpName == $.trim("${illnesstp.illtpName }")) {
		
		return ;
	}
	if(illtpName != ""){
		$.ajax({
			type:"POST",
			url:"<%=request.getContextPath()%>/illnesstp/illtpName.action",
			data:{"illtpName":illtpName},
			dataType:"json",
			cache: false,
			async: false, //同步验证
			success:function(r){	
				if(r.success){
					bj=true;
				   $("input[name='illtpName']").after("<span style='color:red;'>名称重复</span>")
				}else{
					bj=false;
				}
			},
			error:function(){
				bootbox.alert("请求出现异常,请稍后再试!");
			}
		});
	}	
}
    //表单验证
	$(function(){
		$("#illtpinfoForm").validate({
			rules:{
				illtpName:{	
	   			required : true
	   				
				}
			},
			messages:{
				illtpName:{
					required :"疾病类型不能为空"  				
				}
			},
			submitHandler:function(){
				doSub();
			}
		});
	});
function goBack(){
	location.href = "<%=request.getContextPath()%>/illnesstp/listIllnesstp.action";
}
</script>