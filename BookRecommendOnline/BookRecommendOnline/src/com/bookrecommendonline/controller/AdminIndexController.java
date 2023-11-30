package com.bookrecommendonline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookrecommendonline.entity.AdminEntity;
import com.bookrecommendonline.service.AdminService;
import com.bookrecommendonline.service.BookService;
import com.bookrecommendonline.service.BookcollectService;
import com.bookrecommendonline.service.BookcommentService;
import com.bookrecommendonline.service.BooklookService;
import com.bookrecommendonline.service.BookscoreService;
import com.bookrecommendonline.service.BooktypeService;
import com.bookrecommendonline.service.UserService;
import com.bookrecommendonline.service.UserlabelService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.DateTool;

/**
 * 后台管理员首页控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = {"admin"})
public class AdminIndexController extends BaseController{

	@Autowired
	private AdminService adminService;//注入管理员业务类
	@Autowired
	private UserService userService;//注入用户业务类
	@Autowired
	private BooktypeService booktypeService;//注入图书类型业务类
	@Autowired
	private BookService bookService;//注入图书业务类
	@Autowired
	private BookscoreService bookscoreService;//注入图书评分业务类
	@Autowired
	private BookcollectService bookcollectService;//注入图书收藏业务类
	@Autowired
	private BookcommentService bookcommentService;//注入图书评论业务类
	@Autowired
	private BooklookService booklookService;//注入图书浏览业务类
	@Autowired
	private UserlabelService userlabelService;//注入用户喜好标签业务类
	
	/**
	 * 首页
	 * @return
	 */
	@RequestMapping({"","/"})
	public String index(){
		return "admin/index/index";
	}
	
	/**
	 * 首页内容
	 * @return
	 */
	@RequestMapping("/content")
	public String content(ModelMap map){
		Long userCount = userService.findCount(null);//用户数量
		Long bookCount = bookService.findCount(null);//图书数量
		Long booktypeCount = booktypeService.findCount(null);//图书类型数量
		Long bookscoreCount = bookscoreService.findCount(null);//评分记录数量
		Long bookcollectCount = bookcollectService.findCount(null);//收藏记录数量
		Long bookcommentCount = bookcommentService.findCount(null);//评论记录数量
		Long booklookCount = booklookService.findCount(null);//浏览记录数量
		Long userlabelCount = userlabelService.findCount(null);//用户喜好标签数量
		map.put("userCount",userCount);
		map.put("bookCount",bookCount);
		map.put("booktypeCount",booktypeCount);
		map.put("bookscoreCount",bookscoreCount);
		map.put("bookcollectCount",bookcollectCount);
		map.put("bookcommentCount",bookcommentCount);
		map.put("booklookCount",booklookCount);
		map.put("userlabelCount",userlabelCount);
		return "admin/index/content";
	}
	
	/**
	 * 跳转到后台登录页面
	 * @return
	 */
	@RequestMapping("/login")
	public String login(){
		return "admin/login";
	}
	
	/**
	 * 登录
	 * @return
	 */
	@RequestMapping("/doLogin")
	@ResponseBody
	public Object doLogin(AdminEntity adminEntity, String valcode){
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
				//查询参数：管理员名、密码
				params.add(new Object[]{"username","=",adminEntity.getUsername()});
				params.add(new Object[]{"password","=",adminEntity.getPassword()});
				//查询
				List<AdminEntity> adminEntityList = adminService.find(params);
				if(adminEntityList==null || adminEntityList.size()==0){//用户名或密码错误
					success = 0;
					message = "用户名或密码不正确！";
				}else{
					adminEntity = adminEntityList.get(0);
					//登录时间
					adminEntity.setLastlogintime(DateTool.getCurrentDate());
					success = adminService.updateByPrimaryKeySelective(adminEntity);
					url = "admin";
					//将管理员信息保存在session中
					request.getSession().setAttribute(CommonTool.session_admin, adminEntity);
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
	 * 注销
	 * @return
	 */
	@RequestMapping("/quit")
	public String quit(){
		//删除管理员session信息
		request.getSession().setAttribute(CommonTool.session_admin,null);
		return "redirect:/admin/login";
	}
	
}