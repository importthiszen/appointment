package com.yunzhong.appointment.illness.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yunzhong.appointment.entity.Appointmentorder;
import com.yunzhong.appointment.entity.Illness;
import com.yunzhong.appointment.entity.Patient;
import com.yunzhong.appointment.entity.Person;
import com.yunzhong.appointment.entity.Scheduling;
import com.yunzhong.appointment.illness.service.ApptService;
import com.yunzhong.appointment.mapper.AppointmentorderMapper;
import com.yunzhong.appointment.mapper.ConstMapper;
import com.yunzhong.appointment.mapper.IllnessMapper;
import com.yunzhong.appointment.mapper.PatientMapper;
import com.yunzhong.appointment.mapper.PersonMapper;
import com.yunzhong.appointment.mapper.SchedulingMapper;
import com.yunzhong.appointment.timingtask.MyTimerTask;
import com.yunzhong.appointment.util.DateUtil;
import com.yunzhong.appointment.util.PageData;

@Service("ApptServiceImpl")
public class ApptServiceImpl implements ApptService {
	/**
	 * 排班接口
	 */
	@Autowired
	private SchedulingMapper scMapper;
	/**
	 * 人员接口
	 */
	@Autowired
	private PersonMapper ppMapper;
	/**
	 * 常量接口
	 */
	@Autowired
	private ConstMapper cnMapper;
	/**
	 * 患者接口
	 */
	@Autowired
	private PatientMapper ptMapper;
	/**
	 * 预约订单接口
	 */
	@Autowired
	private AppointmentorderMapper apMapper;
	/**
	 * 疾病借口
	 */
	@Autowired
	private IllnessMapper illMapper;

	/**
	 * 根据医生主键查询未来九天内的排班情况
	 */
	@Override
	public List<Scheduling> queryDoctorSchedulingById(String ppId) {
		// 当前时间如果超过了 下午16:00 就查询明天起 9天内的排班情况
		boolean bl = IsTheCurrentTimeGreaterThan("16:00");
		if (bl) { // 如果当前时间超过16:00
			return scMapper.selectNineDayByPpid("curdate()", ppId);
		} else {
			return scMapper.selectNineDayByPpid("DATE_SUB(curdate(),INTERVAL -1 DAY)", ppId);
		}
	}

	/**
	 * 根据主键查询医生
	 */
	@Override
	public Person selectDoctorByPpid(String ppId) {
		return ppMapper.selectByPrimaryKey(ppId);
	}

	/**
	 * 查询基础费用
	 */
	@Override
	public String quryBassfee() {
		return cnMapper.getBaseFee();
	}

	/**
	 * 添加预约订单 于占峰
	 * 
	 * @param pd
	 * @return int 2019年3月8日11:55:28
	 */
	@Transactional
	@Override
	public int addAppointmentorder(PageData pd) {
		int tiao = 0;
		String ppId = pd.getString("ppId"); // 医生主键
		String userName = pd.getString("userName"); // 登录用户名
		Person doctor = ppMapper.selectByPrimaryKey(ppId);// 医生
		Patient pt = ptMapper.queryPatientByuserName(userName);// 患者
		String free = pd.getString("free"); // 挂号服务费
		String da = pd.getString("date"); // 页面预约时间--String
		Date date = DateUtil.fomatDateTime(da); // 转换后的预约时间
		String count = pd.getString("count"); // 排班时段时段
		String apId = pd.getString("apId"); // 排班id
		String type = pd.getString("type");
		String illId = pd.getString("illId"); // 疾病id
		// 判断是否满足预约条件
		int cn = appointmentCount(doctor, pt, date, illId);
		if (cn == 0) {
			Appointmentorder ap = new Appointmentorder();
			ap.setAppointmentId(UUID.randomUUID().toString());
			ap.setAppointmentTime(new Date());
			ap.setOrderState("N");
			ap.setPatientId(pt.getPatientId());
			ap.setPatientName(pt.getPatientName());
			ap.setDoctorId(ppId);
			ap.setDoctorName(doctor.getPpName());
			ap.setProfessionalId(doctor.getProfessionalId());
			ap.setProfessionalName(doctor.getProfessionalName());
			if (type.equals("illness")) {
				Illness ill = illMapper.selectByPrimaryKey(illId);// 会根据疾病id 查询疾病
				ap.setIllnessId(ill.getIllId());// 预约疾病
				ap.setIllnessName(ill.getIllName());// 疾病名称
			} else {
				ap.setDepartmentId(doctor.getDepartmentId()); // 预约科室
				ap.setDepartmentName(doctor.getDepartmentName());
			}
			ap.setPaytypeOrderid(crateOderNo()); // 订单号
			ap.setRegisteredfee(Double.valueOf(free));
			ap.setAppointmentDate(date);
			ap.setStandby(apId + "," + count); // 存入 排班主键 和 时间段 用于取消订单
			tiao = apMapper.insertSelective(ap);
			// 减少一次预约名额
			if (tiao > 0) { // 预约订单成功 减少一次预约名额
				scMapper.updateAppointmentorderCountByIdAndCount(apId, count);
				Timer timer = new Timer();
				MyTimerTask timertask = new MyTimerTask(ap.getAppointmentId());
				timer.schedule(timertask, 30000);
			} else {
				tiao = 0;
			}
		} else {
			tiao = cn;
		}
		return tiao;
	}

