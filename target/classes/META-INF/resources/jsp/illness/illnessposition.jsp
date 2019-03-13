<%@page import="com.github.pagehelper.PageInfo"%>
<%@page import="com.yunzhong.appointment.entity.Illnessposition"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>云众科技网上预约挂号系统</title>
	</head>
    <body>
	    <ul id="myTab" class="nav nav-tabs">
			<li id="active2" onclick="ill()"><a href="#home" data-toggle="tab">疾病</a></li>
			<li class="active" id="active"><a data-toggle="tab" href="#ios">疾病类型</a></li>
		</ul>
		<div class="main-container" id="main-container">
			<!-- /section:basics/sidebar -->
			<div class="main-content">
				<div class="main-content-inner">
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12">						
							<!-- 检索  -->
							<form  method="post" name="infoForm" action="<%=request.getContextPath()%>/baseinfo/listIllnessposition.action?PageNum=1">
								<div class="container">
									<div class="col-sm-4" style="margin-top: 20px;">									 
										<div class="input-group">
											<input type="text" class="form-control" name="illtpName" placeholder="请输入疾病类型" value="${pd.illtpName }">
									      	<div class="input-group-btn">
					        					<button type="button" class="btn btn-warning" onclick="doSearch()"><span class="glyphicon glyphicon-search"></span></button> 
									    	</div>
									    </div>
							    	</div>
							    	<div class="col-sm-6"></div>
							    	<div class="col-sm-2" style="margin-top: 20px;">
										<div class="form-group">											
											<button type="button" class="btn btn-primary" title="增加" onclick="addpage()"><span class="glyphicon glyphicon-plus"></span></button>
											<button type="button" class="btn btn-danger" title="批量删除" onclick="del()"><span class="glyphicon glyphicon-trash"></span></button>										
									    </div>
							    	</div>
							    </div>
								<table id="simple-table" class="table table-striped table-hover" style="margin-top:5px;">	
									<thead>
										<tr class="bg-primary">
											<td align="center">序号</td>
											<td align="center"><a href="javascript:selectAll()"><font style="color: white;">全选</font></a></td>
											<td align="center">疾病类型</td>
											<td align="center">操作</td>
										</tr>
									</thead>
															
									<tbody>
									<c:choose>
										<c:when test="${not empty page.list}">
											<c:forEach items="${page.list}" var="illtp" varStatus="i">
												<tr>
													<td align="center">${i.count+page.startRow-1}</td>
													<td align="center"><input type="checkbox" name="ids" value="${illtp.illtpId}"></td> 
													<td align="center">${illtp.illtpName}</td>
													<td  align="center">
														<button type="button" class="btn btn-primary" title="修改" onclick="editpage('${illtp.illtpId}')"><span class="glyphicon glyphicon-edit"></span></button>
														<button type="button" class="btn btn-danger" title="删除" onclick="delOne('${illtp.illtpId}')"><span class="glyphicon glyphicon-minus"></span></button>																										    														
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
									<yzpage:page pageName="page" url="/baseinfo/listIllnessposition"></yzpage:page>
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
		location.href = "/baseinfo/editpage?id="+id;
	}
	function addpage(){
		location.href = "/baseinfo/addIllnesspositionPage";
	}
	function delOne(illtpId){
		bootbox.confirm("确定要删除吗?", function(result) {
			if(result){
				$.ajax({
					type : "post",
					url : "<%=request.getContextPath()%>/illnesstp/delete",
					data : {"id":illtpId},
					dataType : "json",
					cache : false,
					async : true,
					success : function(r){
							if (r.success) {
								location.href="<%=request.getContextPath()%>/illnesstp/listIllnesstp";
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
							url : "<%=request.getContextPath()%>/illnesstp/deletes.action",
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
	function doSearch(){
		$("form[name='infoForm']").attr("action","/baseinfo/listIllnessposition");
		$("form[name='infoForm']").submit();
	}
	function ill(){
		location.href="<%=request.getContextPath()%>/baseinfo/listIllness";
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
</script>
</html>