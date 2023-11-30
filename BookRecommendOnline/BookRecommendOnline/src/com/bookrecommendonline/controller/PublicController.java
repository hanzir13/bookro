package com.bookrecommendonline.controller;

import java.io.File;
import java.io.IOException;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.ValCodeTool;

/**
 * 公共控制器（包含文件上传等功能）
 */
@Controller
@Scope("prototype")
@RequestMapping(value = {"user/public","admin/public"})
public class PublicController extends BaseController{
	
	/**
	 * 文件上传
	 * @return
	 */
	@RequestMapping("/upload")
	@ResponseBody
	public Object upload(@RequestParam("file") CommonsMultipartFile file){
		int success = 0;//上传失败
		//上传文件的名称
		String fileName = file.getOriginalFilename();
        System.out.println("fileName："+fileName);
        //定义上传文件的新名称，唯一
        String newFileName = "";
        try {
        	//上传文件的新名称
        	newFileName = System.currentTimeMillis()+"_"+CommonTool.getRandom()+
        			fileName.substring(fileName.lastIndexOf( "." ));
            System.out.println("newFileName："+newFileName);
        	//保存上传文件到文件上传路径
            file.transferTo(new File(CommonTool.appMediaPath,newFileName));
            success = 1;//上传成功
        } catch (IOException e) {
        	System.out.println("文件上传失败！");
            e.printStackTrace();
        }
		resultMap.put("newFileName",newFileName);//返回给页面的响应数据，上传文件的新名称
		resultMap.put("success",success);//返回给页面的响应数据，如果结果大于或者等于1是操作成功，反之操作失败
		return resultMap;
	}
	
	/**
	 * 验证码，ajax异步请求，返回json格式数据
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/doValCode")
	@ResponseBody
	public Object doValCode() throws Exception{
		new ValCodeTool().getValCode(request, response, CommonTool.session_valCode);
		return null;
	}
	
}