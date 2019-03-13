<%@page import="com.yunzhong.appointment.config.SessionConst"%>
<%@page import="com.yunzhong.appointment.entity.SysMenu"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.yunzhong.appointment.config.Const"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@include file="../common/common.jsp" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<title>云众科技网上预约挂号系统</title>
	</head>
	<style>
		html body{
			width: 100%;
		}
		.piaoyikuang{
			border: 1px solid #66AFE9;
			border-radius: 10px;
		}
		.piaoyi{
			float: left;
			width: 100px;
			height: 30px;
			border: 0px solid #66AFE9;
			text-align: center;
		}
		.ks-left{
			border: 1px solid #66AFE9;
			border-radius: 10px;
			margin-right: 0px;
		}
		.ks-right{
			border: 0px solid #66AFE9;
			border-radius: 10px;
		}
	</style>
	<body>
		<!--
        	作者：石洪刚
        	时间：2017年10月26日11:44:45
        	描述：个人中心
        -->
        <div class="container" style="margin-top: 10px;">
        	<form class="form form-horizontal" name="infoForm" method="post" action="javascript:doSub()">
        	<input  name="patientId" type="hidden"  value="${pt.patientId}" />
	        	<div class="form-group">
				<label class="control-label col-xs-2">手机号码：</label>
				<div class="col-xs-5">
					<input class="form-control" id="patientTel" type="text"  value="${pt.patientTel}" readonly="readonly"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-2">姓名：</label>
				<div class="col-xs-5">
					<input class="form-control" id="patientName" type="text" value="${pt.patientName}" readonly="readonly"/>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-2">身份证号：</label>
				<div class="col-xs-5">
					<input class="form-control" id="patientUid" type="text" value="${pt.patientUid}" readonly="readonly" />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-2">性别：</label>
				<div class="col-xs-5">
					<div class="radio">
					   <label>
					      <input name="patientSex" type="radio" ${pt.patientSex == '男' ?"checked":""} value="男"  disabled /> 男
					   </label>
					   &nbsp;&nbsp;
					   <label> 
					     <input name="patientSex" type="radio"  ${pt.patientSex == '女' ?"checked":""} value="女" disabled  /> 女
					  </label>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-2">出生日期：</label>
				<div class="col-xs-5">
				
					<input class="form-control" name="patientBirth"  id="mydate" value='<fmt:formatDate value="${pt.patientBirth}" pattern="yyyy-MM-dd"/>' />
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-xs-2 ">现居住地：</label>
				<div class="col-sm-2">
					<select onchange="selectCity(this.value)" name="provinceId"class="form-control" >
					    <c:forEach items="${proList}" var="t">
							<option value="${t.provinceId}" ${t.provinceId == pt.provinceId ? "selected":""} >${t.provinceName}</option>
						</c:forEach>
						
					</select>
				</div>
				<div class="col-sm-2">
					<select onchange="selectArea(this.value)" id="city" name="cityId" class="form-control">
						<option value="${pt.cityId}" >${pt.cityName}</option>
					</select>
				</div>
				<div class="col-sm-2">
					<select name="areaId" id="area" class="form-control">
						<option value="${pt.areaId}" >${pt.areaName}</option>
					</select>
				</div>
			</div>
			<div class="form-group text-center">
				<button class="btn btn-lg btn-warning" type="submit">修&nbsp;&nbsp;改</button>
			</div>
        		
        	</form>
        </div>
	</body>
	<script type="text/javascript">
	    
		$(function(){
			var tel = $("#patientTel").val();;
			tel = tel.substring(0,3)+"****"+tel.substring(8,11);
			$("#patientTel").val(tel);
			var uid = $("#patientUid").val();
			uid = uid.substring(0,3)+"**********"+uid.substring(14,18);
			$("#patientUid").val(uid);
			//表单验证
			$("form[name='infoForm']").validate({
				rules: {
					patientTel: {
						required : true,
						telphone : true,
						 remote: {
		                        url: "<%=request.getContextPath()%>/register/NameRepetition",
		                        type: "post",
		                        dataType: "json",
		                        data: {
		                        	tel: function () {
		                                return $("input[name='patientTel']").val();　　　　//手机号
		                            }
		                        },
		                        dataFilter: function (data) {　　　　
		                            if (data == "true") {
		                                return false;
		                            }else {
		                                return true;
		                            }
		                        }
		                    }
					},
					provinceId: {
						required : true	
					},
					areaId: {
						required : true	
					},
					cityId: {
						required : true	
					},
					patientBirth: {
						required : true	
					},
					
				},
				//下面的messages可以修改提示文字.
				messages:{
					provinceId: {
						required : "请选择所在省"
					},
					areaId: {
						required : "请选择城市"
					},
					cityId: {
						required : "请选择区"
					},
					patientBirth: {
						required : "请填写生日"
					}
				},
				submitHandler: function() {
					doSub();
				},
		    	});
		})
		//注册提交
		function doSub(){
			bootbox.confirm("确定要提交注册信息？",function(result){
				if(result){
					var provinceName = $("select[name='provinceId']").find("option:selected").text();
					var cityName = $("select[name='cityId']").find("option:selected").text();
					var areaName = $("select[name='areaId']").find("option:selected").text();
					url = "<%=ctx%>/personal/edit";
					data = $("form[name='infoForm']").serialize()+'&'+$.param({
						"provinceName":provinceName,
						"cityName":cityName,
						"areaName":areaName
						});
					$.post(url,data,function(r){
						if (r) {
							alert("修改个人信息成功");
							location.reload();
						} else {
							bootbox.alert("修改个人信息失败");
						}
					},"json");
				}
			})
		}
		//根据省id查询市
		function selectCity(id){
			$("#city").empty();
			var url = "<%=request.getContextPath()%>/region/city";
			var data = {"id":id}
			$.post(url,data,function(r){
				var city = r.obj;
				for (var i = 0; i < city.length; i++) {
					var ct = city[i];
					var ctId = ct.cityId;
					var ctName = ct.cityName;
					$("#city").append("<option value='"+ctId+"' >"+ctName+"</option>");
				}
			},"json");
		}
		//根据市id查询区
		function selectArea(id){
			$("#area").empty();
			var url = "<%=request.getContextPath()%>/region/area";
			var data = {"id":id}
			$.post(url,data,function(r){
				var area = r.obj;
				for (var i = 0; i < area.length; i++) {
					var ar = area[i];
					var arId = ar.areaId;
					var arName = ar.areaName;
					$("#area").append("<option value='"+arId+"' >"+arName+"</option>");
				}
			},"json");
		}
		
		//日期的显示
		$("#mydate").datetimepicker({
	        minView: 'month',
	        format:'yyyy-mm-dd',
	        weekStart: 1,
	        todayBtn: 1,
	        autoclose: 1,
	        todayHighlight: 1,
	        startView: 2,
	        forceParse: 0,
	        showMeridian: 1,
	        endDate:new Date(),
	        language: 'zh-CN',
	        buttonText:'如果你需要修改出生日期,请手动修改'
	    });
	</script>
</html>
