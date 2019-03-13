package com.yunzhong.appointment.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import com.yunzhong.appointment.entity.Noticeboard;
import com.yunzhong.appointment.util.PageData;

public interface NoticeboardMapper {
    int deleteByPrimaryKey(String noticeId);

    int insert(Noticeboard record);

    int insertSelective(Noticeboard record);

    Noticeboard selectByPrimaryKey(String noticeId);

    int updateByPrimaryKeySelective(Noticeboard record);

    int updateByPrimaryKey(Noticeboard record);
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
	 * 查询标题名相同的条数
	 * @param noticeTitle
	 * @return
	 */
	@Select("select count(*) from noticeboard where noticeboard.notice_title=#{0}")
	int validatAnnoName(String noticeTitle);
}