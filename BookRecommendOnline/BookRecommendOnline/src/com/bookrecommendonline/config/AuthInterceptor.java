package com.bookrecommendonline.config;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.bookrecommendonline.tool.CommonTool;

/**
 * 权限拦截器，登录拦截（有部分操作是需要用户或者管理员登录后才能有权限操作）
 * 在spring-springmvc.xml配置文件中配置该拦截器
 * 用户在请求具体某个controller控制器中的方法时，会先执行该权限拦截器
 * 该权限拦截器会验证当前请求是否有权限，没有权限会提示需要登录
 */
public class AuthInterceptor implements HandlerInterceptor{
	
	//map集合中的url不需要登录验证
	private static final Map<String,String> globalUrlMap = new HashMap<String, String>();
	
	static{
		//前台用户
		globalUrlMap.put("/,",null);
		globalUrlMap.put("/user,",null);
		globalUrlMap.put("/login,",null);
		globalUrlMap.put("/doLogin,",null);
		globalUrlMap.put("/register,",null);
		globalUrlMap.put("/doRegister,",null);
		globalUrlMap.put("/quit,",null);
		globalUrlMap.put("/user/book/detail,",null);
		globalUrlMap.put("/user/book/list,",null);
		globalUrlMap.put("/user/public/doValCode,",null);
		globalUrlMap.put("/user/userlabel/listCommon,",null);
		globalUrlMap.put("/user/userlabel/doSaveCommon,",null);
		
		//后台管理员
		globalUrlMap.put("/admin/login,",null);
		globalUrlMap.put("/admin/doLogin,",null);
		globalUrlMap.put("/admin/quit,",null);
		globalUrlMap.put("/admin/public/doValCode,",null);
	}
	
	/**
	 * 用户请求控制器中的具体方法执行之前进行拦截
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
			Object arg2) throws Exception {
		String requestUrl = request.getRequestURI();  
        String contextPath = request.getContextPath(); 
        //请求地址
        String url = requestUrl.substring(contextPath.length());
        System.out.println("请求地址url："+url);
        HttpSession session = request.getSession();
        //管理员权限设置开始
  		if(url.startsWith("/admin")){
  			if(!globalUrlMap.containsKey(url+",")){
				if(session.getAttribute(CommonTool.session_admin)==null){
					if (request.getHeader("x-requested-with") != null && 
							request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){
						//成立的话说明这是ajax请求过来的
						return false;//如果没有权限，需要登录
					}else{
						response.sendRedirect(contextPath+"/admin/login");
  						return false;//如果没有权限，需要登录
					}
				}
  			}
  		}
  		//管理员权限设置结束
  		//前台权限设置开始
  		if(url.startsWith("/user")){
  			if(!globalUrlMap.containsKey(url+",")){
  				if(session.getAttribute(CommonTool.session_user)==null){
  					if (request.getHeader("x-requested-with") != null && 
							request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")){
						//成立的话说明这是ajax请求过来的
						return false;//如果没有权限，需要登录
					}else{
						response.sendRedirect(contextPath+"/login");
  						return false;//如果没有权限，需要登录
					}
  				}
  			}
  		}
  		//前台权限设置结束
		return true;
	}

	/**
	 * 用户请求控制器中的具体方法执行之后进行拦截，这里不做处理
	 */
	@Override
	public void afterCompletion(HttpServletRequest arg0,
			HttpServletResponse arg1, Object arg2, Exception arg3)
			throws Exception {
	}

	/**
	 * 用户请求控制器中的具体方法执行中进行拦截，这里不做处理
	 */
	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse response,
			Object arg2, ModelAndView arg3) throws Exception {
	}

}
