package com.bookrecommendonline.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.mahout.cf.taste.model.DataModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookrecommendonline.entity.BookEntity;
import com.bookrecommendonline.entity.BookcollectEntity;
import com.bookrecommendonline.entity.BookscoreEntity;
import com.bookrecommendonline.entity.BooktypeEntity;
import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.service.BookService;
import com.bookrecommendonline.service.BookcollectService;
import com.bookrecommendonline.service.BookscoreService;
import com.bookrecommendonline.service.BooktypeService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.recommend.RecommendDataModelTool;
import com.bookrecommendonline.tool.recommend.RecommendTool;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 前台用户首页控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = {"user","/"})
public class UserIndexController extends BaseController{
	
	@Autowired
	private BookService bookService;//注入图书业务类
	@Autowired
	private BooktypeService booktypeService;//注入图书类型业务类
	@Autowired
	private BookscoreService bookscoreService;//注入图书评分业务类
	@Autowired
	private BookcollectService bookcollectService;//注入图书收藏业务类

	/**
	 * 前台首页
	 * 热点榜单：查询浏览数量最多的图书，同时不包括当前登录用户浏览过的图书
	 * 个性化推荐：
	 *    游客：热点推荐（根据图书总评分和总收藏数量降序推荐）
	 *    登录用户：基于用户的协同过滤推荐算法（根据评分数据），
	 *    		   如果没有推荐结果，采用热点推荐（根据登录用户喜好标签下的图书的总评分降序推荐，同时是登录用户没有评分的）；
	 *           基于项目的协同过滤推荐算法（根据收藏数据），
	 *           如果没有推荐结果，采用热点推荐（根据登录用户喜好标签下的图书的收藏数量降序推荐，同时是登录用户没有收藏的）。
	 * @return
	 */
	@RequestMapping({"/index","/"})
	public String index(ModelMap map){
		//查询第一页数据
		PageHelper.startPage(1, Integer.parseInt(CommonTool.pageSize));
		//查询
		List<BookEntity> bookEntitylist = bookService.findJoin(null);
		//分页
		PageInfo<BookEntity> pageBean = new PageInfo<BookEntity>(bookEntitylist);
		//查询图书的平均评分
		bookEntitylist = pageBean.getList();
		if(bookEntitylist!=null && bookEntitylist.size()>0){
			for(BookEntity bookEntity:bookEntitylist){
				params.clear();
				params.add(new Object[]{"bookid","=",bookEntity.getId()});
				//查询图书评分
				bookEntity.setAvgscore(bookscoreService.findAvg(params));
			}
		}
		//查询所有图书类型
		List<BooktypeEntity> booktypeList = booktypeService.find(null);
		map.put("pageBean", pageBean);
		map.put("booktypeList", booktypeList);
		//获取当前登录用户对象
		UserEntity cUser = getCurrentUser();
		
		//热点榜单，查询浏览数量最多的图书，同时不包括当前登录用户浏览过的图书
		List<BookEntity> topBooks = bookService.findTopByBooklook(cUser==null?null:cUser.getId());
		request.setAttribute("topBooks", topBooks);
		
		//个性化推荐
		//定义个性化推荐图书结果
		List<BookEntity> recommendBooks = new ArrayList<BookEntity>();
		if(cUser==null){//用户没有登录，游客：热点推荐（根据图书总评分和总收藏数量降序推荐）
			System.out.println("用户没有登录，热点推荐（根据图书总评分和总收藏数量降序推荐）");
			recommendBooks = recommendHot(recommendBooks, null);
		}else{
			//登录用户
			//定义个性化推荐结果（图书ids，以逗号分割）
			String recommendIdsFinal = "";
			
			System.out.println("***基于用户的协同过滤推荐算法开始***");
			//实例化协同过滤推荐算法工具类对象
			RecommendTool recommendTool = new RecommendTool();
			//定义用户-图书评分矩阵工具类
			RecommendDataModelTool recommendDataModelTool = new RecommendDataModelTool();
			System.out.println("查询所有图书评分记录");
			//查询所有图书评分记录
			List<BookscoreEntity> bookscoreList = bookscoreService.find(null);
			//构建用户-图书评分矩阵
			DataModel dataModelByScore = recommendDataModelTool.getDadaModelByScore(bookscoreList, cUser);
			//调用基于用户的协同过滤推荐算法方法
			String recommendIds = recommendTool.recommendByScoreBaseUser(cUser, dataModelByScore);
			//判断是否存在推荐结果
			if(recommendIds!=null && !recommendIds.equals("")){
				recommendIdsFinal = recommendIds;
			}
			System.out.println("***基于用户的协同过滤推荐算法结束***");
			
			System.out.println("***基于项目（图书）的协同过滤推荐算法开始***");
			System.out.println("查询所有图书收藏记录");
			//查询所有图书收藏记录
			List<BookcollectEntity> bookcollectList = bookcollectService.find(null);
			//构建用户-图书收藏矩阵
			DataModel dataModelByCollect = recommendDataModelTool.getDadaModelByCollect(bookcollectList, cUser);
			//调用基于项目（图书）的协同过滤推荐算法方法
			String recommendIds2 = recommendTool.recommendByCollectBaseItem(cUser, dataModelByCollect);
			//判断是否存在推荐结果
			if(recommendIds2!=null && !recommendIds2.equals("")){
				if(recommendIdsFinal!=null && !recommendIdsFinal.equals("")){
					recommendIdsFinal+=","+recommendIds2;
				}else{
					recommendIdsFinal = recommendIds2;
				}
			}
			System.out.println("***基于项目（图书）的协同过滤推荐算法结束***");
			
			//将两次推荐结果查询出来
			if(recommendIdsFinal!=null && !recommendIdsFinal.equals("")){
				params.clear();
				params.add(new Object[]{"m.id","in",recommendIdsFinal});
				recommendBooks = bookService.findJoin(params);
			}else{
				//如果基于用户和基于项目均没有推荐结果，采用热点推荐
				//基于用户的协同过滤推荐算法（根据评分数据），如果没有推荐结果，采用热点推荐（根据登录用户喜好标签下的图书的总评分降序推荐，同时是登录用户没有评分的）；
				//基于项目的协同过滤推荐算法（根据收藏数据），如果没有推荐结果，采用热点推荐（根据登录用户喜好标签下的图书的收藏数量降序推荐，同时是登录用户没有收藏的）。
				System.out.println("基于用户和基于项目均没有推荐结果，采用热点推荐（根据登录用户喜好标签下的图书的总评分和总收藏数量降序推荐）");
				recommendBooks = recommendHot(recommendBooks, cUser.getId());
			}
		}
		request.setAttribute("recommendBooks", recommendBooks);
		return "user/index/index";
	}
	