	private int appointmentCount(Person doctor, Patient pt, Date date, String illId) {
		/**
		 * 在同一就诊日、同一科室只能预约1次； -1 在同一就诊日的预约总量不可超过2次； -2 在七日内的预约总量不可超过3次；-3
		 * 在三个月内预约总量不可超过5次。 -4 3个月内累计爽约达到3次也将无法预约 -5
		 */
		int ge = 0;
		ge = apMapper.countAppointmentorderByDayAndsetDoctorId(date, doctor.getDepartmentId(), pt.getPatientId());
		if (ge > 0) {
			return -1;
		} else {
			ge = apMapper.countAppointmentorderByDayAndillId(date, pt.getPatientId(), illId);
			if (ge > 0) {
				return -1;
			} else {
				ge = apMapper.countAppointmentorderByDayAndPatientId(date, pt.getPatientId());
				if (ge > 2) {
					return -2;
				} else {
					ge = apMapper.CountAppointmentorderSevenDayByPatientId(pt.getPatientId());
					if (ge > 3) {
						return -3;
					} else {
						ge = apMapper.countAppointmentorderThreemonthsByPatientId(pt.getPatientId());
						if (ge > 5) {
							return -4;
						} else {
							ge = apMapper.CountAppointmentorderThreemonthsBreakByPatientId(pt.getPatientId());
							if (ge > 3) {
								return -5;
							} else {
								return ge;
							}
						}
					}
				}
			}
		}

	}

	/**
	 * 生成订单号
	 * 
	 * @return 2019年3月10日00:07:40 于占峰
	 */
	private String crateOderNo() {
		// 取出当天内的最新订单号
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String dateStr = sdf.format(new Date());
		String oldNo = apMapper.selectOderNoToday(dateStr + "%");
		// 20170915 0001 6749 YH
		if (oldNo == null) {// 如果是当天的第一个订单就创建一个
			int ran = (int) (Math.random() * 10000);
			oldNo = dateStr + "0001" + ran + "YH";
		} else {
			oldNo = oldNo.substring(8, 12); // 截取订单次数
			int count = Integer.parseInt(oldNo) + 1;// 转整加1
			String str = (count + 10000 + "").substring(1);
			int ran = (int) (Math.random() * 10000);
			oldNo = dateStr + str + ran + "YH";
		}
		return oldNo;
	}

	/**
	 * 传入一个的时分 判断当前时间是否大于当天的这个时间
	 * 
	 * @param mmhh
	 *            16:00
	 * @return boolean 2019年3月10日00:02:47 于占峰
	 */
	private boolean IsTheCurrentTimeGreaterThan(String mmhh) {
		SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		SimpleDateFormat format3 = new SimpleDateFormat("yyyy-MM-dd");
		Date ten = null;
		Date now = null;
		now = new Date();
		String d3 = format3.format(now);
		try {
			ten = format2.parse(d3 + " " + mmhh);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		boolean bl = now.before(ten);
		return bl;
	}

	/**
	 * 自动取消未付款订单
	 */
	@Override
	public int TimeToDeleteOrder(String apId) {
		int tiao = 0;
		// 根据主键查询订单
		Appointmentorder ap = apMapper.selectByPrimaryKey(apId);
//		Date AppointmentTime = ap.getAppointmentTime();// 下单时间
//		long currentTime = System.currentTimeMillis();
//		currentTime -= 30 * 60 * 1000;
//		Date when = new Date(currentTime);
		if (ap.getOrderState().equals("N")) { // 如果订单时间超过30分钟且未付款
			Double Registeredfe = ap.getRegisteredfee(); // 挂号费
			// 此处假设退款完毕
			// 恢复一次可预约次数
			String stan = ap.getStandby();
			String[] split = stan.split(",");
			String sdlid = split[0];
			String count = split[1];
			scMapper.RecoverytimesByIdOrCount(sdlid, count);
			// 删除订单
			tiao = apMapper.deleteByPrimaryKey(apId);
		} else {
			return tiao;
		}
		return tiao;

	}
}
