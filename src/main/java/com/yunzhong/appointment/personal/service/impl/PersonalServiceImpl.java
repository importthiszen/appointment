package com.yunzhong.appointment.personal.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.yunzhong.appointment.config.Const;
import com.yunzhong.appointment.entity.Appointmentorder;
import com.yunzhong.appointment.entity.Patient;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Province;
import com.yunzhong.appointment.entity.Scheduling;
import com.yunzhong.appointment.entity.SysUser;
import com.yunzhong.appointment.mapper.AppointmentorderMapper;
import com.yunzhong.appointment.mapper.PatientMapper;
import com.yunzhong.appointment.mapper.PersonMapper;
import com.yunzhong.appointment.mapper.ProvinceMapper;
import com.yunzhong.appointment.mapper.SchedulingMapper;
import com.yunzhong.appointment.mapper.SysRoleMapper;
import com.yunzhong.appointment.mapper.SysUserMapper;
import com.yunzhong.appointment.mapper.SysUserRoleMapper;
import com.yunzhong.appointment.personal.service.PersonalService;
import com.yunzhong.appointment.util.DateAmOrPm;
import com.yunzhong.appointment.util.FileUtils;
import com.yunzhong.appointment.util.PageData;
import com.yunzhong.appointment.util.base64ToMultipart;

@Service
public class PersonalServiceImpl implements PersonalService {
    /**
     * 患者接口
     */
	@Autowired
	private PatientMapper ptMapper;
	/**
	 * 省接口
	 */
	@Autowired
	private ProvinceMapper proMapper;
	/**
	 * 用户接口
	 */
	@Autowired
	private SysUserMapper userMapper;
	/**
	 * 订单接口
	 */
	@Autowired
	private AppointmentorderMapper apMapper;
    /**
     * 角色接口
     */
	@Autowired
	private SysRoleMapper RoleMapper;
	/**
	 * 人员接口
	 */
	@Autowired
	private PersonMapper psMapper;
	/**
	 * 排班接口
	 */
	@Autowired
	private SchedulingMapper sdMapper;
	/**
	 * 根据用户名查询患者信息
	 */
	@Override
	public Patient queryPatientByuserName(String userName) {
		return ptMapper.queryPatientByuserName(userName);
	}
	/**
	 * 查询省
	 */
	@Override
	public List<Province> queryProvince() {
		return proMapper.queryAll();
	}
	/**
	 * 修改患者个人信息
	 */
	@Transactional
	@Override
	public int editPatient(Patient pt) {
		return ptMapper.updateByPrimaryKeySelective(pt);
	}
	/**
	 * 上传图片
	 */
	@Transactional
	@Override
	public int addimg(String image,String id,String userName) {
		int tiao = 0;
		
		//判断上传头像的用户类型
		 SysUser user = userMapper.getUSerByUserName(userName);
		//根据用户主键查询角色名
		 Set<String> set = RoleMapper.listRoleNamesByUserId(user.getUserId());
		if(set.contains("patient")) { //如果角色包含患者 则给患者上传头像
			//base64 转 Multipart文件
			MultipartFile Multipart = base64ToMultipart.base64ToMultipart(image);
			//保存新头像
			String fileName = FileUtils.saveFile(Multipart);
			Patient pt = ptMapper.selectByPrimaryKey(id);
			FileUtils.deleteFileByUrl(pt.getPatientPic());
			//更新数据库
			tiao = ptMapper.updateImgUrl(fileName,id);	
		}else{ //其他人员上传头像
			//base64 转 Multipart文件
			MultipartFile Multipart = base64ToMultipart.base64ToMultipart(image);
			//保存新头像
			String fileName = FileUtils.saveFile(Multipart);
			//删除原头像
			Person  ps = psMapper.selectByuserId(user.getUserId());
			FileUtils.deleteFileByUrl(ps.getPpPic());
			//更新数据库
			tiao = psMapper.updateImgUrl(fileName,user.getUserId());
		}
		return tiao;
		
	}
	/**
	 * 设置密码
	 */
	@Transactional
	@Override
	public int editpass(Patient pt,String pass) {
		 //根据 tel 查询用户
		 String userName = pt.getPatientTel();
		 SysUser sysuser = userMapper.getUserByName(userName);
		 String oldpass = sysuser.getUserPass();
		 //加密密码
		  pass = new SimpleHash("SHA-1", pass, pass+Const.SALT).toString();
		 //比较密码是否一致
		 if (pass.equals(oldpass) ) { //如果页面的密码和原密码相同
			 String newpass = new SimpleHash("SHA-1", pt.getUserPass(), pt.getUserPass()+Const.SALT).toString();
			 return userMapper.recoverpass(userName, newpass);
		} else {
             return -1;
			
		}
		 
	}
	/**
	 * 查询患者订单
	 */
	@Override
	public List<Appointmentorder> querylistOrder(PageData pd,String order_state) {
		//根据userName(手机号)查询患者
		Patient pt = ptMapper.queryPatientByuserName(pd.get("userName").toString());
		String ptId = pt.getPatientId();
		pd.put("patientId", ptId);
		pd.setPageData(pd);//初始化分页参数
			if (order_state != null && order_state.equals("N")) { //查询未付款订单	
				List<Appointmentorder> aList = new ArrayList<>();
				pd.put("orderState", order_state);
				List<Appointmentorder> list = apMapper.selectByPatientId(pd);
				for (Appointmentorder appointmentorder : list) {
					String date =DateAmOrPm.AmOrPm(appointmentorder.getAppointmentDate()); 
					appointmentorder.setAmPm(date);
					aList.add(appointmentorder);
				}
				return aList;
			} else { //查询所有订单
				List<Appointmentorder> aList = new ArrayList<>();
				List<Appointmentorder> list =  apMapper.selectByPatientId(pd);
				for (Appointmentorder appointmentorder : list) {
					String date =DateAmOrPm.AmOrPm(appointmentorder.getAppointmentDate()); 
					appointmentorder.setAmPm(date);
					aList.add(appointmentorder);
				}
				return aList;
			}
		}
	/**
	 * 根据订单id取消订单
	 */
	@Transactional
	@Override
	public int cancelOrder(String id) {
		int tiao ;
		//获得挂号费 
		Appointmentorder ap = apMapper.selectByPrimaryKey(id);
		Double Registeredfe = ap.getRegisteredfee(); //挂号费
		//此处假设退款完毕
		//恢复一次可预约次数
		String stan = ap.getStandby();
		String[] split = stan.split(",");
		String sdlid = split[0];
		String count = split[1];
		sdMapper.RecoverytimesByIdOrCount(sdlid,count);
		//删除订单
		tiao = apMapper.deleteByPrimaryKey(id);
		return tiao;
	}
	/**
	 * 根据用户名查询人员
	 */
	@Override
	public Person queryPersonByuserName(String userName) {
		SysUser user = userMapper.getUserByName(userName);	
		return psMapper.selectByuserId(user.getUserId());
	}
	}

		 
	
	
	
  

