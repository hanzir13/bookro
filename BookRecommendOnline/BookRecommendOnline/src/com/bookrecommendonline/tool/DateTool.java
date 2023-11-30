package com.bookrecommendonline.tool;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 日期时间相关
 */
public abstract class DateTool {

	//格式化时间，年月日
	public static final String pattern_ymd = "yyyy-MM-dd";
	
	//格式化时间，年月日 时分秒
	public static final String pattern_ymd_hms = "yyyy-MM-dd HH:mm:ss";
	
	//格式化时间，年月日 时分秒 毫秒
	public static final String pattern_ymd_hms_sss = "yyyy_MM_dd_HH_mm_ss_sss";

	/**
	 * 获取当前时间
	 * @param pattern
	 * @return
	 */
	public static String getCurrentDate(String pattern) {
        Date date = new Date();
        date.setTime(System.currentTimeMillis());
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(date);
    }
	
	/**
	 * 获取当前时间，年月日 时分秒
	 * @return
	 */
	public static String getCurrentDate() {
        return getCurrentDate(pattern_ymd_hms);
    }

}
