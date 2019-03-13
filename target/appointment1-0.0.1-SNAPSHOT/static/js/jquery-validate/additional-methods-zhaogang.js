jQuery.validator.addMethod(
    "telphone", 
    function(value, element, param) {
        var reg = /^1[3-9]{1}\d{9}$/;
		if(reg.test(value)){
			return true;
		}
        return false;   
    }, 
    "请输入正确的手机号"
);

jQuery.validator.addMethod(
	    "chanese", 
	    function(value, element, param) {
	        var reg = /^[\u4e00-\u9fa5]*$/;
			if(reg.test(value)){
				return true;
			}
	        return false;   
	    }, 
	    "请输入汉字"
	);


	jQuery.validator.addMethod("minNumber",
			function(value, element){
	    var returnVal = true;
	    inputZ=value;
	    var ArrMen= inputZ.split(".");    //截取字符串
	    if(ArrMen.length==2){
	        if(ArrMen[1].length>2){    //判断小数点后面的字符串长度
	            returnVal = false;
	            return false;
	        }
	    }
	    return returnVal;
	},"小数点后最多为两位");         //验证错误信息