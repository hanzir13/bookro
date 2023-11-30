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
import com.bookrecommendonline.entity.BooktypeEntity;
import com.bookrecommendonline.service.BooktypeService;
import com.bookrecommendonline.tool.CommonTool;

/**
 * 后台管理员图书类型控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "admin/booktype")
public class AdminBooktypeController extends BaseController{

	@Autowired
	private BooktypeService booktypeService;//注入图书类型业务类
	
	/**
	 * 带参数分页查询
	 * @param map 返回页面的数据集合
	 * @param pageNum 请求页码，默认第一页
	 * @param pageSize 页面数量条数
	 * @param typename 查询参数：图书类型名称
	 * @return
	 */
	@RequestMapping("/list")
	public String list(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue = CommonTool.pageSize) int pageSize,
			String typename){
		//分页
		PageHelper.startPage(pageNum, pageSize);
		//查询参数：图书类型名称
		params.add(new Object[]{"typename","like",typename});
		//查询
		List<BooktypeEntity> list = booktypeService.find(params);
		//分页
		PageInfo<BooktypeEntity> pageInfo = new PageInfo<BooktypeEntity>(list);
		map.put("pageBean", pageInfo);
		map.put("typename", typename);
		return "admin/booktype/list";
	}
	
	/**
	 * 跳转到添加或者修改页面
	 * @param booktypeid
	 * @return
	 */
	@RequestMapping("/addOrUpdate")
	public String addOrUpdate(Integer booktypeid){
		if(booktypeid!=null){//修改
			//查询
			BooktypeEntity booktypeEntity = booktypeService.selectByPrimaryKey(booktypeid);
			request.setAttribute("booktype",booktypeEntity);
		}
		return "admin/booktype/update";
	}
	
	/**
	 * 添加或者修改保存数据
	 * @param booktypeEntity
	 * @return
	 */
	@RequestMapping("/doAddOrUpdate")
	@ResponseBody
	public Object doAddOrUpdate(BooktypeEntity booktypeEntity){
		int success = 0;
		if(booktypeEntity.getId()!=null){//更新
			success = booktypeService.updateByPrimaryKeySelective(booktypeEntity);
		}else{
			success = booktypeService.insertSelective(booktypeEntity);//保存
		}
		resultMap.put("success",success);
		resultMap.put("url","admin/booktype/list");
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
				success = booktypeService.deleteBatch(idArray);
			}
		}
		//返回给页面的响应数据，不论操作是否成功，只要返回url变量数据，就会再次请求这个url变量路径，reload是刷新当前页面
		resultMap.put("success",success);
		resultMap.put("url","reload");
		return resultMap;
	}
	
}