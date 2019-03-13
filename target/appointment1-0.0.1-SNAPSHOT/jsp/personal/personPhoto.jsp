<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="../common/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>基于amazeui框架头像上传代码</title>

<link rel="stylesheet" type="text/css" href="../../static/css/font-awesome.4.6.0.css">
<link rel="stylesheet" href="../../static/css/amazeui.min.css">
<link rel="stylesheet" href="../../static/css/amazeui.cropper.css">
<link rel="stylesheet" href="../../static/css/custom_up_img.css">
<style type="text/css">
	.up-img-cover {width: 100px;height: 100px;}
	.up-img-cover img{width: 100%;}
</style>

</head>
<body>
	    <input  name="patientId" type="hidden"  value="${pt.patientId}" />
	    <input  name="userName" type="hidden"  value="${userName}" />
<center>
<div class="up-img-cover"  id="up-img-touch" >
     <c:if test="${pt.patientPic == null }">
	<img class="am-circle" alt="点击图片上传" src="<%=ctx %>/personal/down?location=${ps.ppPic}" data-am-popover="{content: '点击上传', trigger: 'hover focus'}" >
	</c:if>
	<c:if test="${ps.ppPic == null }">
	<img class="am-circle" alt="点击图片上传" src="<%=ctx %>/personal/down?location=${pt.patientPic}" data-am-popover="{content: '点击上传', trigger: 'hover focus'}" >
    </c:if>
</div>
</center>
<div><a style="text-align: center; display: block;"  id="pic"></a></div>

<!--图片上传框-->
<div class="am-modal am-modal-no-btn up-frame-bj " tabindex="-1" id="doc-modal-1">
  <div class="am-modal-dialog up-frame-parent up-frame-radius">
	<div class="am-modal-hd up-frame-header">
	   <label>修改头像</label>
	  <a href="javascript: void(0)" class="am-close am-close-spin" data-am-modal-close>&times;</a>
	</div>
	<div class="am-modal-bd  up-frame-body">
	  <div class="am-g am-fl">
		<div class="am-form-group am-form-file">
		  <div class="am-fl">
			<button type="button" class="am-btn am-btn-default am-btn-sm">
			  <i class="am-icon-cloud-upload"></i> 选择要上传的文件</button>
		  </div>
		  <input type="file" id="inputImage">
		</div>
	  </div>
	  <div class="am-g am-fl" >
		<div class="up-pre-before up-frame-radius">
			<img alt="" src="<%=ctx %>/personal/down?location=${pt.patientPic}" id="image" >
		</div>
		<div class="up-pre-after up-frame-radius">
		</div>
	  </div>
	  <div class="am-g am-fl">
		<div class="up-control-btns">
			<span class="am-icon-rotate-left"  onclick="rotateimgleft()"></span>
			<span class="am-icon-rotate-right" onclick="rotateimgright()"></span>
			<span class="am-icon-check" id="up-btn-ok" url="<%=ctx%>/personal/addimg"></span>
		</div>
	  </div>
	  
	</div>
  </div>
</div>

<!--加载框-->
<div class="am-modal am-modal-loading am-modal-no-btn" tabindex="-1" id="my-modal-loading">
  <div class="am-modal-dialog">
	<div class="am-modal-hd">正在上传...</div>
	<div class="am-modal-bd">
	  <span class="am-icon-spinner am-icon-spin"></span>
	</div>
  </div>
</div>

<!--警告框-->
<div class="am-modal am-modal-alert" tabindex="-1" id="my-alert">
  <div class="am-modal-dialog">
	<div class="am-modal-hd">信息</div>
	<div class="am-modal-bd"  id="alert_content">
			  成功了
	</div>
	<div class="am-modal-footer">
	  <span class="am-modal-btn">确定</span>
	</div>
  </div>
</div>
<script src="../../static/js/jquery-1.8.3.min.js"></script>
<script src="../../static/js/amazeui.min.js" charset="utf-8"></script>
<script src="../../static/js/cropper.min.js" charset="utf-8"></script>
<script src="../../static/js/custom_up_img.js" charset="utf-8"></script>
</body>
<script type="text/javascript">
$(document).ready(function(){
    $("#up-img-touch").click(function(){
              $("#doc-modal-1").modal({width:'300px'});
    });
});
$(function() {
'use strict';
// 初始化
var $image = $('#image');
$image.cropper({
    aspectRatio: '1',
    autoCropArea:0.8,
    preview: '.up-pre-after',
     
});

// 事件代理绑定事件
$('.docs-buttons').on('click', '[data-method]', function() {

    var $this = $(this);
    var data = $this.data();
    var result = $image.cropper(data.method, data.option, data.secondOption);
    switch (data.method) {
        case 'getCroppedCanvas':
        if (result) {
            // 显示 Modal
            $('#cropped-modal').modal().find('.am-modal-bd').html(result);
            $('#download').attr('href', result.toDataURL('image/jpeg'));
        }
        break;
    }
});
 
 

// 上传图片
var $inputImage = $('#inputImage');
var URL = window.URL || window.webkitURL;
var blobURL;

if (URL) {
    $inputImage.change(function () {
        var files = this.files;
        var file;

        if (files && files.length) {
           file = files[0];

           if (/^image\/\w+$/.test(file.type)) {
                blobURL = URL.ObjectURL(file);
                $image.one('built.cropper', function () {
                    // Revoke when load complete
                   URL.revokeObjectURL(blobURL);
                }).cropper('reset').cropper('replace', blobURL);
                $inputImage.val('');
            } else {
                window.alert('Please choose an image file.');
            }
        }

        // Amazi UI 上传文件显示代码
        var fileNames = '';
        $.each(this.files, function() {
            fileNames += '<span class="am-badge">' + this.name + '</span> ';
        });
        $('#file-list').html(fileNames);
    });
} else {
    $inputImage.prop('disabled', true).parent().addClass('disabled');
}
 
//绑定上传事件
$('#up-btn-ok').on('click',function(){
    var $modal = $('#my-modal-loading');
    var $modal_alert = $('#my-alert');
    var img_src=$image.attr("src");
    if(img_src==""){
        set_alert_info("没有选择上传的图片");
        $modal_alert.modal();
        return false;
    }
     
    $modal.modal();
     
    var url=$(this).attr("url");
    var canvas=$("#image").cropper('getCroppedCanvas');
    var data=canvas.toDataURL(); //转成base64
    var patientId = $("input[name='patientId']").val();
    var userName = $("input[name='userName']").val();
    $.ajax( {  
            url:url,  
            dataType:'json',  
            type: "POST",  
            data: {"image":data.toString(),"id":patientId,"userName":userName},  
            success: function(r){
               location.reload(); 
            },
            error: function(){
                $modal.modal('close');
                set_alert_info("上传文件失败了！");
                $modal_alert.modal();
                //console.log('Upload error');  
            }  
     });  
     
});
 
});

function rotateimgright() {
$("#image").cropper('rotate', 90);
}


function rotateimgleft() {
$("#image").cropper('rotate', -90);
}

function set_alert_info(content){
$("#alert_content").html(content);

}
</script>
</html>