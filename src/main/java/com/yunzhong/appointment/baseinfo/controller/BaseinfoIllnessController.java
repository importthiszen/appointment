package com.yunzhong.appointment.baseinfo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.druid.sql.visitor.functions.If;
import com.github.pagehelper.PageInfo;
import com.yunzhong.appointment.entity.Illness;
import com.yunzhong.appointment.entity.Illnessposition;
import com.yunzhong.appointment.illness.service.IllnessService;
import com.yunzhong.appointment.util.PageData;

/**
 * 冯建辉
 * @author 冯建辉
 *2019年3月12日16:01:47
 */
@Controller
@RequestMapping("/baseinfo")
@Scope("prototype")
public class BaseinfoIllnessController {
	
	/**
	 * 疾病模型层
	 */
	@Autowired
	private IllnessService illService;
	/**
	 * 冯建辉
	 * 疾病信息
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("listIllness")
	public String queryListIllness(HttpServletRequest request,Model model) {
		PageData pd = new PageData(request);
		//查询疾病
		List<Illness> illNessList = illService.querySmallIllness(pd);
		model.addAttribute("page", new  PageInfo<Illness>(illNessList));
		List<Illnessposition> illNessPosiTionList = illService.queryIllnessposition();
		model.addAttribute("illNessPosiTionList", illNessPosiTionList);
		model.addAttribute("pd",pd);
		return "illness/illness";
	}
	/**
	 * 冯建辉
	 * 查询疾病类别
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("listIllnessposition")
	public String queryListIllnessposition(HttpServletRequest request,Model model) {
		PageData pd = new PageData(request);
		//查询疾病类别
		List<Illnessposition> illNessPosiTionList = illService.queryBigIllness(pd);
		model.addAttribute("page", new  PageInfo<Illnessposition>(illNessPosiTionList));
		model.addAttribute("pd",pd);
		return "illness/illnessposition";
	}
	/**
	 * 疾病类别添加页面
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("addIllnesspositionPage")
	public String addIllnesspositionPage(HttpServletRequest request,Model model) {
		return "illness/illnessposition_add";
	}
	/**
	 * 验证疾病类别是否重复
	 * @param request
	 * @param model
	 * @param illtpName
	 * @return
	 */
	@RequestMapping("validatBigName")
	public @ResponseBody Boolean validatBigName(HttpServletRequest request,Model model,String illtpName) {
		int  count = illService.validatBigName(illtpName);
		if (count > 0) {
			return true;
		}
		return false;
	}
	
	
//	@RequestMapping("addIllPosition")
//	public @ResponseBody Boolean addIllPosition(HttpServletRequest request,Model model,) {
//		int  count = illService.validatBigName(illtpName);
//		if (count > 0) {
//			return true;
//		}
//		return false;
//	}
	
	
}
