package com.bookrecommendonline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.service.UserService;
import com.bookrecommendonline.tool.CommonTool;

/**
 * 后台管理员用户控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "admin/user")
public class AdminUserController extends BaseController{

	@Autowired
	private UserService userService;//注入用户业务类
	
	/**
	 * 带参数分页查询
	 * @param map 返回页面的数据集合
	 * @param pageNum 请求页码，默认第一页
	 * @param pageSize 页面数量条数
	 * @param username 查询参数：用户名
	 * @param state 查询参数：用户状态
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue = CommonTool.pageSize) int pageSize,
			String username, Integer state){
		//分页
		PageHelper.startPage(pageNum, pageSize);
		//查询参数：用户名，模糊查询
		params.add(new Object[]{"username","like",username});
		//查询参数：用户状态
		if(state!=null && state!=0){
			params.add(new Object[]{"state","=",state});
		}
		//查询
		List<UserEntity> list = userService.find(params);
		//分页
		PageInfo<UserEntity> pageInfo = new PageInfo<UserEntity>(list);
		map.put("pageBean", pageInfo);
		map.put("username", username);
		map.put("state", state);
		return "admin/user/list";
	}
	
	/**
	 * 跳转到用户编辑页面
	 * @return
	 */
	@RequestMapping("/update")
	public String update(Integer id){
		request.setAttribute("user", userService.selectByPrimaryKey(id));
		return "admin/user/update";
	}
	
	/**
	 * 更新
	 * @return
	 */
	@RequestMapping("/doUpdate")
	@ResponseBody
	public Object doUpdate(UserEntity userEntity){
		//查询
		UserEntity cUser = userService.selectByPrimaryKey(userEntity.getId());
		cUser.setHeader(userEntity.getHeader());
		cUser.setPhone(userEntity.getPhone());
		cUser.setEmail(userEntity.getEmail());
		cUser.setGender(userEntity.getGender());
		cUser.setAge(userEntity.getAge());
		//保存修改的信息
		int success = userService.updateByPrimaryKey(cUser);
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
	/**
	 * 批量删除
	 * @param ids
	 * @return
	 */
	@RequestMapping("/deleteBatch")
	@ResponseBody
	public Object deleteBatch(String ids){
		int success = 0;
		if(ids!=null && !ids.equals("")){
			String[] idArray = ids.split(",");//逗号分割
			if(idArray!=null && idArray.length>0){
				success = userService.deleteBatch(idArray);
			}
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
	/**
	 * 重置密码
	 * @param id
	 * @return
	 */
	@RequestMapping("/resetPassword")
	@ResponseBody
	public Object resetPassword(Integer id){
		int success = 0;
		String message = "";
		//查询用户
		UserEntity userEntity = userService.selectByPrimaryKey(id);
		if(userEntity!=null){
			userEntity.setPassword(CommonTool.defaultPassword);
			success = userService.updateByPrimaryKey(userEntity);//更新用户密码
			message = "操作成功！初始密码"+CommonTool.defaultPassword;
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("message",message);
		resultMap.put("url","reload");
		return resultMap;
	}
	
	/**
	 * 解锁或锁定用户
	 * @return
	 */
	@RequestMapping("/doUpdateState")
	@ResponseBody
	public Object doUpdateState(UserEntity userEntity){
		//查询
		UserEntity cUser = userService.selectByPrimaryKey(userEntity.getId());
		cUser.setState(userEntity.getState());
		//保存修改的信息
		int success = userService.updateByPrimaryKey(cUser);
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
}