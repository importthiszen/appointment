<%@page import="com.github.pagehelper.PageInfo"%>
<%@page import="com.yunzhong.appointment.entity.SysUser"%>
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
		<div class="main-container" id="main-container">
			<!-- /section:basics/sidebar -->
			<div class="main-content">
				<div class="main-content-inner">
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12">
								
							<!-- 检索  -->
							<form  method="post" name="infoForm" action="/baseinfo/listAnnouncement">
								<div class="container">
									<div class="col-sm-4" style="margin-top: 20px;">
										<div class="input-group">
											<input type="text" class="form-control" name="noticeTitle" placeholder="请输入标题名称" value="${pd.noticeTitle }">
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
											<td align="center">标题</td>
											<td align="center">添加时间</td>
											<td align="center">操作</td>
										</tr>
									</thead>
															
									<tbody>
										<c:forEach items="${pageInfo.list }" var="t" varStatus="i">
											<tr >
												<td align="center">${i.count+((pageInfo.pageNum-1)*pageInfo.pageSize)}</td>
												<td align="center"><input type="checkbox" name="ids" value="${t.noticeId }"></td>
												<td align="center">${t.noticeTitle }</td>
												<td align="center"><fmt:formatDate value="${t.noticeTime }" pattern="yyyy-MM-dd hh:mm:ss EEE"/></td>
												<td align="center">
													<button type="button" class="btn btn-primary" title="修改" onclick="editpage('${t.noticeId }')"><span class="glyphicon glyphicon-edit"></span></button>
													<button type="button" class="btn btn-danger" title="删除" onclick="delOne('${t.noticeId }')"><span class="glyphicon glyphicon-minus"></span></button>
												</td>
											</tr >
										</c:forEach>
									</tbody>
								</table>
								<div align="center">
								<yzpage:page pageName="pageInfo" url="baseinfo/listAnnouncement"></yzpage:page>
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
		location.href = "/baseinfo/editAnnouncementPage?id="+id;
	}
	function addpage(){
		location.href = "/baseinfo/addAnnouncementPage";
	}
	//删除一个
	function delOne(id){
		bootbox.confirm("确定要删除吗?", function(result) {
			if(result){
				var url = "<%=request.getContextPath()%>/baseinfo/del.action";
				var data = {"ids":id};
				//post请求     没有缓存     异步   没有error
				$.post(url, data, function(r) {
					if (r) {
						location.href="<%=request.getContextPath()%>/baseinfo/listAnnouncement.action";
					} else {
						bootbox.alert("删除失败");
					}
				}, "json")
			}
		})
	}
	
	function doSearch(){
		$("form[name='infoForm']").prop("action","<%=request.getContextPath()%>/baseinfo/listAnnouncement.action");
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
	
	//批量操作
	function del(){
		var ids=[];
		var idInps = $("input[name='ids']:checked");
		if (idInps.length==0) {
			bootbox.alert("请选择需要删除的记录!");
			return ;
		}
		for (var i = 0; i < idInps.length; i++) {
			ids.push(idInps[i].value);
		}
		bootbox.confirm("确定要删除吗?", function(result) {
			if(result){
				var url = "<%=request.getContextPath()%>/baseinfo/del.action";
				var data = {"ids":ids.join(",")};
				//post请求     没有缓存     异步   没有error
				$.post(url, data, function(r) {
					if (r) {
						location.href="<%=request.getContextPath()%>/baseinfo/listAnnouncement.action";
					} else {
						bootbox.alert("删除失败");
					}
				}, "json")
			}
		})
	};
	</script>
</html>