package com.yunzhong.appointment.register.contorller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yunzhong.appointment.entity.City;
import com.yunzhong.appointment.entity.Patient;
import com.yunzhong.appointment.entity.Province;
import com.yunzhong.appointment.register.service.RegisterService;
import com.yunzhong.appointment.util.ResultJson;
/**
 * 注册控制器
 * @author 于占峰
 * 2019年2月27日16:54:16
 */
@Controller
@RequestMapping("register")
public class RegisterController {
	/**
	 * 模型层接口
	 */
     @Autowired
     private RegisterService service;
     
     /**
      * 注册跳转页面
      */
     @RequestMapping("add")
     public String add(ModelMap mp) {
    	 //查询省下拉框
    	 List<Province> proList = service.queryProvince();  //省
    	 System.err.println(proList);
    	 mp.put("proList", proList);
    	 return"register/register";
     }
     /**
      * 注册添加
      */
     @RequestMapping("addSave")
     @ResponseBody
     public ResultJson addSave(Patient pt) {
    	 ResultJson r = new ResultJson();
    	 int tiao = service.registerAddSave(pt);
    	 if (tiao>0) {
    		 //注册成功后进行登录
			r.setSuccess(true);
		} else {
            r.setSuccess(false);
		}
    	 return r;
     }
     /**
      * 验证手机号是否重复
      */
     @RequestMapping("NameRepetition")
     @ResponseBody
     public boolean NameRepetition(String tel) {
    	 System.err.println(tel);
    	  boolean r = false;
    	 int tiao = service.NameRepetition(tel);
    	 if (tiao>0) {
			r = true;
		} else {
            r = false;
		}
    	 return r;
     }
 	/**
 	 * 服务条款
 	 */
 	@RequestMapping("protocol")
 	public String protocol() {
 		return "register/protocol";
 	}
 	/**
 	 * 忘记密码
 	 */
 	@RequestMapping("recover")
 	public String recover() {
 		return"register/recoverPassword";
 	}
 	/**
 	 * 验证身份信息
 	 */
 	@RequestMapping("verify")
 	@ResponseBody
 	public ResultJson verify(Patient pt) {
 		ResultJson r = new ResultJson();
 		Boolean bj = service.verify(pt);
 		if (bj) {
			r.setSuccess(true);
		} else {
            r.setSuccess(false);
		}
 		return r;
 	}
 	/**
 	 * 重置密码
 	 */
 	@RequestMapping("recoverpass")
 	@ResponseBody
 	public ResultJson recoverpass(Patient pt) {
 		ResultJson r = new ResultJson();
 		int tiao = service.recoverpass(pt);
 		if (tiao>0) {
			r.setSuccess(true);
		} else {
            r.setSuccess(false);
		}
 		return r ;
 	}
}
