package com.bookrecommendonline.tool;

/**
 * 常用工具类
 */
public class CommonTool {
	
	/**
	 * session用户
	 */
	public static final String session_user = "session_user";
	
	/**
	 * session管理员
	 */
	public static final String session_admin = "session_admin";
	
	/**
	 * 分页大小
	 */
	public static final String pageSize = "12";
	
	/**
	 * 重置用户密码
	 */
	public static final String defaultPassword = "123456";
	
	/**
	 * 用户默认头像
	 */
	public static final String defaultHeader = "header.jpeg";
	
	/**
	 * 上传文件访问url
	 */
	public static final String appMediaUrl = "BookRecommendOnlineMedia/media";
	
	/**
	 * 上传文件保存路径，在app监听器中动态获取
	 */
	public static String appMediaPath = "";
	
	/**
	 * session验证码
	 */
	public static final String session_valCode = "session_valCode";

	/**
	 * 随机产生一个六位随机数，用于将上传的文件重命名
	 * @return
	 */
	public static int getRandom(){
		return (int)((Math.random()*9+1)*100000);
	}
	
}
