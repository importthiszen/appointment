package com.yunzhong.appointment.baseinfo.service;

import java.util.List;

import com.yunzhong.appointment.entity.Bigthing;
import com.yunzhong.appointment.util.PageData;

public interface BigThingService {
	/**
	 * 查询大事记
	 * @param pd
	 * @return
	 */
	List<Bigthing> queryBigThing(PageData pd);
	/**
	 * 添加大事件
	 * @param bg
	 * @return
	 */
	int add(Bigthing bg);
	/**
	 * 根据主键查询大事记
	 * @param id
	 * @return
	 */
	Bigthing queryOneById(String id);
	/**
	 * 修改大事件
	 * @param bg
	 * @return
	 */
	int edit(Bigthing bg);
	/**
	 * 验证大事件名称是否重复
	 * @param bigthingTitle
	 * @return
	 */
	int validatThingName(String bigthingTitle);
	/**
	 * 删除大事记
	 * @param ids
	 * @return
	 */
	int delThing(String ids);

}
