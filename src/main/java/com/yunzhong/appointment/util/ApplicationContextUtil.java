package com.yunzhong.appointment.util;

import java.util.Locale;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;
/**
 * 获取bean工具类 用于在线程中获取bean
 * @author 于占峰
 * 2019年3月13日09:46:45
 *
 */
@Component
public class ApplicationContextUtil implements ApplicationContextAware {  
    private static ApplicationContext applicationContext;  

    public static ApplicationContext getApplicationContext() {  
        return applicationContext;  
    }  

    public void setApplicationContext(ApplicationContext applicationContext) {  
        ApplicationContextUtil.applicationContext = applicationContext;  
    }  

    public static Object getBean(String beanName) {  
        return applicationContext.getBean(beanName);  
    }  
} 



