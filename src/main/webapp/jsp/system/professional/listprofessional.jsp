<%@page import="com.github.pagehelper.PageInfo"%>
<%@page import="com.yunzhong.appointment.entity.Professional"%>
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
		<div class="main-container" id="main-container">
			<!-- /section:basics/sidebar -->
			<div class="main-content">
				<div class="main-content-inner">
					<div class="page-content">
						<div class="row">
							<div class="col-xs-12">
								
							<!-- 检索  -->
							<form  method="post" name="infoForm" action="/sys/listProfessional">
								<div class="container">
									<div class="col-sm-4" style="margin-top: 20px;">
										<div class="input-group">
											<input type="text" class="form-control" name="professionalName" placeholder="请输入职称名称" value="${pd.professionalName }">
											<select name="dpId" class="form-control">
											<option value="">===请选择===</option>
											<c:forEach items="${deptList}" var="dept">
												<option value="${dept.dpId }" ${dept.dpId eq pd.dpId ? "selected":""} }>${dept.dpName }</option>
											</c:forEach>
											</select>						
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
											<td align="center"><a href="javascript:selectAll()"><font style="color: white;">全选</font></a></td>
											<td align="center">职称名称</td>
											<td align="center">科室名称</td>
											<td align="center">出诊费用</td>
											<td align="center">操作</td>
										</tr>
									</thead>
															
									<tbody>
									<!-- 开始循环 -->
									<%
									Professional firstObj = (Professional)request.getAttribute("firstObj");
										if(firstObj!=null){
											String firstId = firstObj.getProfessionalId();
											//对page.list进行调整
											PageInfo p = (PageInfo)request.getAttribute("page");
											List<Professional> list = p.getList();
											boolean flag = false;
											for(int i = 0; i < list.size(); i++){
												Professional temProfessional = list.get(i);
												if(firstId.equals(temProfessional.getProfessionalId())){
													//如果增加或修改的数据本身就在第一页，调整增加的数据到第一位
													Professional pro0 = list.get(0);
													list.set(0, temProfessional);
													list.set(i, pro0);
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
											<c:forEach items="${page.list}" var="pro" varStatus="i">
												<tr>
													<td align="center"><input type="checkbox" name="ids" value="${pro.professionalId}"></td>
													<td align="center">${pro.professionalName}</td>
													<td align="center">${pro.dpName}</td>
													<td align="center">${pro.professionalFee}</td>
													<td  align="center">
														<button type="button" class="btn btn-primary" title="修改" onclick="editpage('${pro.professionalId}')"><span class="glyphicon glyphicon-edit"></span></button>
														<button type="button" class="btn btn-danger" title="删除" onclick="delOne('${pro.professionalId}')"><span class="glyphicon glyphicon-minus"></span></button>
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
									<yzpage:page pageName="page" url="/sys/listProfessional"></yzpage:page>
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
		location.href = "/sys/pagePro?id="+id;
	}
	function addpage(){
		location.href = "/sys/pagePro";
	}
	function auth(id){
		location.href = "/sys/authUser?id="+id;
	}
	//删除一条数据
	function delOne(id){
		bootbox.confirm("确定要删除吗?", function(result) {
			if(result){
				$.ajax({
					type : "POST",
					url : "<%=ctx%>/sys/removePro", 
					data :{"ids":id} ,
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
									size: "large",
									buttons: {  
										OK: {  
											label: "OK",  
											className: "btn-primary",  
											callback: function () {  
												location.reload();//刷新页面
											}  
										}  
									}  
								});
							}
					},
					error : function(){
						bootbox.alert("请求异常,请稍后再试");
					}
				})	
			}
		})
	}
	
	function doSearch(){
		$("form[name='infoForm']").attr("action","/sys/listProfessional");
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
		bootbox.confirm("'确定要删除选中的数据吗?", function(result) {
			if(result) {
				var checked = $("form[name='infoForm'] :input:checked");
				console.info("checked:"+checked);
				if(checked.length==0){
					bootbox.dialog({
						message: "<span class='bigger-110'>您没有选择任何内容!</span>",
						buttons: 			
						{ "button":{ "label":"确定", "className":"btn-sm btn-success"}}
					});
					$("#zcheckbox").tips({
						side:1,
			            msg:'点这里全选',
			            bg:'#AE81FF',
			            time:8
			        });
					return;
				}else{
					var ids=[];
					for(var i=0;i<checked.length;i++){
						var check=checked[i];
						ids.push(check.value);
						console.info("ids:"+ids);
					}
			/* 	$("form[name='infoForm']").attr("action","/sys/removePro");
					$("form[name='infoForm']").submit(); */					
					$.ajax({
						type : "POST",
						url : "<%=ctx%>/sys/removePro", 
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
										size: "large",
										buttons: {  
											OK: {  
												label: "OK",  
												className: "btn-primary",  
												callback: function () {  
													location.reload();//刷新页面
												}  
											}  
										}  
									});
								}
						},
						error : function(){
							bootbox.alert("请求异常,请稍后再试");
						}
					})	
				}
			}
		});
	};

	</script>
</html>