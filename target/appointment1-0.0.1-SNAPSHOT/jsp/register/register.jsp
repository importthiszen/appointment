<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.shiro.subject.Subject"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="com.yunzhong.appointment.config.SessionConst"%>
<%@taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../../jsp/common/common.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<%--bootbox --%>
		<script src="../../static/js/bootbox.js"></script>
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
		 label.error {
			color: red;
			margin-left: 0px;
			width: auto;
			display: inline;
	      }
	</style>
	<body>
		
		<!--
        	作者：石洪刚
        	时间：2017年8月10日14:12:50
        	描述：个人中心	联系我们	登录	注册
        -->
		<div class="container">
			<nav class="nav navbar-default navbar-fixed-top container-fluid" role="navigation" style="background-color:aquamarine;">
				<div class="nav navbar-header">
					<!-- 导航头 -->
					<a class="navbar-brand" href="#">云众科技</a>
					<button class="navbar-toggle" data-toggle= "collapse" data-target="#mynav">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
				</div>
				<div class="collapse navbar-collapse" id="mynav">
					<!-- 导航内容 -->
<!-- 					<ul class="nav navbar-nav"> -->
<!-- 						<li><a href="">联系电话：0451-87362836</a></li> -->
<!-- 						下面的代码需要登录后才能显示	 -->
<%-- 						<% --%>
<!--  						 	Subject currentUser = SecurityUtils.getSubject(); -->
<!--  							String userName = (String)currentUser.getSession().getAttribute(SessionConst.SESSION_USERNAME); -->
<%-- 						%> --%>
<!-- 							<li><a href="huanzhe_personinfo.html">个人中心</a></li> -->
<%-- 							<li><a href="#"><span class="glyphicon glyphicon-user"></span>欢迎您：<%=userName %></a></li> --%>
<!-- 					</ul> -->
					<!-- 导航尾，登录后不再显示 -->
					<div class="nav navbar-right">
						<ul class="nav navbar-nav">
							<li><a href="<%=ctx%>/login">登录</a></li>
							<li><a href="<%=ctx%>/register/add">注册</a></li>
						</ul>
					</div>	
				</div>
			</nav>
		</div>
		<!--
        	作者：石洪刚
        	时间：2017年8月10日14:32:38
        	描述：项目名称   搜索框 （搜索框只有游客或患者可见）
        -->
		<div class="container" style="margin-top: 50px;">
			<div class="col-sm-6" >
				<h2 class="text-primary" >云众科技网上预约挂号系统</h2>
			</div>
			
			<div class="col-sm-6" style="margin-top: 15px;">
				<form method="post" name="form1" class="form form-horizontal">
					<div class="input-group">
					     <div class="input-group-btn">
						    <button id="index_search_btn" type="button" class="btn btn-warning dropdown-toggle" data-toggle="dropdown">科室<span class="caret"></span></button>
						       <ul class="dropdown-menu" role="menu">
						         <li><a href="#">科室</a></li>
						         <li><a href="#">疾病</a></li>
						       </ul>
					     </div><!-- /btn-group -->
					     <input type="text" class="form-control" placeholder="请输入搜索内容" >
					     <span class="input-group-addon" style="background-color:#f0ad4e;cursor: pointer;" >
						   <span class="glyphicon glyphicon-search "></span>
					     </span>
					</div>
				 </form>
			</div>
			
		</div>
		<!--
        	作者：石洪刚
        	时间：2017年8月10日17:04:47
        	描述：导航条   游客可见(在dashboard页) ：按科室挂号  按疾病挂号  最新公告
        -->
		<div class="container" style="margin-top: 10px;">
			<ul class="nav nav-pills guahao" role="tablist" style="background-color:lightcyan">
			  	<li class="active"><a href="../dashboard.html">首页</a></li>
			  	<li ><a href="../appointment/dept/listDept.html">按科室预约</a></li>
				<li ><a href="../appointment/illness/listIllness.html">按疾病预约</a></li>
				<li ><a href="../newestAnnoucement/listAnnouncement.html">最新公告</a></li>
			</ul>
		</div>
		<!--
        	作者：石洪刚
        	时间：2017年10月26日11:44:45
        	描述：注册信息
        -->
        <div class="container" style="margin-top: 10px;">
        	<form class="form form-horizontal" name="registerForm" method="post" action="javascript:doSub()">
        		<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">手机号码：</label>
					<div class="col-sm-4">
						<input name="patientTel"  class="form-control" type="text" placeholder="请输入手机号码,将作为登录账号" />
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">手机验证码：</label>
					<div class=" col-sm-4">
						<div class="input-group">
							<input type="text" class="form-control" placeholder="请您输入手机验证码">
							<span class="input-group-btn">
								<button class="btn btn-primary" type="button">
									获取验证码
								</button>
							</span>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1" >姓名：</label>
					<div class="col-sm-4">
						<input name="patientName" class="form-control" type="text" placeholder="输入您的真实姓名"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">性别：</label>
					<div class="col-sm-4">
						<div class="radio">
						   <label>
						      <input name="patientSex" type="radio" value="男" > 男
						   </label>
						   &nbsp;&nbsp;
						   <label>
						      <input name="patientSex" type="radio" value="女"> 女
						   </label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">身份证号：</label>
					<div class="col-sm-4">
						<input name="patientUid" id="patientUid" onblur="getBirthdayFromIdCard(this.value)" class="form-control" type="text"  placeholder="请您输入身份证号"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">出生日期：</label>
					<div class="col-sm-4">
						<input name="patientBirth" class="form-control" type="text" id="mydate"  placeholder="点击选择时间" readonly=""/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">设置密码：</label>
					<div class="col-sm-4">
						<div class="input-group">
							<input name="userPass" id="userPass" class="form-control" type="password"  placeholder="请输入登录密码"/>
							<div class="input-group-btn">
								<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
									<span title="隐藏密码" id="ps" onclick="xianshi(this)" class="glyphicon glyphicon-eye-close"></span>
									<span class="caret"></span>
								</button>
