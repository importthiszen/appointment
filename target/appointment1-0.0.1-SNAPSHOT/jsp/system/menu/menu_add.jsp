<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center" style="padding: 5px;">
		<form id="sys_tree_addForm" name="sys_tree_addForm" method="post" action="javascript:doSub()">
			<input value="${sysMenuId }" type="hidden" name="sysMenuId"></input>
				<div class="form-group">
					<label class="control-label col-sm-2 col-md-2">菜单名称：</label>
					<div class="col-md-9 col-sm-9">
						<input class="form-control" name="menuName" onblur="validateName()" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2 col-md-2">菜单顺序号：</label>
					<div class="col-md-9 col-sm-9">
						<input type="number" class="form-control" name="menuSequ"  min="0" step="1" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-2 col-md-2">菜单URL：</label>
					<div class="col-md-9 col-sm-9">
						<input class="form-control" name="menuUrl"  />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-4 col-md-4"></label>
					<div class="col-md-3 col-sm-3">
						<button class="btn btn-success btn-mini"  id="button"  type="submit" style="width:60;height:33;">保存</button>&nbsp;&nbsp;&nbsp;
             		    <button class="btn btn-warning btn-mini" onclick="closeAddDiaLog()"  type="button" style="width:60;height:33;" >关闭</button>
					</div>
				</div>
		</form>
	</div>
</body>
<script type="text/javascript">
	//验证名称是否重复
	function validateName(){
		$("#button").prop("disabled",false);
		$("#span1").remove();
		var menuName = $("input[name='menuName']").val();
		if ($.trim(menuName) != "") {
			$.ajax({
				type : "POST",
				url : "<%=request.getContextPath()%>/sys/validateMenuName.action",
				data : {"sysMenuId":"${sysMenuId }","menuName":menuName},
				dataType : "json",
				cache : false,
				async : false,
				success : function(r) {
					if (r) {
						$("#button").prop("disabled",true);
						$("input[name='menuName']").after("<span id='span1' style='color:red;'>菜单名重复!</sapn>");
					} else {
						$("#button").prop("disabled",false);
					}
				},
				error : function() {
					bootbox.alert("请求异常")
				}
			})
		}
	}
	//添加保存
	function doSub(){
		$("#span2").remove();
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
			return;
		}
		
		var url = "<%=request.getContextPath()%>/sys/addMenu.action";
		var data = $("form[name='sys_tree_addForm']").serialize();
		//post请求     没有缓存     异步   没有error
		$.post(url, data, function(r) {
			if (r) {
				parent.closeAddDiaLog();
			} else {
				bootbox.alert("添加失败");
			}
		}, "json")
	}
	//关闭
	function closeAddDiaLog(){
		parent.closeAddDiaLog();
	}
</script>
</html>