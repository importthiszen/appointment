package com.yunzhong.appointment.baseinfo.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yunzhong.appointment.baseinfo.service.BigThingService;
import com.yunzhong.appointment.entity.Bigthing;
import com.yunzhong.appointment.mapper.BigthingMapper;
import com.yunzhong.appointment.util.PageData;
@Service
public class BigThingServiceImpl implements BigThingService {

	@Autowired
	private BigthingMapper mapper;
	/**
	 * 查询大事记
	 */
	@Override
	public List<Bigthing> queryBigThing(PageData pd) {
		pd.setPageData(pd);
		List<Bigthing> bigThingList = mapper.query(pd);
		//如果标题太长截取15个汉字加三个点(...)
		if (null != bigThingList && !bigThingList.isEmpty()) {
			for (Bigthing bigthing : bigThingList) {
				String bigthingTitle = bigthing.getBigthingTitle();
				if (bigthingTitle.length() > 15) {
					bigthingTitle = bigthingTitle.substring(0, 15)+"...";
					bigthing.setBigthingTitle(bigthingTitle);
				}
			}
		}
		return bigThingList;
	}
	/**
	 * 添加大事件
	 */
	@Override
	@Transactional()
	public int add(Bigthing bg) {
		bg.setBigthingId(UUID.randomUUID().toString());
		return mapper.insertSelective(bg);
	}
	/**
	 * 根据主键查询大事记
	 */
	@Override
	public Bigthing queryOneById(String id) {
		return mapper.selectByPrimaryKey(id);
	}
	/**
	 * 修改大事件
	 */
	@Override
	public int edit(Bigthing bg) {
		return mapper.updateByPrimaryKeySelective(bg);
	}
	/**
	 * 验证大事件名称是否重复
	 */
	@Override
	public int validatThingName(String bigthingTitle) {
		// TODO Auto-generated method stub
		return mapper.validatThingName(bigthingTitle);
	}
	/**
	 * 删除大事记
	 */
	@Override
	@Transactional()
	public int delThing(String ids) {
		int count = 0;
		String[] str = ids.split(",");
		for (String id : str) {
			count += mapper.deleteByPrimaryKey(id);
		}
		return count;
	}

}
