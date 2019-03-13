<%@page import="com.github.pagehelper.PageInfo"%>
<%@page import="com.yunzhong.appointment.entity.SysRole"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<style type="text/css">
.tree {
	min-height: 20px;
	padding: 19px;
	margin-bottom: 20px;
	background-color: #fbfbfb;
	-webkit-border-radius: 4px;
	-moz-border-radius: 4px;
	border-radius: 4px;
	-webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
	-moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
	box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05)
}

.tree li {
	list-style-type: none;
	margin: 0;
	padding: 10px 5px 0 5px;
	position: relative
}

.tree li::before, .tree li::after {
	content: '';
	left: -20px;
	position: absolute;
	right: auto
}

.tree li::before {
	border-left: 1px solid #999;
	bottom: 50px;
	height: 100%;
	top: 0;
	width: 1px
}

.tree li::after {
	border-top: 1px solid #999;
	height: 20px;
	top: 25px;
	width: 25px
}

.tree li span {
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	border: 1px solid #999;
	border-radius: 5px;
	display: inline-block;
	padding: 4px 10px;
	text-decoration: none
}

.tree li.parent_li>span {
	cursor: pointer
}

.tree>ul>li::before, .tree>ul>li::after {
	border: 0
}

.tree li:last-child::before {
	height: 30px
}

