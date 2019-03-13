<%@page import="com.github.pagehelper.PageInfo"%>
<%@page import="com.yunzhong.appointment.entity.Illness"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>云众科技网上预约挂号系统</title>
	</head>
	<body>
	   <ul id="myTab" class="nav nav-tabs">
		<li class="active" id="active"><a data-toggle="tab" href="#ios">疾病</a></li>
		<li id="active2" onclick="illtp()"><a href="#home" data-toggle="tab">疾病类型</a></li>
		</ul>
		<div class="main-container" id="main-container">
			<!-- /section:basics/sidebar -->
			<div class="main-content">
				<div class="main-content-inner">
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12">
							<!-- <button type="button" class="btn btn-primary"  onclick="query()"><span style="font-size:20px;">疾病信息</span></button>
							<button type="button" class="btn btn-primary"  onclick="query1()"><span style="font-size:20px;">疾病类型信息</span></button> -->
							<!-- 检索  -->
							<form  method="post" name="infoForm" action="<%=request.getContextPath()%>/baseinfo/listIllness.action?pageNum=1">
								<div class="container">
									<div class="col-sm-4" style="margin-top: 20px;">	
										<input type="text" class="form-control" name="illName" placeholder="请输入疾病名称" value="${pd.illName}">
							    	</div>
									<div class="col-sm-4" style="margin-top: 20px;">									 
										<div class="input-group">
											<select name="illtpId"  class="form-control">
												<option value="">==请选择==</option>
												<c:forEach items="${illNessPosiTionList }" var="t">
												<option value="${t.illtpId }" ${pd.illtpId==t.illtpId?"selected":"" }>${t.illtpName }</option>
												</c:forEach>
											</select>
									      	<div class="input-group-btn">
					        					<button type="button" class="btn btn-warning" onclick="doSearch()"><span class="glyphicon glyphicon-search"></span></button>
									    	</div>
									    </div>
							    	</div>
							    	<div class="col-sm-2"></div>
							    	<div class="col-sm-2" style="margin-top: 20px;">
										<div class="form-group">
											<button type="button" class="btn btn-primary" title="增加" onclick="addpage('${ill.illId}')"><span class="glyphicon glyphicon-plus"></span></button>			
											<button type="button" class="btn btn-danger" title="批量删除" onclick="del()"><span class="glyphicon glyphicon-trash"></span></button>								
									    </div>
							    	</div>
							    </div>
								<table id="simple-table" class="table table-striped table-hover" style="margin-top:5px;">	
									<thead>
										<tr class="bg-primary">
											<td align="center">序号</td>
											<td align="center"><a href="javascript:selectAll()"><font style="color: white;">全选</font></a></td>
											<td align="center">疾病</td>
											<td align="center">疾病类型</td>
											<td align="center">操作</td>
										</tr>
									</thead>
															
									<tbody>
									<!-- 开始循环 -->
									<%
									Illness firstObj = (Illness)request.getAttribute("firstObj");
										if(firstObj!=null){
											String firstId = firstObj.getIllId();
											//对page.list进行调整
											PageInfo p = (PageInfo)request.getAttribute("page");
											List<Illness> list = p.getList();
											boolean flag = false;
											for(int i = 0; i < list.size(); i++){
												Illness temIllness = list.get(i);
												if(firstId.equals(temIllness.getIllId())){
													//如果增加或修改的数据本身就在第一页，调整增加的数据到第一位
													Illness ill0 = list.get(0);
													list.set(0, temIllness);
													list.set(i, ill0);
													flag = true;
												}
											}
											if(!flag){
												//如果增加或修改的数据不再第一页，增加或修改的数据放在第一位
												list.add(0, firstObj);
												list.remove(list.size()-1);
											}
										}
									%>
									<c:choose>
										<c:when test="${not empty page.list}">
											<c:forEach items="${page.list}" var="ill" varStatus="i">
												<tr>
												    <td align="center">${i.count+page.startRow-1}</td>
													<td align="center"><input type="checkbox" name="ids" value="${ill.illId}"></td>
													<td align="center">${ill.illName}</td>
													<td align="center">${ill.illtpName}</td>
													<td  align="center">
														<button type="button" class="btn btn-primary" title="修改" onclick="editpage('${ill.illId}')"><span class="glyphicon glyphicon-edit"></span></button>
														<button type="button" class="btn btn-danger" title="删除" onclick="delOne('${ill.illId}')"><span class="glyphicon glyphicon-minus"></span></button>														
													</td>
												</tr>
											</c:forEach>
										</c:when>
										<c:otherwise>
											<tr class="main_info">
												<td colspan="100" class="center" >没有相关数据</td>
											</tr>
										</c:otherwise>
									</c:choose>
									</tbody>
								</table>
								<div align="center">
									<yzpage:page pageName="page" url="/baseinfo/listIllness"></yzpage:page>
								</div>
							</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
<script type="text/javascript">
	function editpage(id){
		location.href = "/illness/editpage?id="+id;
	}
	function addpage(){

		location.href = "/illness/addpage";
	}
	function auth(id){
		location.href = "/illness/authUser?id="+id;
	}
	function delOne(id){
		bootbox.confirm("确定要删除吗?", function(result) {
			if(result){
				location.href = "/illness/removeIllness?ids="+id;
			}
		})
	}
	function query(){
		location.href = "/illness/listIllness";
	}
	function query1(){
		location.href = "/illnesstp/listIllnesstp";
	}
	function doSearch(){
		$("form[name='infoForm']").attr("action","/baseinfo/listIllness.action?pageNum=1");
		$("form[name='infoForm']").submit();
	}
	//全选
function selectAll(){
		var inpts = $("input[name='ids']");
		for(var i=0;i<inpts.length;i++){
			if(inpts[i].checked!=true){
				inpts[i].checked=true;
			}else{
				inpts[i].checked=false;
			}
		}
	}
function delOne(illId){
	bootbox.confirm("确定要删除吗?", function(result) {
		if(result){
			$.ajax({
				type : "post",
				url : "<%=request.getContextPath()%>/illness/delete",
				data : {"id":illId},
				dataType : "json",
				cache : false,
				async : true,
				success : function(r){
						if (r.success) {
							location.href="<%=request.getContextPath()%>/illness/listIllness";
						}else{
							 bootbox.alert(r.msg);
						}
				},
				error : function(){
					bootbox.alert("请求异常,请稍后再试!");
				}
			});
		}
	});
} 
//批量删除
function del(){
		var delids = $("input[name='ids']:checked");
			if(delids.length==0){
				bootbox.alert("请先选择要删除的记录！");
				return;
			}
			bootbox.confirm("确定要删除吗？",function(r){
				if(r){
					var ids = [];
					for (var i = 0; i < delids.length; i++) {
						var fxk = delids[i];
						ids.push(fxk.value)
					}
					$.ajax({
						type : "POST",
						url : "<%=request.getContextPath()%>/illness/deletes.action",
						data :{"ids":ids.join(",")} ,
						dataType : "json",
						cache : false,
						async : true,
						success : function(r){	
								if (r.success) {
									location.reload();
								}else{
									bootbox.dialog({  
										title: "提示",  
										message: r.msg,  
										buttons: {  
										OK: {  
												label: "OK",  
												className: "btn-primary",  
												callback: function () {  
													//确定
													location.reload();
												}  
											}  
										}  
									});
								}
						},
						error : function(){
							bootbox.alert("请求异常")
						}
					})
				}
			});			
	   }
function illtp(){
	location.href="<%=request.getContextPath()%>/baseinfo/listIllnessposition";
}
	</script>
</html>