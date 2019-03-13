package com.yunzhong.appointment.baseinfo.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.yunzhong.appointment.entity.Noticeboard;
import com.yunzhong.appointment.util.PageData;

public interface NoticeboardService {
	/**
	 * 查询最新公告
	 * @param pd 
	 * @return
	 */
	List<Noticeboard> queryNewAnnoucement(PageData pd);
	/**
	 * 查询公告
	 * @param pd 
	 * @return
	 */
	List<Noticeboard> queryAnnoucement(PageData pd);
	/**
	 * 增加公告
	 * @param anno
	 * @return
	 */
	int add(Noticeboard anno);
	/**
	 * 根据id查询公告
	 * @param id
	 * @return
	 */
	Noticeboard queryOneById(String id);
	/**
	 * 删除
	 * @param ids
	 * @return
	 */
	int del(String ids);
	/**
	 * 修改公告
	 * @param anno
	 * @return
	 */
	int edit(Noticeboard anno);
	/**
	 * 验证公告名称是否重复
	 * @param noticeTitle
	 * @return
	 */
	int validatAnnoName(String noticeTitle);

}
