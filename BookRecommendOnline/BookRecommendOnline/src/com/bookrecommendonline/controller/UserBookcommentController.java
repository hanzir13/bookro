package com.bookrecommendonline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.bookrecommendonline.entity.BookcommentEntity;
import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.service.BookcommentService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.DateTool;

/**
 * 前台用户图书评论控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "user/bookcomment")
public class UserBookcommentController extends BaseController{

	@Autowired
	private BookcommentService bookcommentService;//注入图书评论记录业务类
	
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
		params.add(new Object[]{"co.userid","=",cUserEntity.getId()});
		//查询
		List<BookcommentEntity> list = bookcommentService.findJoin(params);
		//分页
		PageInfo<BookcommentEntity> pageInfo = new PageInfo<BookcommentEntity>(list);
		map.put("pageBean", pageInfo);
		return "user/bookcomment/list";
	}
	
	/**
	 * 跳转到评论详情页面
	 * @return
	 */
	@RequestMapping("/detail")
	public String detail(Model model,Integer commentid){
		//当前登录用户
		UserEntity cUserEntity = getCurrentUser();
		//查询参数，用户id、评论id
		params.add(new Object[]{"co.userid","=",cUserEntity.getId()});
		params.add(new Object[]{"co.id","=",commentid});
		//关联查询
		BookcommentEntity bookcommentEntity = bookcommentService.findFirstJoin(params);
		model.addAttribute("bookcomment", bookcommentEntity);
		return "user/bookcomment/detail";
	}
	
	/**
	 * 跳转到评论编辑页面
	 * @return
	 */
	@RequestMapping("/update")
	public String update(Model model,Integer commentid){
		//当前登录用户
		UserEntity cUserEntity = getCurrentUser();
		//查询参数，用户id、评论id
		params.add(new Object[]{"co.userid","=",cUserEntity.getId()});
		params.add(new Object[]{"co.id","=",commentid});
		//关联查询
		BookcommentEntity bookcommentEntity = bookcommentService.findFirstJoin(params);
		model.addAttribute("bookcomment", bookcommentEntity);
		return "user/bookcomment/update";
	}
	
	/**
	 * 添加/修改评论，ajax异步请求，返回json格式数据
	 * @param bookcommentEntity 评论对象
	 * @return
	 */
	@RequestMapping("/doAddOrUpdate")
	@ResponseBody
	public Object doAddOrUpdate(BookcommentEntity bookcommentEntity){
		int success = 0;
		if(bookcommentEntity.getId()!=null){//修改
			//根据主键查询
			BookcommentEntity oldBookcommentEntity = bookcommentService.selectByPrimaryKey(bookcommentEntity.getId());
			if(oldBookcommentEntity!=null){
				//修改
				oldBookcommentEntity.setContent(bookcommentEntity.getContent());
				success = bookcommentService.updateByPrimaryKeySelective(oldBookcommentEntity);
			}
		}else{//保存
			bookcommentEntity.setUserid(getCurrentUser().getId());;
			bookcommentEntity.setCreatetime(DateTool.getCurrentDate());
			success = bookcommentService.insertSelective(bookcommentEntity);
		}
		resultMap.put("url","reload");
		resultMap.put("success",success);
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
				success = bookcommentService.deleteBatch(idArray);
			}
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
}