package com.bookrecommendonline.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.bookrecommendonline.entity.AdminEntity;
import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.tool.CommonTool;

/**
 * 基础控制器
 * （包含获取当前请求、查询参数、ajax异步请求json格式数据结果封装、当前登录用户、当前登录管理员等信息）
 */
@Controller
@Scope("prototype")
public class BaseController{
	
	@Autowired
	protected HttpServletRequest request;//自动注入request对象
	@Autowired
	protected HttpServletResponse response;//自动注入response对象
	//用户在页面通过ajax异步请求数据，controller控制器将返回到页面的数据保存在resultMap中，
	//springmvc将resultMap封装成json格式数据到页面
	protected Map<Object, Object> resultMap = new HashMap<Object, Object>();
	//数据库查询参数集合，list集合多参数，Object[]第一个值是字段名称、第二个值是查询条件、第三个值是数据
	protected List<Object[]> params = new ArrayList<Object[]>();

	/**
	 * 获取当前登录用户
	 * @return
	 */
	public UserEntity getCurrentUser(){
		return (UserEntity) request.getSession().getAttribute(CommonTool.session_user);
	}
	
	/**
	 * 获取当前登录管理员
	 * @return
	 */
	public AdminEntity getCurrentAdmin(){
		return (AdminEntity) request.getSession().getAttribute(CommonTool.session_admin);
	}
	
}
