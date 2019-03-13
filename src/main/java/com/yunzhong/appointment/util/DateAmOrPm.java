package com.yunzhong.appointment.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateAmOrPm {
	public static String AmOrPm(Date args) {
		
		SimpleDateFormat df = new SimpleDateFormat("HH");
		SimpleDateFormat df2 = new SimpleDateFormat("HH:mm");
		String str=df.format(args);
		String str2=df2.format(args);
		int a=Integer.parseInt(str);
		if (a>=0&&a<=6) {
		    return"凌晨  "+str2;
		}
		else if (a>6&&a<=12) {
		    return"上午  "+str2;
		}
		else if (a>12&&a<=13) {
		    return"中午  "+str2;
		}
		else if (a>13&&a<=18) {
			return"下午  "+str2;
		}else  {
			return"晚上  "+str2;
		}
		}
}
