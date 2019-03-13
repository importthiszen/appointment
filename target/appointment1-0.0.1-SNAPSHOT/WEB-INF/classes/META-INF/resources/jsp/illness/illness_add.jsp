<%@include file="../common/common.jsp" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
			<form class="form-horizontal text-center" id="illinfoForm" name="infoForm" action="javascript:doSub()" method="post">
				<input type="hidden" name="illId" value="${illness.illId}">
				<div class="container ">
				<div class="form-group">
					<label class="control-label col-sm-3 col-md-2">疾病类型:</label>
					<div class="col-md-6 col-sm-6">
						<select name="illtpId" class="form-control" onchange="gaibian()">
							<option value="">===请选择===</option>
							<c:forEach items="${illtpList}" var="illtp">
								<option value="${illtp.illtpId}">${illtp.illtpName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-md-2">疾病:</label>
					<div class="col-md-6 col-sm-6">
						<input class="form-control" name="illName" value="" onkeyup="this.value=this.value.replace(/\s+/g,'')" oninput="validatName(this.value)" placeholder="请输入疾病名称" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-md-2">疾病简介:</label>
					<div class="col-md-6 col-sm-6">
						<textarea class="form-control" name="illInfo" rows="3" placeholder="请输入疾病简介" ></textarea>
					</div>
				</div>
				<div class="form-group">
					<div class="col-lg-4 col-md-4 col-sm-2 col-xs-2"></div>
					<div class=" col-lg-4 col-md-4 col-sm-8 col-xs-8" >
						<div class="col-md-6 col-sm-6">
							<input class="form-control btn-primary" type="submit" value="提交" />
						</div>
						<div class="col-md-6 col-sm-6">
							<input class="form-control btn-primary" type="button" onclick="goBack()" value="返回" />
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
				url:"<%=request.getContextPath()%>/illness/addsave.action",
				data:$("form[name='infoForm']").serialize(),
				dataType:"json",
				cache:false,
				async:true,
				success:function(r){
					if(r.success){
						location.href="<%=request.getContextPath()%>/illness/listIllness.action";
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
	//提交方法
<%--function doSub(){
			bootbox.confirm("确定要提交吗?", function(r) {
				if(r){
					$("form[name='infoForm']").attr("action","<%=request.getContextPath()%>/illness/saveOrUpdateIllness");
					$("form[name='infoForm']").submit();
			}
	 })
} --%> 
//验证菜单名称是否重复
function validatName(v){
	var illtpId = $("select[name='illtpId']").val()
	$("input[name='illName']+span").remove();
	var illName=$.trim( $("input[name='illName']").val() );
	if(illName != ""){
		$.ajax({
			type:"POST",
			url:"<%=request.getContextPath()%>/illness/illName.action",
			data:{"illName":illName,"illtpId":illtpId},
			dataType:"json",
			cache: false,
			async: false, //同步验证
			success:function(r){	
				if(r.success){
					bj=true;
				   $("input[name='illName']").after("<span style='color:red;'>名称重复</span>")
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
function gaibian(){
	var v = $("input[name='illName']").val()
	validatName(v)
}
    //表单验证
	$(function(){
		$("#illinfoForm").validate({
			rules:{
				illName:{	
	   			required : true
	   				
				},
				illtpId:{	
		   			required : true
		   				
					}
			},
			messages:{
				illName:{
					required :"疾病不能为空"  				
				},
				illtpId:{
					required :"疾病类型不能为空"  				
				}
			},
			submitHandler:function(){
				doSub();
			}
		});
	});
function goBack(){
	location.href = "<%=request.getContextPath()%>/illness/listIllness.action";
}
</script>