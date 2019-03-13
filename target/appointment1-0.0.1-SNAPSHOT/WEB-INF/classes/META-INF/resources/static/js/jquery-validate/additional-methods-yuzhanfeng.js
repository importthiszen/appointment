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
	    "chaneseorenglish", 
	    function(value, element, param) {
	        var reg = /^[\u0391-\uFFE5A-Za-z]+$/;
			if(reg.test(value)){
				return true;
			}
	        return false;   
	    }, 
	    "请输入汉字或英文"
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
//验证密码强度 
jQuery.validator.addMethod(
		"pass", 
		function(value, element, param) {
			var reg = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^]{8,16}$/;
			if(reg.test(value)){
				return true;
			}
			return false;   
		}, 
		"密码至少包含大写字母，小写字母，数字，且不少于8位"
);
//验证身份证号 并验证出生日期是否大于当前日期
jQuery.validator.addMethod(
		"idcard", 
		function(value, element, param) {
			var reg = /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|X)$/;
			if(reg.test(value)){
				var birthday = "";
				var timestamp = Date.parse(new Date());//当前时间
					if(value.length == 15){
						birthday = "19"+value.substr(6,6);
					} else if(value.length == 18){
						birthday = value.substr(6,8);
					}
					birthday = birthday.replace(/(.{4})(.{2})/,"$1-$2-");
					var birth = Date.parse(birthday);
					if(birth >timestamp){
						return false;
					}
				return true;
			}
			return false;   
		}, 
		"身份证格式错误"
);