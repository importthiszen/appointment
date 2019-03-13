package com.yunzhong.appointment.util;

import java.io.IOException;

import org.springframework.web.multipart.MultipartFile;

import sun.misc.BASE64Decoder;

/**
 * base 64 转 MultipartFile 文件 工具类
 * @author 峰
 *
 */
public class base64ToMultipart {
	
	public static MultipartFile base64ToMultipart(String base64) {
	    try {
	        String[] baseStrs = base64.split(",");

	        BASE64Decoder decoder = new BASE64Decoder();
	        byte[] b = new byte[0];
	        b = decoder.decodeBuffer(baseStrs[1]);

	        for(int i = 0; i < b.length; ++i) {
	            if (b[i] < 0) {
	                b[i] += 256;
	            }
	        }

	        return new BASE64DecodedMultipartFile(b, baseStrs[0]);
	    } catch (IOException e) {
	        e.printStackTrace();
	        return null;
	    }
	}
}

