<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>云众科技网上预约挂号系统</title>
	</head>

	<body>
		<div class="container">
			<form class="form-horizontal text-center" style="position:relative;"  name="infoForm" action="javascript:doSub()" method="post" enctype="multipart/form-data" id='checkpage'>
				<input type="hidden" name="roleId" value="${role.roleId}">
				<div class="container" >
					<div class="form-group" >
						<label class="control-label col-sm-2 col-md-2">角色名称:</label>
						<div class="col-md-4 col-sm-4">
							<input class="form-control" name="roleName" value="${role.roleName}" placeholder="请输入角色名称" onblur="validRoleName(this.value)"/>
						</div>	
					</div>
					<c:if test="${role!=null}">
						<div class="form-group">
							<label class="control-label col-sm-2 col-md-2">角色状态:</label>
							<div class="col-md-6 col-sm-6">
								<div class="col-md-5 col-sm-5">
									<input type="radio"  ${role.roleState=="A"?"checked":"" } class="col-md-1 col-sm-1"  name="roleState"  value="A" /><span class="col-md-8 col-sm-8">可用</span>&nbsp;&nbsp;
								</div>
								<div class="col-md-5 col-sm-5">
									<input type="radio" ${role.roleState=="N"?"checked":"" } class="col-md-1 col-sm-1"  name="roleState"  value="N" /><span class="col-md-8 col-sm-8">不可用</span>
								</div>	
							</div>
						</div>
					</c:if>
					<div class="form-group">
						<label class="control-label col-sm-2 col-md-2">角色信息:</label>
						<div class="col-md-6 col-sm-6">
							<textarea class="form-control" name="roleInfo" rows="3" placeholder="请输用户信息" >${role.roleInfo }</textarea>
						</div>
					</div>
					<div class="form-group">
						<div class="col-lg-4 col-md-4 col-sm-2 col-xs-2">
							
						</div>
						<div class=" col-lg-4 col-md-4 col-sm-8 col-xs-8" >
							<div class="col-md-6 col-sm-6">
								<input class="form-control btn-primary" type="submit" value="提交" />
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
		var bj = false ;//假设能提交
		//对角色名进行验证
		function validRoleName(roleName){
    		$("input[name='roleName'] + span ").remove();
    		var ymc="${role.roleName}";
    		if(trim(roleName)==ymc){
    			bj=false;
    			return;
    		}	
    		if (roleName != "" ) {
    			$.ajax({
    				type : "POST",
    				url : "<%=ctx%>/sys/checkRoleName",
    				data : {"roleName":roleName},
    				dataType : "json",
    				cache : false,
    				async : false,
    				success : function(r){
    						if (r.success) {
    							$("input[name='roleName']").after("<span style='color:red'>角色名称已重复请换一个</span>")
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
		//提交方法
		function doSub(){
			if(bj){
				return;
			}	
		var name=$("input[name='roleName']").val();
			if(trim(name)==""){
    			$("input[name='roleName']").after("<span style='color:red'>角色名称不能为空!!!</span>");
    			return;
    		}	
			bootbox.confirm("确定要提交吗?", function(result) {
				if(result){
					$("form[name='infoForm']").attr("action","<%=request.getContextPath()%>/sys/saveOrUpdateRole");
					$("form[name='infoForm']").submit();
				}
			})
		}
		function goBack(){
			history.go(-1);
		}
		function trim(s){
		    return s.replace(/(^\s*)|(\s*$)/g, "");
		}
	</script>
</html>