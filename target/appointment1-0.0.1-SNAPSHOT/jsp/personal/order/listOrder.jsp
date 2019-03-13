<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../../common/common.jsp" %>

<html>
	<head>
		<link rel="stylesheet" type="text/css" href="../../../static/css/bootstrap.min.css"/>
		<script type="text/javascript" src="../../../static/js/jquery-2.2.4.min.js"></script>
		<script type="text/javascript" src="../../../static/js/jquery.tips.js"></script>
		<script type="text/javascript" src="../../../static/js/bootstrap.min.js" ></script>
		<script src="../../../static/js/bootbox.js"></script>
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
							<form  method="post" name="infoForm" action="/personal/listOrder">
								<input name="order_state" value="" type="hidden">
								<input name="userName" value="${userName}" type="hidden">
								<table id="simple-table" class="table table-striped table-hover" style="margin-top:5px;">	
									<thead>
										<tr>
											<th class="center" >序号</th>
											<th class="center">预约日期</th>
											<th class="center">预约时间</th>
											<th class="center">预约医生</th>
											<th class="center">科室</th>
											<th class="center">患病</th>
											<th class="center">挂号费</th>
											<th class="center">操作</th>
											<th class="center">状态</th>
										</tr>
									</thead>
															
									<tbody>
									  <c:forEach items="${page.list}" var="t" varStatus="i">
									  <tr>
											<td class='center'>${i.count}</td>
											<td class='center'><fmt:formatDate value="${t.appointmentDate}" pattern="yyyy-MM-dd"/></td>
											<td class='center'>${t.amPm}</td>
											<td class='center'>${t.doctorName}</td>
											<td class='center'>${t.departmentName}</td>
											<td class='center'>${t.illnessName}</td>
											<td class='center'>${t.registeredfee}</td>
											<td class="center">
											<c:if test="${t.orderState == 'N'}">
												<button class="btn btn-danger btn-sm" type="button" onclick="payOrder('${t.paytypeOrderid}','${t.appointmentId}','${t.registeredfee}')">付款</button>
											</c:if>
 											<c:if test="${t.orderState == 'N' || t.orderState == 'P'}"> 
												<button class="btn btn-warning btn-sm" type="button" onclick="cancelOrder(this,'${t.appointmentId}','${t.appointmentDate}')">取消</button>
 											</c:if>
											</td>
											<td>
												<c:if test="${t.orderState == 'N'}">
												未付款
												</c:if>
												<c:if test="${t.orderState == 'P'}">
												已付款
												</c:if>												
												<c:if test="${t.orderState == 'A'}">
												已就诊
												</c:if>												
												<c:if test="${t.orderState == 'T'}">
												停诊
												</c:if>												
												<c:if test="${t.orderState == 'S'}">
												爽约
												</c:if>												
												<c:if test="${t.orderState == 'C'}">
												已退款
												</c:if>												
											</td>
										</tr>
									  </c:forEach>
																				
									</tbody>
								</table>
								<div align="center">
									<yzpage:page pageName="page" url="/personal/listOrder"></yzpage:page>
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
		
		//取消订单
		function cancelOrder(btn,id,date){
			//判断是否超过可取消时间
			 //当前时间
			 var timestamp = Date.parse(new Date());
			//取得预约前一天的15点
			date = getNextDate(date,-1);
			date = date + ' 15:00:00';
			date = Date.parse(date);
			console.info(date);
			console.info(timestamp);
			if(timestamp > date){
				bootbox.alert("无法取消,已超过可取消时间,请在预约时间前一天的15点前取消订单!");
				return;
			}
			bootbox.confirm("确定要取消订单,此操作将删除该订单!",function(result){
				if(result){
					url = "<%=ctx%>/personal/cancelOrder";
					data = {"id":id};
					$.post(url,data,function(r){
				           if (r.success) {
				        	         bootbox.confirm("取消成功,退款申请已提交中,退款将于24小时内退回到支付账户中.",function(re){
					   				          if(re){
					   					            location.reload();
								   			  }else{
								   			        location.reload();	
								   			       }
								   		            });
						          } 
				           else  {
                                  bootbox.alert("取消订单失败请稍后重试,给您带来的不变敬请谅解");
						         }	
					},"json");
				}
			})
		}
		
		//取指定时间的前一天
		 function getNextDate(date,day) {  
		  var dd = new Date(date);
		  dd.setDate(dd.getDate() + day);
		  var y = dd.getFullYear();
		  var m = dd.getMonth() + 1 < 10 ? "0" + (dd.getMonth() + 1) : dd.getMonth() + 1;
		  var d = dd.getDate() < 10 ? "0" + dd.getDate() : dd.getDate();
		  return y + "-" + m + "-" + d;
           };

         //付款
   		function payOrder(no,id,free){
   			bootbox.dialog({  
   			      message: "订单号："+no+"<br />支付费用："+free,  
   			      title: "支付方式",  
   			      buttons: {  
   			      weixin: {  
   			         label: "微信",  
   			         className: "btn-primary",  
   			         callback: function () {  
   			         location.href = "/personal/payOrder?id="+id+"&type=zhifubao";
   			                   }  
   			         }
   			       , zhifubao: {  
   			         label: "支付宝",  
   			         className: "btn-primary",  
   			         callback: function () {  
   			              location.href = "/personal/payOrder?id="+id+"&type=zhifubao";  
   			                   }  
   			              }  
   			          }  
   			}); 
   		}

	</script>
</html>