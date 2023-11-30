package com.bookrecommendonline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.entity.UserlabelEntity;
import com.bookrecommendonline.service.UserService;
import com.bookrecommendonline.service.UserlabelService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.DateTool;

/**
 * 前台用户登录控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = {"/"})
public class UserLoginController extends BaseController{

	@Autowired
	private UserService userService;//注入用户业务类
	@Autowired
	private UserlabelService userlabelService;//注入用户喜好标签业务类
	
	/**
	 * 跳转到用户登录页面
	 * @return
	 */
	@RequestMapping("/login")
	public String login(){
		return "user/login";
	}
	
	/**
	 * 登录
	 * @param userEntity 用户登录信息
	 * @param valcode 验证码
	 * @return
	 */
	@RequestMapping("/doLogin")
	@ResponseBody
	public Object doLogin(UserEntity userEntity, String valcode){
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
				//查询参数：用户名、密码
				params.add(new Object[]{"username","=",userEntity.getUsername()});
				params.add(new Object[]{"password","=",userEntity.getPassword()});
				List<UserEntity> userList = userService.find(params);
				if(userList==null || userList.size()==0){//用户名或密码错误
					success = 0;
					message = "登录失败！用户名或密码错误！";
				}else{
					userEntity = userList.get(0);
					if(userEntity.getState()==1){//判断用户状态是否正常，1：正常，2：锁定
						success = 1;
						//查询登录用户的喜好标签
						params.clear();
						params.add(new Object[]{"userid","=",userList.get(0).getId()});
						List<UserlabelEntity> userlabelList = userlabelService.find(params);
						//登录用户没有喜好标签
						if(userlabelList==null || userlabelList.size()==0){
							resultMap.put("userid",userList.get(0).getId());
						}else{//登录成功
							//登录时间
							userEntity.setLastlogintime(DateTool.getCurrentDate());
							success = userService.updateByPrimaryKeySelective(userEntity);
							url = "/";
							//将用户信息保存在session中
							request.getSession().setAttribute(
									CommonTool.session_user,userEntity);
						}
					}else{
						success = 0;
						message = "登录失败！用户状态异常！";
					}
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
	
	/**
	 * 退出登录
	 * @return
	 */
	@RequestMapping("/quit")
	public String quit(){
		//销毁登录用户session
		request.getSession().setAttribute(CommonTool.session_user, null);
		return "redirect:/";
	}
	
}