<!-- 								<ul class="dropdown-menu pull-right"> -->
<!-- 									<li><a href="#"><span id="sp2" onclick="xianshi()" title="显示密码" class="glyphicon glyphicon-eye-open"></span></a></li> -->
<!-- 								</ul> -->
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">确认密码：</label>
					<div class="col-sm-4">
						<input name="userPass2" class="form-control" type="password" placeholder="请确认登录密码"/>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1">现居住地：</label>
					<div class="col-sm-2">
						<select name="provinceId" onchange="selectCity(this.value)" class="form-control" >
							<option  value="" >请选择省份</option>
							<c:forEach items="${proList}" var="t">
							<option value="${t.provinceId}" >${t.provinceName}</option>
							</c:forEach>
						</select>
					</div>
					<div class="col-sm-2">
						<select name="cityId" onchange="selectArea(this.value)" id="city" class="form-control" >
							<option value="" >请选择城市</option>
						</select>
					</div>
					<div class="col-sm-2">
						<select name ="areaId" id="area" class="form-control" >
							<option value="" >请选择区县</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-sm-3 col-sm-offset-1"></label>
					<div class="col-sm-4">
						<div class="checkbox">
							<label>
						      <input type="checkbox" name="protocol">本人同意
						   </label>
						   <span class="text-info"><button type="button" style='border:0px solid white;background-color:white' onclick="showProtocol()">《预约挂号服务协议》</button></span>
						</div>
					</div>
				</div>
				<div class="form-group text-center">
					<button class="btn btn-lg btn-warning" type="submit">注&nbsp;&nbsp;册</button>
				</div>
        	</form>
        </div>
	</body>
	<script type="text/javascript">
		//表单验证
		$(function(){
		$("form[name='registerForm']").validate({
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
				patientName: {
					required : true,
	    			chanese:true,
	    			rangelength:[2,8]	
				},
				patientSex: {
					required : true
				},
				patientUid: {
					required : true,
					idcard:true
				},
				patientBirth: {
					required : true
				},
				userPass: {
					required : true,
					pass:true
				},
				userPass2: {
					required : true,
					equalTo: "#userPass"	//两个密码必须一致
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
				protocol: {
					required : true
				}
			},
			//下面的messages可以修改提示文字.
			messages:{
				patientTel: {
					required : "请填写号码",
					telphone : "请输入正确的手机号码",
					remote : "手机号重复"
				
				},
				patientName: {
					required : "姓名不能为空",
	    			chanese:"请填写中文真实姓名",
	    			rangelength:"长度2-8位"	
				},
				patientSex: {
					required : function(){
						
					}
				},
				patientUid: {
					required : "请输入身份证号",
					idcard:"身份证号格式错误"
				},
				patientBirth: {
					required : "请填写正确生日"
				},
				userPass: {
					required : "密码不能为空",
					pass:"密码至少包含大写字母，小写字母，数字，且不少于8位"
				},
				userPass2: {
					required : "确认密码不能为空",
					equalTo: "两次密码不一致"
				},
				provinceId: {
					required : "请选择所在省"
				},
				areaId: {
					required : "请选择城市"
				},
				cityId: {
					required : "请选择区"
				},
				protocol: {
					required : "请认真阅读并同意本条款"
				}
			},
			submitHandler: function() {
				doSub();
			},
	    	});
	    });
	   
		//根据省id查询市
		function selectCity(id){
			$("#city").empty();
			$("#city").append("<option value='' >请选择城市</option>");
			$("#area").empty();
			$("#area").append("<option value='' >请选择区县</option>");
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
				$("#area").append("<option value='' >请选择区县</option>");
				for (var i = 0; i < area.length; i++) {
					var ar = area[i];
					var arId = ar.areaId;
					var arName = ar.areaName;
					$("#area").append("<option value='"+arId+"' >"+arName+"</option>");
				}
			},"json");
		}
		
		
		//查看协议
		function showProtocol(){
			bootbox.dialog({  
                message: "<iframe src=\"<%=request.getContextPath()%>/register/protocol\" width=\"100%\" height=\"380\" style=\"border:0\"></iframe>",  
                title: "《预约挂号服务协议》",  
                buttons: {  
                    Cancel: {  
                        label: "取消",  
                        className: "btn-default",
                        callback: function () {  
                        	$("input[name='protocol']").prop("checked",false);
                        } 
                    }  
                    , OK: {  
                        label: "同意",  
                        className: "btn-primary",  
                        callback: function () {  
                        	$("input[name='protocol']").prop("checked",true);
                        }  
                    }  
                }  
            });
		}
		
		//注册提交
		function doSub(){
			bootbox.confirm("确定要提交注册信息？",function(rsult){
				if(rsult){
					var provinceName = $("select[name='provinceId']").find("option:selected").text();
					var cityName = $("select[name='cityId']").find("option:selected").text();
					var areaName = $("select[name='areaId']").find("option:selected").text();
					url="<%=request.getContextPath()%>/register/addSave";
					data = $("form[name='registerForm']").serialize()+'&'+$.param({
							"provinceName":provinceName,
							"cityName":cityName,
							"areaName":areaName
							});
					$.post(url,data,function(r){
						if(r){
							bootbox.alert("注册成功");
							//登录
							var userName = $("input[name='patientTel']").val();
							var userPass = $("input[name='userPass']").val();
							location.href="<%=request.getContextPath()%>/success?userName="+userName+"&userPass="+userPass;
						}else{
							bootbox.alert("亲,出现异常请稍后重试");
						}
					},"json");
				}
			})
		}

		//根据身份证获取生日
		function getBirthdayFromIdCard(idCard) {
		//验证身份证号合法性
		//var ps = IdentityCodeValid(idCard);
	  	var birthday = "";
		if(idCard != null && idCard != "" && ps){
			if(idCard.length == 15){
				birthday = "19"+idCard.substr(6,6);
			} else if(idCard.length == 18){
				birthday = idCard.substr(6,8);
			}
		
			birthday = birthday.replace(/(.{4})(.{2})/,"$1-$2-");
		}
		$("input[name='patientBirth']").val(birthday);
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
		
		var bj = false;
		//显示密码
		function xianshi(btn){
			
			if (bj) {
				
				$("input[name='userPass']").prop("type","password");
				bj = false;
			} else {
				
				$("input[name='userPass']").prop('type','text');
				bj = true;
			}
			
		}
// 		//验证身份证号是否合法
// 		function IdentityCodeValid(code) { 
//             var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
//             var tip = "";
//             var pass= true;
//             //验证身份证格式（6个地区编码，8位出生日期，3位顺序号，1位校验位）
//             if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
//                 tip = "身份证号格式错误";
//                 pass = false;
//             }
            
//            else if(!city[code.substr(0,2)]){
//                 tip = "地址编码错误";
//                 pass = false;
//             }
//             else{
//                 //18位身份证需要验证最后一位校验位
//                 if(code.length == 18){
//                     code = code.split('');
//                     //∑(ai×Wi)(mod 11)
//                     //加权因子
//                     var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
//                     //校验位
//                     var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
//                     var sum = 0;
//                     var ai = 0;
//                     var wi = 0;
//                     for (var i = 0; i < 17; i++)
//                     {
//                         ai = code[i];
//                         wi = factor[i];
//                         sum += ai * wi;
//                     }
//                     var last = parity[sum % 11];
//                     if(parity[sum % 11] != code[17]){
//                         tip = "校验位错误";
//                         pass =false;
//                     }
//                 }
//             }
//             if(!pass){
//             	var va = $("#patientUid").val();
//             	$("#patientUid").val(va+" ");
//             };
//             return pass;
//         }
	</script>
</html>
