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
import com.bookrecommendonline.entity.AdminEntity;
import com.bookrecommendonline.service.AdminService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.DateTool;

/**
 * 后台管理员控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "admin/admin")
public class AdminAdminController extends BaseController{

	@Autowired
	private AdminService adminService;//注入管理员业务类
	
	/**
	 * 分页带参数查询
	 * @param map 返回页面的数据集合
	 * @param pageNum 请求页码，默认第一页
	 * @param pageSize 页面数量条数
	 * @param username 查询参数：管理员名
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue = CommonTool.pageSize) int pageSize,
			String username){
		//分页
		PageHelper.startPage(pageNum, pageSize);
		//查询参数：管理员名
		params.add(new Object[]{"username","like",username});
		//查询
		List<AdminEntity> list = adminService.find(params);
		//分页
		PageInfo<AdminEntity> pageInfo = new PageInfo<AdminEntity>(list);
		map.put("pageBean", pageInfo);
		map.put("username", username);
		return "admin/admin/list";
	}
	
	/**
	 * 跳转到添加或者修改页面
	 * 超级管理员可以添加/修改其他管理员信息
	 * @param adminid
	 * @return
	 */
	@RequestMapping("/addOrUpdate")
	public String addOrUpdate(Integer adminid){
		if(adminid!=null){//修改
			//根据主键查找
			AdminEntity adminEntity = adminService.selectByPrimaryKey(adminid);
			request.setAttribute("admin",adminEntity);
		}
		return "admin/admin/update";
	}
	
	/**
	 * 添加或者修改信息
	 * @param adminEntity
	 * @return
	 */
	@RequestMapping("/doAddOrUpdate")
	@ResponseBody
	public Object doAddOrUpdate(AdminEntity adminEntity){
		int success = 0;
		String message = "";
		String url = "";
		if(adminEntity.getId()!=null){//更新
			//查询当前修改的管理员信息
			AdminEntity cAdminEntity = adminService.selectByPrimaryKey(adminEntity.getId());
			//如果是当前管理员修改自己的信息
			if(cAdminEntity.getId()==getCurrentAdmin().getId()){
				cAdminEntity.setPhone(adminEntity.getPhone());
				cAdminEntity.setEmail(adminEntity.getEmail());
				success = adminService.updateByPrimaryKeySelective(cAdminEntity);
				request.getSession().setAttribute(CommonTool.session_admin, cAdminEntity);
				url = "reload";
			}else{//如果是当前管理员修改其他管理员信息
				//超级管理员可以修改其他管理员信息
				if(getCurrentAdmin().getIssuper()==1){
					cAdminEntity.setPhone(adminEntity.getPhone());
					cAdminEntity.setEmail(adminEntity.getEmail());
					cAdminEntity.setIssuper(adminEntity.getIssuper());
					success = adminService.updateByPrimaryKeySelective(cAdminEntity);
					url = "reload";
				}else{
					success = 0;
					message = "操作失败！暂无权限！";
				}
			}
		}else{//添加
			//超级管理员可以添加其他管理员信息
			if(getCurrentAdmin().getIssuper()==1){
				//查询管理员名是否已经存在
				params.add(new Object[]{"username","=",adminEntity.getUsername()});
				AdminEntity selectAdminEntity = adminService.findFirst(params);
				if(selectAdminEntity!=null){
					success = 0;
					message = "添加失败！管理员名已存在！";
				}else{
					adminEntity.setPassword(CommonTool.defaultPassword);
					adminEntity.setCreatetime(DateTool.getCurrentDate());
					success = adminService.insertSelective(adminEntity);
					url = "reload";
					message = "添加成功！初始密码"+CommonTool.defaultPassword;
				}
			}else{
				success = 0;
				message = "操作失败！暂无权限！";
			}
		}
		resultMap.put("success",success);
		resultMap.put("message",message);
		resultMap.put("url",url);
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
		String message = "";
		if(getCurrentAdmin().getIssuper()==1){
			if(ids!=null && !ids.equals("")){
				String[] idArray = ids.split(",");//逗号分割
				if(idArray!=null && idArray.length>0){
					success = adminService.deleteBatch(idArray,getCurrentAdmin().getId());
				}
			}
		}else{
			success = 0;
			message = "操作失败！暂无权限！";
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("message",message);
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
		if(getCurrentAdmin().getIssuper()==1 && id!=getCurrentAdmin().getId()){
			//查询管理员
			AdminEntity adminEntity = adminService.selectByPrimaryKey(id);
			if(adminEntity!=null){
				adminEntity.setPassword(CommonTool.defaultPassword);
				success = adminService.updateByPrimaryKey(adminEntity);//更新密码
				message = "操作成功！初始密码"+CommonTool.defaultPassword;
			}
		}else{
			success = 0;
			message = "操作失败！暂无权限！";
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("message",message);
		resultMap.put("url","reload");
		return resultMap;
	}
	
	/**
	 * 跳转到修改密码页面
	 * @return
	 */
	@RequestMapping("/updatePassword")
	public String updatePassword(){
		return "admin/admin/updatePassword";
	}
	
	/**
	 * 修改密码
	 * @return
	 */
	@RequestMapping("/doUpdatePassword")
	@ResponseBody
	public Object doUpdatePassword(AdminEntity adminEntity){
		//原密码
		String oldPassword = request.getParameter("oldPassword");
		//查询
		AdminEntity cAdminEntity = adminService.selectByPrimaryKey(getCurrentAdmin().getId());
		int success = 1;
		String message = "";
		if(cAdminEntity.getPassword().equals(oldPassword)){
			cAdminEntity.setPassword(adminEntity.getPassword());
			adminService.updateByPrimaryKey(cAdminEntity);//更新密码
			message = "修改成功！请重新登陆！";
		}else{
			success = -1;//原密码不正确
			message = "修改失败！原密码不正确！";
		}
		resultMap.put("success",success);
		resultMap.put("message",message);
		if(success>0){
			//删除管理员session信息
			request.getSession().setAttribute(CommonTool.session_user, null);
			resultMap.put("url","admin/login");
		}
		return resultMap;
	}
	
}