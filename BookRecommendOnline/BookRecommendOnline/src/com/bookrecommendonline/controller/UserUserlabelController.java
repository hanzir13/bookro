package com.bookrecommendonline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookrecommendonline.entity.BooktypeEntity;
import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.entity.UserlabelEntity;
import com.bookrecommendonline.service.BooktypeService;
import com.bookrecommendonline.service.UserService;
import com.bookrecommendonline.service.UserlabelService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.DateTool;

/**
 * 前台用户喜好标签控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "user/userlabel")
public class UserUserlabelController extends BaseController{

	@Autowired
	private UserlabelService userlabelService;//注入用户喜好标签业务类
	@Autowired
	private BooktypeService booktypeService;//注入图书类型业务类
	@Autowired
	private UserService userService;//注入用户业务类
	
	/**
	 * 带参数查询
	 * @param map 返回页面的数据集合
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap map){
		//查询参数，用户id
		params.add(new Object[]{"userid","=",getCurrentUser().getId()});
		//查询
		List<UserlabelEntity> list = userlabelService.find(params);
		//查询图书类型
		List<BooktypeEntity> booktypeList = booktypeService.find(null);
		request.setAttribute("list",list);
		request.setAttribute("booktypeList",booktypeList);
		return "user/userlabel/list";
	}
	
	/**
	 * 用户初次登录后跳转到选择喜好标签页面
	 * @param userid 参数，登录用户id
	 * @return
	 */
	@RequestMapping("/listCommon")
	public String listCommon(Integer userid){
		//查询图书类型
		List<BooktypeEntity> booktypeList = booktypeService.find(null);
		request.setAttribute("booktypeList",booktypeList);
		request.setAttribute("userid",userid);
		return "user/userlabel/listCommon";
	}
	
	/**
	 * 保存用户初次登录后选择的喜好标签
	 * @param booktypeids 选择的喜好标签id
	 * @param userid 用户id
	 * @return
	 */
	@RequestMapping("/doSaveCommon")
	@ResponseBody
	public Object doSaveCommon(String booktypeids,Integer userid){
		UserEntity userEntity = new UserEntity();
		userEntity.setId(userid);
		int success = userlabelService.save(userEntity, booktypeids);//保存
		if(success>0){
			userEntity = userService.selectByPrimaryKey(userEntity.getId());//查询登录用户信息
			//登录时间
			userEntity.setLastlogintime(DateTool.getCurrentDate());
			success = userService.updateByPrimaryKeySelective(userEntity);
			request.getSession().setAttribute(CommonTool.session_user,userEntity);//将登录用户信息保存在session会话中
		}
		resultMap.put("success",success);
		return resultMap;
	}
	
	/**
	 * 修改用户喜好标签
	 * @param booktypeids 选择的喜好标签id
	 * @return
	 */
	@RequestMapping("/doUpdate")
	@ResponseBody
	public Object doUpdate(String booktypeids){
		int success = userlabelService.update(getCurrentUser(), booktypeids);
		resultMap.put("success",success);//返回给页面的响应数据，如果结果大于或者等于1是操作成功，反之操作失败
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("url","reload");
		return resultMap;
	}
	
}