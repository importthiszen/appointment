<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>云众科技网上预约挂号系统</title>
		<style type="text/css">
				label.error {
					color: red;
					margin-left: 10px;
					width: auto;
					display: inline;
				}
		</style>
	</head>

	<body>
		<div class="container">
			<form class="form-horizontal text-center" style="position:relative;"  name="infoForm" action="javascript:doSub()" method="post" enctype="multipart/form-data" id="formpro">
				<input type="hidden" name="professionalId" value="${pro.professionalId}">
				<div class="container" >
					<div class="form-group" >
						<label class="control-label col-sm-2 col-md-2">职称名称:</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" name="professionalName"  value="${pro.professionalName}" placeholder="请输入职称名称" onblur="validProName(this.value)"/>
						</div>	
					</div>
					<div class="form-group">
					<label class="control-label col-sm-2 col-md-2">科室名称:</label>
						<div class="col-md-4 col-sm-4">
							<select name="dpId" class="form-control" onchange="gaibian()">
								<option value="">===请选择===</option>
								<c:forEach items="${deptList}" var="dept">
									<option value="${dept.dpId }" ${dept.dpId eq pro.dpId?"selected":"" }>${dept.dpName }</option>
								</c:forEach>
								</select>		
						</div>
					</div>
					<div class="form-group">
						<label class="control-label col-sm-2 col-md-2">出诊费用:</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" name="professionalFee"  value="${pro.professionalFee}" placeholder="请输入出诊费用" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-4 col-md-4 col-sm-2 col-xs-2">							
						</div>
						<div class=" col-lg-4 col-md-4 col-sm-8 col-xs-8" >
							<div class="col-md-6 col-sm-6">
								<input class="form-control btn-primary" type="submit" value="提交"  id="saveBtn"/>
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
	$(function(){
		$("#formpro").validate({
			rules: {
				professionalName: {
					required : true,	//必输项
				//	chinese:true
				},
				professionalFee:{
					required: true,
			//		digits:true,	//整数
					range:[1,200],	//值的范围
					minNumber:true    //输入必须是数字
				},
				dpId:{
					required: true
				}
			},
			//下面的messages可以修改提示文字.
			messages:{
				professionalName: {
					required: "职称名称不能为空!验证"
				},
				professionalFee:{
					required:"出诊费用不能为空"
				},
				dpId:{
					required:"科室不能为空"
				}
			},
		})
	});
	//名称重复验证
	var bj = false ;//假设能提交
	function validProName(professionalName){
		$("input[name='professionalName'] + span ").remove();	
		$("select[name='dpId'] + span ").remove();	
		var dpId = $("select[name='dpId']").val();
		if (trim(professionalName) == "${pro.professionalName}" &&dpId=="${pro.dpId}") {
			bj=false;
			return;
		}
		if (professionalName != "" ) {
			$.ajax({
				type : "POST",
				url : "<%=ctx%>/sys/validProName",
				data : {"professionalName":professionalName,"dpId":dpId},
				dataType : "json",
				cache : false,
				async : false,
				success : function(r){
						if (r.success) {
							$("input[name='professionalName']").after("<span style='color:red'>职称已重复请换一个</span>")
							bj = true;
						}else{
							bj = false;
						}
				},
				error : function(){
					bootbox.alert("请求异常")
				}
			});
		}
	}
	function gaibian(){
		var dpId = $("select[name='dpId']").val();
		var professionalName = $("input[name='professionalName']").val()
		validProName(professionalName);
	}
		//提交方法
		function doSub(){
			$("input[name='professionalName'] + span ").remove();	
			$("select[name='dpId'] + span ").remove();	
			if(bj){
				return;
			}	
			var name=$("input[name='professionalName']").val();
			if(trim(name)==""){
    			$("input[name='professionalName']").after("<span style='color:red'>角色名称不能为空!!!</span>");
    			return;
    		}
			bootbox.confirm("确定要提交吗?", function(result) {
				if(result){
					$("form[name='infoForm']").attr("action","<%=ctx%>/sys/saveOrUpdatePro");
					$("form[name='infoForm']").submit();
				}
			})
		}
		//去空格	
		function trim(s){
		    return s.replace(/(^\s*)|(\s*$)/g, "");
		}	
		function goBack(){
			history.go(-1);
		}
	</script>
</html>