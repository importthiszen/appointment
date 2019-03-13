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
		<div class="container">
			<form class="form-horizontal text-center" style="position:relative;"  name="infoForm" action="javascript:doSub()" method="post" enctype="multipart/form-data">
				<input type="hidden" name="noticeId" value="${anno.noticeId}">
				<div class="container" >
					<div class="form-group" height="10px" ></div>
					<div class="form-group" >
						<label class="control-label col-sm-2 col-md-2">公告标题:</label>
						<div class="col-md-7 col-sm-7">
							<input class="form-control" name="noticeTitle" required value="${anno.noticeTitle}" oninput="validatName()" placeholder="请输入公告标题" />
						</div>	
					</div>
					<div class="form-group">
						<textarea id="newsEditor" name="noticeContent" style="width: 700px;height:330px;"> </textarea>
						<br />
						<script type="text/javascript">
							
						</script>
					</div>
					<div class="form-group">
						<div class="col-lg-4 col-md-4 col-sm-2 col-xs-2">
							
						</div>
						<div class=" col-lg-4 col-md-4 col-sm-8 col-xs-8" >
							<div class="col-md-6 col-sm-6">
								<input class="form-control btn-primary" type="submit" id="sub" value="提交" />
							</div>
							<div class="col-md-6 col-sm-6">
								<input class="form-control btn-primary" type="button" onclick="goBack()" value="返回" />
							</div>
						</div>
						<div class="col-lg-4 col-md-4 col-sm-2 col-xs-2">
							
						</div>
					</div>
				</div>
			</form>
			<hr/>
		</div>
	</body>
	<script type="text/javascript">
	//验证是否重复
	function validatName(){
		$("input[name='noticeTitle'] + span").remove();
		$("#sub").prop("disabled",false);
		var noticeTitle = $.trim( $("input[name='noticeTitle']").val() ); 
		if (noticeTitle == $.trim("${anno.noticeTitle}")) {
			return ;
		}
		if($.trim(noticeTitle) != ""){
			$.ajax({
				type : "POST",
				url : "<%=request.getContextPath()%>/baseinfo/validatAnnoName.action",
				data : {"noticeTitle":noticeTitle},
				dataType : "json",
				cache : false,
				async : false,
				success : function(r) {
					if (r) {
						$("input[name='noticeTitle']").after("<span style='color:red;'>标题名称重复!</span>");
						$("#sub").prop("disabled",true);
					}else{
						$("input[name='noticeTitle'] + span").remove();
						$("#sub").prop("disabled",false);
					}
				},
				error : function() {
					bootbox.alert("请求异常")
				}
			})
		}
	}
	//提交
	function doSub(){
		bootbox.confirm("你确定要保存吗?",function(r){
			if (r) {
				var url = "<%=request.getContextPath()%>/baseinfo/editAnnouncement.action";
				var data = $("form[name='infoForm']").serialize();
				//post请求     没有缓存     异步   没有error
				$.post(url, data, function(r) {
					if (r.success) {
						location.href="<%=request.getContextPath()%>/baseinfo/listAnnouncement.action?pageNum=1";
					} else {
						bootbox.alert("修改失败!");
					}
				}, "json")			
			}
		})
	}
	
	var ue = UE.getEditor('newsEditor');
	ue.ready(function() {
	    //设置编辑器的内容
	   ue.setContent('${anno.noticeContent}');
	    //获取html内容，返回: <p>hello</p>
	   var html = ue.getContent();
	    //获取纯文本内容，返回: hello
	    var txt = ue.getContentTxt();
	});

	
	//返回
	function goBack(){
		history.go(-1);
	}
	</script>
</html>