	/**
	 * 热点推荐
	 * 基于用户的协同过滤推荐算法（根据评分数据），如果没有推荐结果，采用热点推荐（根据登录用户喜好标签下的图书的总评分降序推荐，同时是登录用户没有评分的）；
	 * 基于项目的协同过滤推荐算法（根据收藏数据），如果没有推荐结果，采用热点推荐（根据登录用户喜好标签下的图书的图书收藏数量降序推荐，同时是登录用户没有收藏的）。
	 * @param recommendBooks 推荐的图书
	 * @param cuserid 当前登录用户id
	 * @return
	 */
	private List<BookEntity> recommendHot(List<BookEntity> recommendBooks, Integer cuserid){
		//根据图书总评分降序推荐
		List<BookEntity> recommendBooksByBookscore = bookService.findHotByBookscore(cuserid);
		//根据图书收藏数量降序推荐
		List<BookEntity> recommendBooksByBookcollect = bookService.findHotByBookcollect(cuserid);
		//去除重复的图书
		if(recommendBooksByBookscore!=null && recommendBooksByBookscore.size()>0){
			recommendBooks.addAll(recommendBooksByBookscore);
		}
		if(recommendBooksByBookcollect!=null && recommendBooksByBookcollect.size()>0){
			for(BookEntity bookEntity:recommendBooksByBookcollect){
				int count = 0;
				for(BookEntity bookEntity2:recommendBooks){
					if(bookEntity2.getId()==bookEntity.getId() || 
							bookEntity2.getId().equals(bookEntity.getId())){
						continue;
					}
					count++;
				}
				if(count==recommendBooks.size()){
					recommendBooks.add(bookEntity);
				}
			}
		}
		return recommendBooks;
	}
	
}
