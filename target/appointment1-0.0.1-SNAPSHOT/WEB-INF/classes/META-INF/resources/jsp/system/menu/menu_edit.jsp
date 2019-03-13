<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>云众科技网上预约挂号系统</title>
	</head>
	<body>
		<div align="center" style="margin-top: 10px;">
			<form id="sys_tree_editForm" name="sys_tree_editForm" method="post" class="form form-horizontal" action="javascript:doSub()">
			<input type="hidden" name="menuId" value="${menu.menuId }">
	<!-- 			<table> -->
	<!-- 				<tr> -->
	<!-- 					<td align="right">菜单名称：</td> -->
	<%-- 					<td style="width: 600px;"><input name="menuName" value="${menu.menuName }" class="easyui-validatebox" data-options="required:true"></td> --%>
	<!-- 				</tr> -->
	<!-- 				<tr> -->
	<!-- 					<td align="right">菜单顺序号：</td> -->
	<%-- 					<td><input name="menuSequ" value="${menu.menuSequ }"></td> --%>
	<!-- 				</tr> -->
	<!-- 				<tr> -->
	<!-- 					<td align="right">菜单URL：</td> -->
	<%-- 					<td><input name="menuUrl" value="${menu.menuUrl }" style="width: 600px;"></td> --%>
	<!-- 				</tr> -->
	<!-- 			</table> -->
				<div class="form-group">
					<label class="control-label col-sm-2 col-md-2">菜单名称：</label>
					<div class="col-md-9 col-sm-9">
						<input class="form-control" name="menuName" value="${menu.menuName }" onblur="validateName()" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2 col-md-2">菜单顺序号：</label>
					<div class="col-md-9 col-sm-9">
						<input class="form-control" name="menuSequ" value="${menu.menuSequ }" type="number" min="0" step="1" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2 col-md-2">菜单URL：</label>
					<div class="col-md-9 col-sm-9">
						<input class="form-control" name="menuUrl" value="${menu.menuUrl }" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-4 col-md-4"></label>
					<div class="col-md-3 col-sm-3">						
					    <button class="btn btn-success btn-mini"   id="dosub" type="submit"  style="width:60;height:33;"  >保存</button>&nbsp;&nbsp;&nbsp;
             		    <button class="btn btn-warning btn-mini" onclick="closelog()"   type="button" style="width:60;height:33;"  >关闭</button>
					</div>
				</div>
			</form>
		</div>
	</body>
	<script type="text/javascript">
		var bj2 = false;
		function validateName(){
			bj2 = false;
			$("#span1").remove();
			var menuName = $("input[name='menuName']").val();
			if($.trim(menuName) == $.trim("${menu.menuName }")){
				return;
			}
			if ($.trim(menuName) != "") {
				$.ajax({
					type : "POST",
					url : "<%=request.getContextPath()%>/sys/validateMenuName.action",
					data : {"menuId":"${menu.menuId }","menuName":menuName},
					dataType : "json",
					cache : false,
					async : false,
					success : function(r) {
						if (r) {
							$("input[name='menuName']").after("<span id='span1' style='color:red;'>菜单名重复!</sapn>");
							bj2=true;
						} else {
							bj2=false;
						}
					},
					error : function() {
						bootbox.alert("请求异常")
					}
				})
			}
		}
		//修改保存
		function doSub(){
			$("#span2").remove();
			if (bj2) {
				return;
			}
			var bj = false;
			//判断菜单名是否为空
			var menuName = $("input[name='menuName']").val();
			if ($.trim(menuName)==null || $.trim(menuName)=="") {
				$("input[name='menuName']").after("<span id='span2' style='color:red;'>菜单名不能为空!</sapn>");
				bj = true;
			} else {
				bj = false;
			}
			if (bj) {
				return ;
			}
			var url = "<%=request.getContextPath()%>/sys/editMenu.action";
			var data = $("form[name='sys_tree_editForm']").serialize();
			//post请求     没有缓存     异步   没有error
			$.post(url, data, function(r) {
				if (r) {
					parent.closeEditDiaLog();
				} else {
					bootbox.alert("修改失败");
				}
			}, "json")
		}
		//关闭
		function closelog(){
			parent.closeEditDiaLog();
		}
	</script>
</html>