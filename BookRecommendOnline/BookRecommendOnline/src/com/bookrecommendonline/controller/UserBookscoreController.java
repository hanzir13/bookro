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
import com.bookrecommendonline.entity.BookscoreEntity;
import com.bookrecommendonline.service.BookscoreService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.DateTool;

/**
 * 前台用户图书评分控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "user/bookscore")
public class UserBookscoreController extends BaseController{

	@Autowired
	private BookscoreService bookscoreService;//注入图书评分业务类
	
	/**
	 * 带参数分页查询
	 * @param map 返回页面的数据集合
	 * @param pageNum 请求页码，默认第一页
	 * @param pageSize 页面数量条数
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue = CommonTool.pageSize) int pageSize){
		//分页
		PageHelper.startPage(pageNum, pageSize);
		//查询参数，当前登录用户id
		params.add(new Object[]{"s.userid","=",getCurrentUser().getId()});
		//查询
		List<BookscoreEntity> list = bookscoreService.findJoin(params);
		//分页
		PageInfo<BookscoreEntity> pageInfo = new PageInfo<BookscoreEntity>(list);
		map.put("pageBean", pageInfo);
		return "user/bookscore/list";
	}
	
	/**
	 * 添加评分或者修改评分
	 * @param bookscoreEntity
	 * @return
	 */
	@RequestMapping("/doAddOrUpdate")
	@ResponseBody
	public Object doAddOrUpdate(BookscoreEntity bookscoreEntity){
		int success = 0;
		//当前登录用户对当前图书的评分
		params.add(new Object[]{"userid","=",getCurrentUser().getId()});
		params.add(new Object[]{"bookid","=",bookscoreEntity.getBookid()});
		List<BookscoreEntity> bookscoreList = bookscoreService.find(params);
		if(bookscoreList!=null && bookscoreList.size()>0){//如果用户已经评分，那么进行修改
			BookscoreEntity bookscoreEntityTemp = bookscoreList.get(0);
			bookscoreEntityTemp.setScore(bookscoreEntity.getScore());
			success = bookscoreService.updateByPrimaryKeySelective(bookscoreEntityTemp);
		}else{
			//添加评分
			bookscoreEntity.setUserid(getCurrentUser().getId());
			bookscoreEntity.setCreatetime(DateTool.getCurrentDate());
			bookscoreService.insertSelective(bookscoreEntity);
			success = 1;
		}
		resultMap.put("success",success);
		//返回给页面的响应数据，如果结果大于或者等于1是操作成功，反之操作失败
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，
		// reload是刷新当前页面
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
				success = bookscoreService.deleteBatch(idArray);
			}
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
}