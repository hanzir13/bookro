package com.bookrecommendonline.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.bookrecommendonline.entity.BooklookEntity;
import com.bookrecommendonline.service.BooklookService;
import com.bookrecommendonline.tool.CommonTool;

/**
 * 前台用户图书浏览控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "user/booklook")
public class UserBooklookController extends BaseController{

	@Autowired
	private BooklookService booklookService;//注入图书浏览业务类
	
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
		//查询参数，用户id
		params.add(new Object[]{"l.userid","=",getCurrentUser().getId()});
		//查询
		List<BooklookEntity> list = booklookService.findJoin(params);
		//分页
		PageInfo<BooklookEntity> pageInfo = new PageInfo<BooklookEntity>(list);
		map.put("pageBean", pageInfo);
		return "user/booklook/list";
	}
	
}