<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.yunzhong.appointment.config.SessionConst"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@include file="../../common/common.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<style type="text/css">
			.tree {
				min-height: 20px;
				padding: 19px;
				margin-bottom: 20px;
				background-color: #fbfbfb;
				border: 1px solid #999;
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
			
			.tree li::before,.tree li::after {
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
				padding: 3px 8px;
				text-decoration: none
			}
			
			.tree li.parent_li>span {
				cursor: pointer
			}
			
			.tree>ul>li::before,.tree>ul>li::after {
				border: 0
			}
			
			.tree li:last-child::before {
				height: 30px
			}
			
			.tree li.parent_li>span:hover,.tree li.parent_li>span:hover+ul li span {
				background: #eee;
				border: 1px solid #94a0b4;
				color: #000
			}
		</style>
	</head>
	<body style="background:linear-gradient(white,#ebebeb,white);">

		<div class="container ">
			<div class="form-group">
					<label class="control-label col-sm-2 col-md-2 ">角色名称:</label>
					<div class="col-md-4 col-sm-4">
							<input class="form-control" name="roleName"  value="${requestScope.role.roleName }" readonly="readonly"/>
					</div>
			</div>		
		<hr>
		<div class="tree well">
				<ul>
					<li>
						<span><i class="fa fa-minus-circle"></i> 功能菜单</span>
						<input type="checkbox" name="top" onchange="changeState(this)">
						<ul id="top">
						<c:forEach  items="${list }" var="m1">
							<li>
								<span><i class="fa fa-minus-circle"></i> ${m1.value } </span>
								<input type="checkbox" name="${m1.label }" value="${m1.label }" onchange="changeState(this,['top'])"  ${m1.selected==true?"checked":"" }>
								<ul id="${m1.label }">
								<c:forEach  items="${m1.selectList }" var="m2">
									<li>
										<span><i class="fa fa-minus-circle"></i>${m2.value }</span>
										<input type="checkbox" name="${m2.label }" value="${m2.label }" onchange="changeState(this,['top','${m1.label}'])"   ${m2.selected==true?"checked":"" }>
	                    				<ul id="${m2.label }">
                    					<c:forEach  items="${m2.selectList }" var="m3">
												<li>
												<span>${m3.value }</span>
												<input type="checkbox" name="ids" onchange="changeState(this,['top','${m1.label}','${m2.label}'])" value="${m3.label }"  ${m3.selected==true?"checked":"" }>
												</li>
										</c:forEach>
	                    				</ul>
	                    			</li>
								</c:forEach>
								</ul>
							</li>
						</c:forEach>
						</ul>
					</li>
				</ul>
			</div>	
			</div>
			<!-- 模态框 -->
			<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" 
			   aria-labelledby="myModalLabel" aria-hidden="true">
			   <div class="modal-dialog">
			      <div class="modal-content">
			         <div class="modal-header" style="background-color: rgba(0,0,0,0.1)">
			            <button type="button" class="close" data-dismiss="modal" 
			               aria-hidden="true">×
			            </button>
			            <h4 class="modal-title" id="myModalLabel2">
			              	保存操作
			            </h4>
			         </div>
			         <div class="modal-body text-center" id="modalBody2">
			           	确认保存?
			         </div>
			         <div class="modal-footer" id="modalFooter2">
			            <button type="button" class="btn btn-primary" onclick="tijiao()" data-dismiss="modal">确定</button>
			            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
			         </div>
			      </div>
			   </div>
			</div>
			<form class="form-horizontal text-center">
			
			<div class="col-lg-3 col-md-3 col-sm-2 col-xs-2">
						
			</div>
			<div class=" col-lg-6 col-md-6 col-sm-8 col-xs-8" >
				<div class="col-md-6 col-sm-6">
					<input class="form-control btn-primary" type="button" onclick="doSub()" value="提交" />
				</div>
				<div class="col-md-6 col-sm-6">
					<input class="form-control btn-primary" type="button" onclick="goBack()" value="返回" />
				</div>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-2 col-xs-2">
				
			</div>
			<hr>
			</form>
	</body>
	<script type="text/javascript">
		$(function(){
			var inpts = $("input:checkbox");
			for(var i=0;i<inpts.length;i++){
				if($(inpts[i]).prop("checked")){
					$("input[name='top']").prop("checked",true);
					break;
				}
			}
			
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
		
		
		//当选中或取消父级菜单后，改变子菜单状态
		function changeState(cb,parNames){
			var id = cb.getAttribute("name");
			var cbs = $("ul[id='"+id+"'] :checkbox").prop("checked",$(cb).prop("checked"));
			if(parNames!=null){
				if($(cb).prop("checked")){
					//当子菜单被选中后，所有父级菜单也被选中
					for(var i=0;i<parNames.length;i++){
						$("input[name='"+parNames[i]+"']").prop("checked",true);
					}
				}else{
					//当子级菜单都未被选中，取消父级菜单的选中状态
					for(var i=parNames.length-1;i>=0;i--){
						var ul = $("#"+parNames[i]);
						var lis = ul[0].children;
						var sF = false;
						for(var j=0;j<lis.length;j++){
							var children = lis[j].children;
							for(var t=0;t<children.length;t++){
								if(children[t].nodeName=="INPUT"){
									if($(children[t]).prop("checked")){
										sF = true;
									}
									break;
								}
							}
							if(sF){
								break;
							}
						}
						if(!sF){
							$("input[name='"+parNames[i]+"']").prop("checked",false);
						}
					}
				}
			}
		}
		
		function doSub(){
			$("#myModal2").modal('show');
		}
		
		function goBack(){
			window.history.go(-1);
		}
//提交保存		
		function tijiao(){
			var inpts = $("#top :checkbox");
			var ids = "";
			if(inpts.length>1){
				for(var i=0;i<inpts.length;i++){
					if($(inpts[i]).prop("checked")){
						ids+=inpts[i].value+",";
					}
				}
				ids = ids.substring(0, ids.length-1);
			}
			window.location.href = "<%=ctx%>/sys/roleMenu?menuIds="+ids+"&roleId=${requestScope.role.roleId}";
		}
	</script>
</html>