.tree li.parent_li>span:hover, .tree li.parent_li>span:hover+ul li span
	{
	background: #eee;
	border: 1px solid #94a0b4;
	color: #000
}
</style>
</head>
<body
	style="background: linear-gradient(white, #ebebeb, white); visibility: hidden;">
	<div class="form-group">
		<label class="control-label col-sm-6col-md-6 ">部门维护:</label>
	</div>
	<div class="tree well">
		<ul>
			<li><span><i class="fa fa-minus-circle"></i> 部门列表</span>
				<button type="button"
					class="btn btn-primary glyphicon glyphicon-plus" title="增加"
					onclick="addDept('0')"></button>
				<ul>
					<c:forEach items="${topList }" var="m1">
						<li><span>${m1.value }</span>
							<button type="button"
								class="btn btn-primary glyphicon glyphicon-plus" title="增加"
								onclick="addDept('${m1.label}')"></button>
							<button type="button"
								class="btn btn-danger glyphicon glyphicon-minus" title="删除"
								onclick="deleteDept('${m1.label}','${m1.value}')"></button>
							<button type="button"
								class="btn btn-primary glyphicon glyphicon-edit" title="修改"
								onclick="updateDept('${m1.label}','${m1.value}')"></button>
							<ul>
								<c:forEach items="${m1.selectList }" var="m2">
									<li><span>${m2.value }</span> <c:if
											test="${m2.selectList=='[]'}">
											<button type="button"
												class="btn btn-danger glyphicon glyphicon-minus" title="删除"
												onclick="deleteDept('${m2.label}','${m2.value}')"></button>
										</c:if>
										<button type="button"
											class="btn btn-primary glyphicon glyphicon-edit" title="修改"
											onclick="updateDept('${m2.label}','${m2.value}')"></button>
									</li>
								</c:forEach>
							</ul></li>
					</c:forEach>
				</ul></li>
		</ul>
	</div>
	<!-- 模态框 增加或修改			-->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header"
					style="background-color: rgba(0, 0, 0, 0.1)">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h4 class="modal-title" id="myModalLabel"></h4>
				</div>
				<div class="modal-body text-center" id="modalBody">
					<div class="container">
						<form class="form-horizontal text-center" name="pageForm"
							action="<%=ctx%>/dept/save.action" method="post">
							<input type="hidden" name="deptId">
							<div class="container ">
								<div class="form-group">
									<label class="control-label col-sm-2 col-md-2">上级科室:</label>
									<div class="col-md-4 col-sm-4">
										<input class="form-control" name="parDeptName"
											readonly="readonly" /> <input class="form-control"
											name="deptPar" type="hidden" />
									</div>
								</div>
								<div class="form-group">
									<label class="control-label col-sm-2 col-md-2">科室名称:</label>
									<div class="col-md-4 col-sm-4">
										<input class="form-control" name="deptName"
											placeholder="请输入科室名称" onblur="validDeptName(this.value)" />
											<input class="form-control" name="deptNameOld"  type = "hidden" />
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="modal-footer" id="modalFooter">
					<button type="button" class="btn btn-primary" onclick="save()" id="saveBtn"
						data-dismiss="modal">保存</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
		//跳转莫态框增加页面	
		function addDept(deptId){
			$("input[name='deptName'] + span ").remove();
			$("input[name='deptId']").val("");
			$("input[name='deptName']").val("");
			if(deptId!="0"){
			$.post("<%=ctx%>/sys/addpage?id="+deptId,function(msg){ 
					$("input[name='parDeptName']").val(msg.dplName);
					$("input[name='deptPar']").val(msg.dplId);
					$("#myModalLabel").html("增加菜单");
					$("#myModal").modal('show');
 				},"json");
			}else{
				$("input[name='parDeptName']").val("部门列表");
				$("input[name='deptPar']").val("0");
				$("#myModalLabel").html("增加菜单");
				$("#myModal").modal('show');
			}
		} 
		//跳转莫态框至修改页面
		function updateDept(deptId,deptName){
			var url = "<%=ctx%>/sys/editpage";
			var data = {"id":deptId,"deptName":deptName};
			$.post(url,data,function(msg){	
				if(msg[0]!=null){
					$("input[name='parDeptName']").val(msg[1].dplName);
					$("input[name='deptPar']").val(msg[1].dplId);
					$("input[name='deptId']").val(msg[0].dpId);
					$("input[name='deptName']").val(msg[0].dpName);
					$("input[name='deptNameOld']").val(msg[0].dpName);
					$("#myModalLabel").html("修改部门");
					$("#myModal").modal('show');
				}else{
					$("input[name='parDeptName']").val("部门列表");
					$("input[name='deptPar']").val('0');
					$("input[name='deptId']").val(msg[1].dpId);
					$("input[name='deptName']").val(msg[1].dplName);
					$("input[name='deptNameOld']").val(msg[1].dplName);
					$("#myModalLabel").html("修改部门");
					$("#myModal").modal('show');
				}				
			},"json");
		}
	//对科室名进行重复验证
		var bj = false ;//假设能提交
		$("input[name='deptName'] + span ").remove();
		
		function validDeptName(deptName){
			$("input[name='deptName'] + span ").remove();
			if(trim(deptName)==""){
				$("input[name='deptName']").after("<span style='color:red'>科室名称不能为空!!!</span>");
				$("#saveBtn").attr("disabled",true);
				return;
			}
	 		var ymc=$("input[name='deptNameOld']").val();
			console.info("ymc:"+ymc);
			   	if(trim(deptName)==ymc){
				$("#saveBtn").attr("disabled",false);
				return;
			}	
    		if (deptName != "" ) {
    			var deptId=	$("input[name='deptPar']").val();
    			$.ajax({
    				type : "POST",
    				url : "<%=ctx%>/sys/validDeptName",
    				data : {"deptName":deptName,"deptId":deptId},
    				dataType : "json",
    				cache : false,
    				async : false,
    				success : function(r){
    						if (r.success) {
    							$("input[name='deptName']").after("<span style='color:red'>科室名称已重复请换一个</span>");
    							bj = true;
    							$("#saveBtn").attr("disabled",true);
    						}else{
    							bj = false;
    							$("#saveBtn").attr("disabled",false);
    						}
    				},
    				error : function(){
    					bootbox.alert("请求异常")
    				}
    			});
    		}
		}	

		//添加修改保存

		function save(){			

				bootbox.confirm("确认保存吗?",function(r){
					if(r){
						$.ajax({
							type : "POST",
							url : "<%=ctx%>/sys/saveDept",
							data :$("form[name='pageForm']").serialize() ,
							dataType : "json",
							cache : false,
							async : true,
							success : function(r){	
								if (r.success) {
									location.href="<%=ctx%>/sys/listDepartment";
									}else{
										bootbox.alert("添加失败,请重新操作");
									}
							},
							error : function(){
								bootbox.alert("请求异常,请稍后再试");
							}
						})	
					}
				});
		}
		
		$(function () {
		//如果有子菜单，隐藏其子菜单
		var lis = $('.tree li:has(ul)');
		for(var i=0;i<lis.length;i++){
			var parli = $(lis[i]);
			var children = parli.find('>ul>li');
			if(children.is(":visible")){
				$(lis[i]).find('>span').removeClass('glyphicon-minus').addClass('glyphicon-plus');
				children.hide('fast');
			}
			//如果有子菜单，在本身span上增加点击事件
			parli.find('>span').on('click',function(){
				var children = $(this).parent('li').find('>ul>li');
				if(children.is(":visible")){
					$(this).removeClass('glyphicon-minus').addClass('glyphicon-plus');
					children.hide('fast');
				}else{
					$(this).removeClass('glyphicon-plus').addClass('glyphicon-minus');
					children.show('fast');
				}
			});
			//如果有子菜单，改变鼠标样式
			parli.find('>span').on('mouseover',function(){
				$(this).css("cursor","pointer");
			});
		}
		});
		$("body").css("visibility","visible");
			
		//去空格	
		function trim(s){
		    return s.replace(/(^\s*)|(\s*$)/g, "");
		}				
		//删除数据
		function deleteDept(deptId,deptName){
			bootbox.confirm("确定要删除吗？",function(r){
				if(r){
					$.ajax({
						type : "POST",
						url : "<%=ctx%>/sys/deleteDept",
					data : {
						"id" : deptId,
						"deptName" : deptName
					},
					dataType : "json",
					cache : false,
					async : true,
					success : function(r) {
						if (r.success) {
							location.reload();
						} else {
							bootbox.dialog({
								title : "提示",
								message : r.msg,
								size : "large",
								buttons : {
									OK : {
										label : "OK",
										className : "btn-primary",
										callback : function() {
											location.reload();//刷新页面
										}
									}
								}
							});
						}
					},
					error : function() {
						bootbox.alert("请求异常,请稍后再试");
					}
				})
			}
		});
	}
</script>
</html>
