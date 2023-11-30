package com.bookrecommendonline.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.service.UserService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.DateTool;

/**
 * 前台用户注册控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = {"/"})
public class UserRegisterController extends BaseController{
	
	@Autowired
	private UserService userService;//注入用户业务类
	
	/**
	 * 跳转到用户注册页面
	 * @return
	 */
	@RequestMapping("/register")
	public String register(){
		return "user/register";
	}
	
	/**
	 * 注册
	 * @param userEntity 用户注册信息
	 * @param valcode 验证码
	 * @return
	 */
	@RequestMapping("/doRegister")
	@ResponseBody
	public Object doRegister(UserEntity userEntity, String valcode){
		int success = 0;
		String message = "";
		String url = "";
		//验证码
		if(valcode!=null && !valcode.equals("")){
			valcode = valcode.toLowerCase();//转小写
			//获取session中的验证码
			String trueValcode = (String) request.getSession().getAttribute(CommonTool.session_valCode);
			trueValcode = trueValcode.toLowerCase();//转小写
			if(valcode.equals(trueValcode)){//如果验证码正确
				//查询参数：用户名
				params.add(new Object[]{"username","=",userEntity.getUsername()});
				UserEntity selectUser = userService.findFirst(params);
				if(selectUser!=null){
					success = -1;//用户名已存在
					message = "注册失败！用户名已存在！";
				}else{
					userEntity.setHeader(CommonTool.defaultHeader);//用户默认头像
					userEntity.setState(1);//用户状态：正常
					userEntity.setCreatetime(DateTool.getCurrentDate());//注册时间
					success = userService.insertSelective(userEntity);//添加
					url = "login";
				}
			}else{
				success = 0;
				message = "验证码不正确！";
			}
		}else{
			success = 0;
			message = "验证码不正确！";
		}
		resultMap.put("success",success);//返回给页面的响应数据，如果结果大于或者等于1是操作成功，反之操作失败
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("url",url);
		resultMap.put("message",message);
		return resultMap;
	}

}