package com.bookrecommendonline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bookrecommendonline.entity.BooktypeEntity;
import com.bookrecommendonline.entity.UserlabelEntity;
import com.bookrecommendonline.service.BooktypeService;
import com.bookrecommendonline.service.UserlabelService;
import com.bookrecommendonline.tool.CommonTool;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 后台管理员用户喜好标签控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "admin/userlabel")
public class AdminUserlabelController extends BaseController{

	@Autowired
	private UserlabelService userlabelService;//注入用户喜好标签业务类
	@Autowired
	private BooktypeService booktypeService;//注入图书类型业务类
	
	/**
	 * 带参数分页查询
	 * @param map 返回页面的数据集合
	 * @param pageNum 请求页码，默认第一页
	 * @param pageSize 页面数量条数
	 * @param username 查询参数：用户名
	 * @param booktypeid 查询参数：图书类型id
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue = CommonTool.pageSize) int pageSize,
			String username,Integer booktypeid){
		//分页
		PageHelper.startPage(pageNum, pageSize);
		//查询参数
		params.add(new Object[]{"u.username","like",username});
		params.add(new Object[]{"l.booktypeid","=",booktypeid});
		//查询
		List<UserlabelEntity> list = userlabelService.findJoin(params);
		//分页
		PageInfo<UserlabelEntity> pageInfo = new PageInfo<UserlabelEntity>(list);
		//查询图书类型
		List<BooktypeEntity> booktypeList = booktypeService.find(null);
		map.put("pageBean", pageInfo);
		map.put("booktypeList", booktypeList);
		map.put("username", username);
		map.put("booktypeid", booktypeid);
		return "admin/userlabel/list";
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
				success = userlabelService.deleteBatch(idArray);
			}
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
}