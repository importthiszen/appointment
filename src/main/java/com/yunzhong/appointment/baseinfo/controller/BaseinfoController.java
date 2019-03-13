package com.yunzhong.appointment.baseinfo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yunzhong.appointment.baseinfo.service.BigThingService;
import com.yunzhong.appointment.baseinfo.service.NoticeboardService;
import com.yunzhong.appointment.baseinfo.service.impl.BigThingServiceImpl;
import com.yunzhong.appointment.entity.Bigthing;
import com.yunzhong.appointment.entity.Noticeboard;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.ResultJson;
/**
 * 基础信息(公告,大事记)
 * @author 冯建辉
 *2019年3月1日16:14:36
 */
@Controller
@RequestMapping("/baseinfo")
@Scope("prototype")
public class BaseinfoController {

	
	/**
	 * 公告模型层
	 */
	@Autowired
	private NoticeboardService service;
	
	/**
	 * 公告模型层
	 */
	@Autowired
	private BigThingService bigService;
	/**冯建辉
	 * 跳转基本信息页面
	 * @param model
	 * 2019年3月2日10:46:47
	 * @return
	 */
	@RequestMapping("baseinfo")
	public String baseinfo() {
		return "system/system";
	}
	/**
	 * 查询最新公告
	 * @param request
	 * @param mm
	 * @return
	 */
	@RequestMapping("listNewAnnoucement")
	public String queryNewAnnoucement(HttpServletRequest request,Model mm) {
		PageData pd = new PageData(request);
		List<Noticeboard> annoList = service.queryNewAnnoucement(pd);
		mm.addAttribute("pageInfo", new  PageInfo<Noticeboard>(annoList));
		return "newestAnnoucement/listAnnouncement";
	}
	/**
	 * 验证公告名称是否重复
	 * @param noticeTitle
	 * @return
	 */
	@RequestMapping("validatAnnoName")
	public @ResponseBody boolean validatAnnoName(String noticeTitle) {
		int count = service.validatAnnoName(noticeTitle);
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * 验证大事件名称是否重复
	 * @param noticeTitle
	 * @return
	 */
	@RequestMapping("validatThingName")
	public @ResponseBody boolean validatThingName(String bigthingTitle) {
		int count = bigService.validatThingName(bigthingTitle);
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * 最新公告详细页面
	 * @param id
	 * @param mm
	 * @return
	 */
	@RequestMapping("pageAnnouncement")
	public String pageAnnouncement(String id,Model mm) {
		Noticeboard anno = service.queryOneById(id);
		mm.addAttribute("anno", anno);
		return "newestAnnoucement/pageAnnouncement";
	}
	/**
	 * 查询大事记
	 * @param request
	 * @param mm
	 * @return
	 */
	@RequestMapping("listBigthing")
	public String listBigthing(HttpServletRequest request,Model mm) {
		PageData pd = new PageData(request);
		List<Bigthing> bigThingList = bigService.queryBigThing(pd);
		mm.addAttribute("pd", pd);
		mm.addAttribute("pageInfo", new  PageInfo<Bigthing>(bigThingList));
		return "bigthing/listBigThing";
	}
	/**
	 * 公告查询页面
	 * @param request
	 * @param mm
	 * @return
	 */
	@RequestMapping("listAnnouncement")
	public String annoucementAddPage(HttpServletRequest request,Model mm) {
		PageData pd = new PageData(request);
		List<Noticeboard> annoList = service.queryAnnoucement(pd);
		mm.addAttribute("pd",pd);
		mm.addAttribute("pageInfo", new  PageInfo<Noticeboard>(annoList));
		return "newestAnnoucement/listAnno";
	}
	/**
	 * 添加公告页面
	 * @return
	 */
	@RequestMapping("addAnnouncementPage")
	public String addAnnouncementPage() {
		return "newestAnnoucement/anno_add";
	}
	/**
	 * 跳转添加大事件页面
	 * @return
	 */
	@RequestMapping("addBigThingPage")
	public String addBigThingPage() {
		return "bigthing/bigthing_add";
	}
	/**
	 * 跳转修改大事件页面
	 * @return
	 */
	@RequestMapping("editBigThingPage")
	public String editBigThingPage(String id,Model mm) {
		//根据主键查询大事记
		Bigthing bg= bigService.queryOneById(id);
		mm.addAttribute("bg", bg);
		return "bigthing/bigthing_edit";
	}
	/**
	 * 跳转修改公告页面
	 * @param id
	 * @param mm
	 * @return
	 */
	@RequestMapping("editAnnouncementPage")
	public String editAnnouncementPage(String id,Model mm) {
		//根据id查询公告
		Noticeboard anno = service.queryOneById(id);
		mm.addAttribute("anno", anno);
		return "newestAnnoucement/anno_edit";
	}
	/**
	 * 添加大事件
	 * @param bg
	 * @return
	 */
	@RequestMapping("addBigThing")
	public @ResponseBody ResultJson addBigThing(Bigthing bg) {
		ResultJson r = new ResultJson();
		int count = bigService.add(bg);
		if (count > 0) {
			r.setSuccess(true);
		} else {
			r.setSuccess(false);	
		}
		return r;
	}
	/**
	 * 修改大事件
	 * @param bg
	 * @return
	 */
	@RequestMapping("editBigThing")
	public @ResponseBody ResultJson editBigThing(Bigthing bg) {
		ResultJson r = new ResultJson();
		int count = bigService.edit(bg);
		if (count > 0) {
			r.setSuccess(true);
		} else {
			r.setSuccess(false);	
		}
		return r;
	}
	/**
	 * 增加公告
	 * @param anno
	 * @return
	 */
	@RequestMapping("addAnnouncement")
	public @ResponseBody ResultJson addAnnouncement(Noticeboard anno) {
		ResultJson r = new ResultJson();
		int count = service.add(anno);
		if (count > 0) {
			r.setSuccess(true);
		} else {
			r.setSuccess(false);
		}
		return r;
	}
	/**
	 * 增加公告
	 * @param anno
	 * @return
	 */
	@RequestMapping("editAnnouncement")
	public @ResponseBody ResultJson editAnnouncement(Noticeboard anno) {
		ResultJson r = new ResultJson();
		int count = service.edit(anno);
		if (count > 0) {
			r.setSuccess(true);
		} else {
			r.setSuccess(false);
		}
		return r;
	}
	/**
	 * 删除
	 * @param ids
	 * @return
	 */
	@RequestMapping("del")
	public @ResponseBody boolean del(String ids) {
		int count = service.del(ids);
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}
	/**
	 * 删除大事记
	 * @param ids
	 * @return
	 */
	@RequestMapping("delThing")
	public @ResponseBody boolean delThing(String ids) {
		int count = bigService.delThing(ids);
		if (count > 0) {
			return true;
		} else {
			return false;
		}
	}
}
