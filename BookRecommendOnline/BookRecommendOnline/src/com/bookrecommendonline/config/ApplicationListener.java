package com.bookrecommendonline.config;

import java.io.File;

import javax.servlet.ServletContext;

import org.springframework.stereotype.Component;
import org.springframework.web.context.ServletContextAware;

import com.bookrecommendonline.tool.CommonTool;

/**
 * applicaiton监听器，当应用程序启动的时候，会执行该监听器
 * 主要将一些固定值、文件上传路径、文件访问url保存在application上下文中便于在java代码和页面中获取
 */
@Component("applicationListener")
public class ApplicationListener implements ServletContextAware{

	@Override
	public void setServletContext(ServletContext arg0) {
		//项目根路径，绝对路径
		String appRealPath = arg0.getRealPath("");
		//设置文件上传路径
		CommonTool.appMediaPath = appRealPath.substring(0,
				appRealPath.lastIndexOf("\\BookRecommendOnline\\")+1)
				+ CommonTool.appMediaUrl;
		//创建文件上传路径
		File mediaFile = new File(CommonTool.appMediaPath);
        if(!mediaFile.exists())
        	mediaFile.mkdirs();//如果不存在该路径，那么新建
        //上传文件保存路径
        System.out.println(CommonTool.appMediaPath);
		//将访问图片url保存在application上下文中，便于在页面获取
		arg0.setAttribute("appMediaUrl",CommonTool.appMediaUrl);
	}

}
