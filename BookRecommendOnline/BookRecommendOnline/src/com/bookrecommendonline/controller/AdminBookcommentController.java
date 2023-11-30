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
import com.bookrecommendonline.entity.BookcommentEntity;
import com.bookrecommendonline.service.BookcommentService;
import com.bookrecommendonline.tool.CommonTool;

/**
 * 后台管理员图书评论控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "admin/bookcomment")
public class AdminBookcommentController extends BaseController{

	@Autowired
	private BookcommentService bookcommentService;//注入图书评论业务类
	
	/**
	 * 带参数分页查询
	 * @param map 返回页面的数据集合
	 * @param pageNum 请求页码，默认第一页
	 * @param pageSize 页面数量条数
	 * @param username 查询参数：用户名
	 * @param bookname 查询参数：图书名称
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue = CommonTool.pageSize) int pageSize,
			String username,String bookname){
		//分页
		PageHelper.startPage(pageNum, pageSize);
		//查询参数
		params.add(new Object[]{"u.username","like",username});
		params.add(new Object[]{"m.bookname","like",bookname});
		//关联查询
		List<BookcommentEntity> list = bookcommentService.findJoin(params);
		//分页
		PageInfo<BookcommentEntity> pageInfo = new PageInfo<BookcommentEntity>(list);
		map.put("pageBean", pageInfo);
		map.put("username", username);
		map.put("bookname", bookname);
		return "admin/bookcomment/list";
	}
	
	/**
	 * 跳转到图书评论详情页面
	 * @return
	 */
	@RequestMapping("/detail")
	public String detail(Integer commentid){
		params.add(new Object[]{"co.id","=",commentid});
		//查询
		BookcommentEntity bookcommentEntity = bookcommentService.findFirstJoin(params);
		request.setAttribute("bookcomment", bookcommentEntity);
		return "admin/bookcomment/detail";
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
				success = bookcommentService.deleteBatch(idArray);
			}
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
}