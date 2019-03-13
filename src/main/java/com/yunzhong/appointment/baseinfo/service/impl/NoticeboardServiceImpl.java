package com.yunzhong.appointment.baseinfo.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.yunzhong.appointment.baseinfo.service.NoticeboardService;
import com.yunzhong.appointment.entity.Noticeboard;
import com.yunzhong.appointment.mapper.NoticeboardMapper;
import com.yunzhong.appointment.util.PageData;
@Service
public class NoticeboardServiceImpl implements NoticeboardService {
	/**
	 * 公告mapper
	 */
	@Autowired
	private NoticeboardMapper mapper;
	/**
	 * 查询最新公告
	 */
	@Override
	public List<Noticeboard> queryNewAnnoucement(PageData pd) {
		pd.setPageData2(pd);
		return mapper.queryNewAnnoucement(pd);
	}
	/**
	 * 查询公告
	 */
	@Override
	public List<Noticeboard> queryAnnoucement(PageData pd) {
		pd.setPageData(pd);
		List<Noticeboard> annoList = mapper.queryAnnoucement(pd);
		//如果标题太长截取19个汉字加三个点(...)
		if (null != annoList && !annoList.isEmpty()) {
			for (Noticeboard noticeboard : annoList) {
				String notiTitle = noticeboard.getNoticeTitle();
				if (null !=notiTitle && notiTitle.length() > 20) {
					notiTitle = notiTitle.substring(0, 19)+"...";
					noticeboard.setNoticeTitle(notiTitle);
				}
			}
		}
		return annoList;
	}
	/**
	 * 增加公告
	 */
	@Override
	@Transactional()
	public int add(Noticeboard anno) {
		anno.setNoticeId(UUID.randomUUID().toString());
		return mapper.insertSelective(anno);
	}
	/**
	 * 根据id查询公告
	 */
	@Override
	public Noticeboard queryOneById(String id) {
		// TODO Auto-generated method stub
		return mapper.selectByPrimaryKey(id);
	}
	/**
	 * 删除
	 */
	@Override
	@Transactional()
	public int del(String ids) {
		int count = 0;
		String[] str = ids.split(",");
		for (String id : str) {
			count += mapper.deleteByPrimaryKey(id);
		}
		return count;
	}
	/**
	 * 修改公告
	 */
	@Override
	@Transactional()
	public int edit(Noticeboard anno) {
		// TODO Auto-generated method stub
		return mapper.updateByPrimaryKeySelective(anno);
	}
	/**
	 * 验证公告名称是否重复
	 */
	@Override
	public int validatAnnoName(String noticeTitle) {
		return mapper.validatAnnoName(noticeTitle);
	}

}
