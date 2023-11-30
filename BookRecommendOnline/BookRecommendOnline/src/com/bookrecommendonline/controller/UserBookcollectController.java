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
import com.bookrecommendonline.entity.BookcollectEntity;
import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.service.BookcollectService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.DateTool;

/**
 * 前台用户图书收藏控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "user/bookcollect")
public class UserBookcollectController extends BaseController{

	@Autowired
	private BookcollectService bookcollectService;//注入收藏记录业务类
	
	/**
	 * 分页带参数查询
	 * @param map 返回页面的数据集合
	 * @param pageNum 请求页码，默认第一页
	 * @param pageSize 页面数量条数
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue = CommonTool.pageSize) int pageSize){
		//当前登录用户
		UserEntity cUserEntity = getCurrentUser();
		//分页
		PageHelper.startPage(pageNum, pageSize);
		//查询参数，当前登录用户id
		params.add(new Object[]{"c.userid","=",cUserEntity.getId()});
		//查询
		List<BookcollectEntity> list = bookcollectService.findJoin(params);
		//分页
		PageInfo<BookcollectEntity> pageInfo = new PageInfo<BookcollectEntity>(list);
		map.put("pageBean", pageInfo);
		return "user/bookcollect/list";
	}
	
	/**
	 * 添加/取消收藏，ajax异步请求，返回json格式数据
	 * @param bookcollectEntity 收藏对象
	 * @return
	 */
	@RequestMapping("/doSave")
	@ResponseBody
	public Object doSave(BookcollectEntity bookcollectEntity){
		int success = 0;
		//当前登录用户
		UserEntity cUserEntity = getCurrentUser();
		//查询参数，用户id、图书id
		params.add(new Object[]{"userid","=",cUserEntity.getId()});
		params.add(new Object[]{"bookid","=",bookcollectEntity.getBookid()});
		//查询
		BookcollectEntity bookcollectEntity2 = bookcollectService.findFirst(params);
		if(bookcollectEntity2==null){//添加
			bookcollectEntity.setCreatetime(DateTool.getCurrentDate());
			bookcollectEntity.setUserid(cUserEntity.getId());
			success = bookcollectService.insertSelective(bookcollectEntity);
		}else{//删除
			success = bookcollectService.deleteByPrimaryKey(bookcollectEntity2.getId());
		}
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
				success = bookcollectService.deleteBatch(idArray);
			}
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
}