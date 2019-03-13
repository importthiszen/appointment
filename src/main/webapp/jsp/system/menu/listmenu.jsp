<%@page import="com.github.pagehelper.PageInfo"%>
<%@page import="com.yunzhong.appointment.entity.SysUser"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../../common/common.jsp" %>
<%@include file="/jsp/common/easyui.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>云众科技网上预约挂号系统</title>
	</head>

	<body>
	<table class="menutreestyle" width="100%">
			<tr>
				<td>
				
				</td>
				<td style="vertical-align: top;">
					<a id="menutree_add" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addPage()">添加新菜单</a>
					&nbsp;&nbsp;
					<a id="menutree_edit" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'" onclick="editPage()">修改菜单</a>
					&nbsp;&nbsp;
					<a id="menutree_delete" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="del()">删除菜单</a>
				</td>
			</tr>
			<tr>
				<td >
					<ul id="easyui-tree"></ul>
				</td>
			</tr>
		</table>
	</body>
	<script type="text/javascript">
	$(function(){
		var bj=false;
		$("#easyui-tree").tree({
			url:"<%=request.getContextPath()%>/sys/queryMenu.action",
			checked:true,
			onClick:function(node){
				if(bj){
					bj=false;
					$("#easyui-tree").tree("expand",node.target);
				}else{
					bj=true;
					$("#easyui-tree").tree("collapse",node.target);
				}
			}
		});
	})
	//修改菜单页面
	function editPage(){
		//获取选中菜单
		var treeNode = $("#easyui-tree").tree("getSelected");
		if (treeNode != null) {
			//获取treeNode的id
			var id = treeNode.id;
			editDiaLog = bootbox.dialog({  
	       	    title: "修改菜单",  
	       	    message: "<iframe src=\"<%=request.getContextPath()%>/sys/editMwnuPage.action?id="+id+"\" width='100%' height='230px' style='border:0;'></iframe>"
	       	});
		}
	}
	//添加菜单页面
	function addPage(){
		//获取选中菜单
		var treeNode = $("#easyui-tree").tree("getSelected");
		if (treeNode == null || treeNode.attributes.level == 3) {
			bootbox.alert("请选择"+"<span  style='color:red;'>一级</sapn>"+"<span  style='color:black;'>或</sapn>"+"<span  style='color:red;'>二级</sapn>"+"<span  style='color:black;'>或</sapn>"+"<span  style='color:red;'>三级</sapn>"+"<span  style='color:black;'>菜单进行添加</sapn>");
		}else{
			//获取要添加菜单的父id
			var sysMenuId = treeNode.id;
			addDiaLog = bootbox.dialog({  
	       	    title: "添加菜单",  
	       	    message: "<iframe src=\"<%=request.getContextPath()%>/sys/addMwnuPage.action?sysMenuId="+sysMenuId+"\" width='100%' height='230px' style='border:0;'></iframe>"
	       	});
		}
	}
	//删除菜单
	function del(){
		var treeNode = $("#easyui-tree").tree("getSelected");
		if(treeNode == null ){
			bootbox.alert("请先选择要删除的菜单!");
			return ;
		}
		var id = treeNode.id;
		bootbox.confirm("你确定要删除吗?",function(r){
			if(r){
				$.ajax({
					type : "POST",
					url : "<%=request.getContextPath()%>/sys/delMenu.action",
					data : {"id":id},
					dataType : "json",
					cache : false,
					async : true,
					success : function(r) {
						if (r.success) {
							location.reload();
						} else {
					       	bootbox.dialog({  
					       	    title: "标题",  
					       	    message: "<span style='color:red;'>"+r.msg+"</span>",  
					       	    buttons: {  
					       	        Cancel: {  
					       	            label: "关闭",  
					       	            className: "btn-default",  
					       	            callback: function () {  
					       	                //取消 
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
	//关闭增加模态框
	function closeAddDiaLog(){
		addDiaLog.modal("hide");
		var bj=false;
		$("#easyui-tree").tree({
			url:"<%=request.getContextPath()%>/sys/queryMenu.action",
			checked:true,
			onClick:function(node){
				if(bj){
					bj=false;
					$("#easyui-tree").tree("expand",node.target);
				}else{
					bj=true;
					$("#easyui-tree").tree("collapse",node.target);
				}
			}
		});
		//location.href="<%=request.getContextPath()%>/sys/listMenu.action";
	}
	//关闭修改模态框
	function closeEditDiaLog(){
		editDiaLog.modal("hide");
		var bj=false;
		$("#easyui-tree").tree({
			url:"<%=request.getContextPath()%>/sys/queryMenu.action",
			checked:true,
			onDblClick:function(node){
				if(bj){
					bj=false;
					$("#easyui-tree").tree("expand",node.target);
				}else{
					bj=true;
					$("#easyui-tree").tree("collapse",node.target);
				}
			}
		});
		//location.href="<%=request.getContextPath()%>/sys/listMenu.action"
	}
	</script>
</html>