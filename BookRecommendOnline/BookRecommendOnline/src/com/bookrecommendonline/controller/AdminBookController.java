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
import com.bookrecommendonline.entity.BookEntity;
import com.bookrecommendonline.entity.BooktypeEntity;
import com.bookrecommendonline.service.BookService;
import com.bookrecommendonline.service.BooktypeService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.DateTool;

/**
 * 后台管理员图书控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "admin/book")
public class                        AdminBookController extends BaseController{

	@Autowired
	private BookService bookService;//注入图书业务类
	@Autowired
	private BooktypeService booktypeService;//注入图书类型业务类
	
	/**
	 * 带参数分页查询
	 * @param map 返回页面的数据集合
	 * @param pageNum 请求页码，默认第一页
	 * @param pageSize 页面数量条数
	 * @param bookname 查询参数：图书名称
	 * @param booktypeid 查询参数：图书类型id
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue = CommonTool.pageSize) int pageSize,
			String bookname, Integer booktypeid){
		//分页
		PageHelper.startPage(pageNum, pageSize);
		//查询参数：图书名称
		params.add(new Object[]{"m.bookname","like",bookname});
		//查询参数：图书类型id
		if(booktypeid!=null && booktypeid!=0){
			params.add(new Object[]{"m.booktypeid","=",booktypeid});
		}
		//查询
		List<BookEntity> list = bookService.findJoin(params);
		//分页
		PageInfo<BookEntity> pageInfo = new PageInfo<BookEntity>(list);
		//查询所有图书类型
		List<BooktypeEntity> booktypeList = booktypeService.find(null);
		map.put("pageBean", pageInfo);
		map.put("bookname", bookname);
		map.put("booktypeid", booktypeid);
		map.put("booktypeList", booktypeList);
		return "admin/book/list";
	}
	
	/**
	 * 跳转到添加或者修改页面
	 * @param bookid
	 * @return
	 */
	@RequestMapping("/addOrUpdate")
	public String addOrUpdate(Integer bookid){
		if(bookid!=null){//修改
			//根据主键查找
			BookEntity bookEntity = bookService.selectByPrimaryKey(bookid);
			request.setAttribute("book",bookEntity);
		}
		//查询所有图书类型
		List<BooktypeEntity> booktypeList = booktypeService.find(null);
		request.setAttribute("booktypeList",booktypeList);
		return "admin/book/update";
	}
	
	/**
	 * 添加或者修改数据
	 * @param bookEntity
	 * @return
	 */
	@RequestMapping("/doAddOrUpdate")
	@ResponseBody
	public Object doAddOrUpdate(BookEntity bookEntity){
		int success = 0;
		if(bookEntity.getId()!=null){//更新
			success = bookService.updateByPrimaryKeySelective(bookEntity);
		}else{
			bookEntity.setCreatetime(DateTool.getCurrentDate());
			success = bookService.insertSelective(bookEntity);//保存
		}
		resultMap.put("success",success);//返回给页面的响应数据，如果结果大于或者等于1是操作成功，反之操作失败
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径
		resultMap.put("url","admin/book/list");
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
				success = bookService.deleteBatch(idArray);
			}
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
}