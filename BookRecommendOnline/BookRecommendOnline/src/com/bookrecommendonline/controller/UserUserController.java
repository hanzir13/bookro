package com.bookrecommendonline.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.service.UserService;
import com.bookrecommendonline.tool.CommonTool;

/**
 * 前台用户控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "user/user")
public class UserUserController extends BaseController{

	@Autowired
	private UserService userService;//注入用户业务类
	
	/**
	 * 个人中心
	 * @return
	 */
	@RequestMapping("/detail")
	public String detail(){
		UserEntity cUser = getCurrentUser();
		request.setAttribute("user", userService.selectByPrimaryKey(cUser.getId()));
		return "user/user/detail";
	}
	
	/**
	 * 跳转到用户编辑页面
	 * @return
	 */
	@RequestMapping("/update")
	public String update(){
		UserEntity cUser = getCurrentUser();
		request.setAttribute("user", userService.selectByPrimaryKey(cUser.getId()));
		return "user/user/update";
	}
	
	/**
	 * 更新
	 * @return
	 */
	@RequestMapping("/doUpdate")
	@ResponseBody
	public Object doUpdate(UserEntity userEntity){
		//查询
		UserEntity cUser = userService.selectByPrimaryKey(getCurrentUser().getId());
		cUser.setHeader(userEntity.getHeader());
		cUser.setPhone(userEntity.getPhone());
		cUser.setEmail(userEntity.getEmail());
		cUser.setGender(userEntity.getGender());
		cUser.setAge(userEntity.getAge());
		int success = userService.updateByPrimaryKey(cUser);//更新
		if(success>=1){
			//重置用户session信息
			request.getSession().setAttribute(CommonTool.session_user, cUser);
		}
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
	/**
	 * 跳转到修改密码页面
	 * @return
	 */
	@RequestMapping("/updatePassword")
	public String updatePassword(){
		UserEntity cUser = getCurrentUser();
		request.setAttribute("user", userService.selectByPrimaryKey(cUser.getId()));
		return "user/user/updatePassword";
	}
	
	/**
	 * 修改密码
	 * @return
	 */
	@RequestMapping("/doUpdatePassword")
	@ResponseBody
	public Object doUpdatePassword(UserEntity userEntity){
		//参数、原密码
		String oldPassword = request.getParameter("oldPassword");
		//根据主键查询
		UserEntity cUser = userService.selectByPrimaryKey(getCurrentUser().getId());
		int success = 1;
		String message = "";
		if(cUser.getPassword().equals(oldPassword)){
			cUser.setPassword(userEntity.getPassword());
			userService.updateByPrimaryKey(cUser);//更新
			message = "修改成功！请重新登陆！";
		}else{
			success = -1;//原密码不正确
			message = "原密码不正确！";
		}
		resultMap.put("success",success);
		resultMap.put("message",message);
		if(success>0){
			//删除用户session信息
			request.getSession().setAttribute(CommonTool.session_user, null);
			resultMap.put("url","login");
		}
		return resultMap;
	}
	
}