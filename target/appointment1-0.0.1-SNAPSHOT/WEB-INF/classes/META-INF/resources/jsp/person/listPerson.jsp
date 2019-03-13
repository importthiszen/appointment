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
							<form  method="post" name="infoForm" action="/sys/listPerson">
								<div class="container">
									<div class="col-sm-4" style="margin-top: 20px;">
										<div class="input-group">
											<input type="text" class="form-control" name="ppName" placeholder="请输人员名称" autocomplete="off" value="${pd.ppName}">
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
											<td align="center">名称</td>
											<td align="center">科室</td>
											<td align="center">职称</td>
											<td align="center">状态</td>
											<td align="center">出诊费用</td>
											<td align="center">简介</td>
											<td align="center">操作</td>
										</tr>
									</thead>
															
									<tbody>
										<c:forEach items="${pageInfo.list }" var="t" varStatus="i" >
											<tr >
												<td align="center">${i.count+((pageInfo.pageNum-1)*pageInfo.pageSize)}</td>
												<td align="center"><input type="checkbox" name="ids" value="${t.ppId}"></td>
												<td align="center">${t.ppName}</td>
												<td align="center">${t.departmentName}</td>
												<td align="center">${t.professionalName}</td>
												<td align="center">
												<c:choose>
													<c:when test="${t.ppState=='A'}"><span style="color:#20df20;"><b>可用</b></span></c:when>
													<c:otherwise><span style="color:red;"><b>不可用</b></span></c:otherwise>
												</c:choose>
												</td>
												<td align="center">${t.doctorPay}</td>
												<td align="center">${t.ppInfo}</td>
												<td align="center">
													<button type="button" class="btn btn-primary" title="修改" onclick="editpage('${t.ppId}')"><span class="glyphicon glyphicon-edit"></span></button>
													<button type="button" class="btn btn-danger" title="删除" onclick="delOne('${t.ppId}')"><span class="glyphicon glyphicon-minus"></span></button>
												</td>
											</tr >
										</c:forEach>
									</tbody>
								</table>
								<div align="center">
								<yzpage:page pageName="pageInfo" url="/sys/listPerson"></yzpage:page>
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
	//修改页面
	function editpage(id){
		location.href = "/sys/editPersonPage?id="+id;
	}
	//增加页面
	function addpage(){
		$.ajax({
			type : "POST",
			url : "<%=request.getContextPath()%>/sys/queryPerUser.action",
			data : {},
			dataType : "json",
			cache : false,
			async : false,
			success : function(r) {
				if (r) {
					location.href = "/sys/addPersonPage";
				} else {
					bootbox.alert("请先添加一个"+"<span style='color:red;'>非患者,非游客</span>"+"的用户!");
				}
			},
			error : function() {
				bootbox.alert("请求异常")
			}
		})
		
	}
	//删除一个
	function delOne(id){
		bootbox.confirm("确定要删除吗?", function(result) {
			if(result){
				var url = "<%=request.getContextPath()%>/sys/delPerson.action";
				var data = {"ids":id};
				//post请求     没有缓存     异步   没有error
				$.post(url, data, function(r) {
					if (r) {
						location.reload();
					} else {
						bootbox.alert("删除失败");
					}
				}, "json")
			}
		})
	}
	
	function doSearch(){
		$("form[name='infoForm']").prop("action","<%=request.getContextPath()%>/sys/listPerson.action");
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
				var url = "<%=request.getContextPath()%>/sys/delPerson.action";
				var data = {"ids":ids.join(",")};
				//post请求     没有缓存     异步   没有error
				$.post(url, data, function(r) {
					if (r) {
						location.href="<%=request.getContextPath()%>/sys/listPerson.action";
					} else {
						bootbox.alert("删除失败");
					}
				}, "json")
			}
		})
	};
	</script>
</html>