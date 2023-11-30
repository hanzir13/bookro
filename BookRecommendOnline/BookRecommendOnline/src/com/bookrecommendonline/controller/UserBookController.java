package com.bookrecommendonline.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.bookrecommendonline.entity.BookEntity;
import com.bookrecommendonline.entity.BookcollectEntity;
import com.bookrecommendonline.entity.BookcommentEntity;
import com.bookrecommendonline.entity.BooklookEntity;
import com.bookrecommendonline.entity.BookscoreEntity;
import com.bookrecommendonline.entity.BooktypeEntity;
import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.service.BookService;
import com.bookrecommendonline.service.BookcollectService;
import com.bookrecommendonline.service.BookcommentService;
import com.bookrecommendonline.service.BooklookService;
import com.bookrecommendonline.service.BookscoreService;
import com.bookrecommendonline.service.BooktypeService;
import com.bookrecommendonline.tool.CommonTool;
import com.bookrecommendonline.tool.CurScoreAnalysisTool;
import com.bookrecommendonline.tool.DateTool;
import com.bookrecommendonline.tool.ScoreAnalysisTool;

/**
 * 前台用户图书控制器
 */
@Controller
@Scope("prototype")
@RequestMapping(value = "user/book")
public class UserBookController extends BaseController{
	
	@Autowired
	private BookService bookService;//注入图书业务类
	@Autowired
	private BooktypeService booktypeService;//注入图书类型业务类
	@Autowired
	private BookscoreService bookscoreService;//注入图书评分业务类
	@Autowired
	private BooklookService booklookService;//注入图书浏览业务类
	@Autowired
	private BookcollectService bookcollectService;//注入图书收藏业务类
	@Autowired
	private BookcommentService bookcommentService;//注入图书评论业务类

	/**
	 * 图书列表（带参数分页查询）
	 * @param map 返回结果
	 * @param pageNum 查询第几页
	 * @param pageSize 每页显示几条数据
	 * @param bookname 图书名称参数
	 * @param booktypeid 图书类型id参数
	 * @return
	 */
	@RequestMapping({"/list","/"})
	public String list(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue = CommonTool.pageSize) int pageSize,
			String bookname,Integer booktypeid){
		//查询第一页数据
		PageHelper.startPage(pageNum, Integer.parseInt(CommonTool.pageSize));
		//查询参数：图书名称、作者、图书类型id
		if(bookname!=null && !bookname.equals("")){
			params.add(new Object[]{"or", 
					new Object[]{"m.bookname", "m.author"},
					new Object[]{"like", "like"},
					new Object[]{bookname,bookname},
			});
		}
		params.add(new Object[]{"m.booktypeid","=",booktypeid});
		//查询
		List<BookEntity> bookEntitylist = bookService.findJoin(params);
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
		//查询所有类型
		List<BooktypeEntity> booktypeList = booktypeService.find(null);
		map.put("pageBean", pageBean);
		map.put("booktypeList", booktypeList);
		map.put("bookname", bookname);
		map.put("booktypeid", booktypeid);
		return "user/book/list";
	}
	
	/**
	 * 图书详情
	 * @param bookid
	 * @return
	 */
	@RequestMapping("/detail")
	public String detail(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue = "6") int pageSize,
			Integer bookid){
		//查询当前图书
		BookEntity bookEntity = bookService.selectByPrimaryKey(bookid);
		request.setAttribute("book",bookEntity);
		//查询当前图书类型
		BooktypeEntity booktypeEntity = booktypeService.selectByPrimaryKey(bookEntity.getBooktypeid());
		request.setAttribute("booktype",booktypeEntity);
		
		//分页查询图书评论
		PageHelper.startPage(pageNum, pageSize);
		//查询参数：图书id
		params.clear();
		params.add(new Object[]{"co.bookid","=",bookid});
		//查询评论
		List<BookcommentEntity> bookcommentList = bookcommentService.findJoinEx(params);
		PageInfo<BookcommentEntity> pageInfo = new PageInfo<BookcommentEntity>(bookcommentList);
		map.put("pageBean", pageInfo);
		
		//获取当前登录用户
		UserEntity cUser = getCurrentUser();
		Integer cUserid = null;//当前登录用户id
		if(cUser!=null){//用户已登录
			cUserid = cUser.getId();
			//查询当前登录用户对当前图书的评分
			params.clear();
			//查询参数：用户id、图书id
			params.add(new Object[]{"userid","=",cUser.getId()});
			params.add(new Object[]{"bookid","=",bookEntity.getId()});
			//查询
			List<BookscoreEntity> bookscoreList = bookscoreService.find(params);
			if(bookscoreList!=null && bookscoreList.size()>0){
				request.setAttribute("bookscore",bookscoreList.get(0));
			}
			
			//查询当前登录用户对当前图书的收藏
			params.clear();
			params.add(new Object[]{"userid","=",cUser.getId()});
			params.add(new Object[]{"bookid","=",bookEntity.getId()});
			//查询
			BookcollectEntity bookcollectEntity = bookcollectService.findFirst(params);
			request.setAttribute("bookcollect",bookcollectEntity);
			
			//添加浏览记录
			BooklookEntity booklookEntity = new BooklookEntity();
			booklookEntity.setUserid(cUser.getId());
			booklookEntity.setBookid(bookEntity.getId());
			booklookEntity.setCreatetime(DateTool.getCurrentDate());
			booklookService.insertSelective(booklookEntity);//保存
		}
		
		//猜你喜欢，根据总评分降序查找同类型下图书，同时不包括当前登录用户评分过的图书
		List<BookEntity> relateRecommends = bookService.findRelateByUserid(bookid, 
				bookEntity.getBooktypeid(), cUserid);
		request.setAttribute("relateRecommends",relateRecommends);
		
		//评分分析
		ScoreAnalysisTool scoreAnalysisTool = new ScoreAnalysisTool();
		//查找图书的总评分和评分数量
		Map<String,Object> scoreCountMap = bookscoreService.findCountEx(bookEntity.getId(),0);
		Object[] scoreCountObjectArray = new Object[]{0,0};
		if(scoreCountMap!=null && scoreCountMap.size()>0){
			if(scoreCountMap.get("count")!=null && !scoreCountMap.get("count").equals("")){
				scoreCountObjectArray[0] = scoreCountMap.get("count");
			}
			if(scoreCountMap.get("totalscore")!=null && !scoreCountMap.get("totalscore").equals("")){
				scoreCountObjectArray[1] = scoreCountMap.get("totalscore");
			}
		}
		//评分数量
		scoreAnalysisTool.setScoreCount(Integer.parseInt(scoreCountObjectArray[0].toString()));
		//总评分
		scoreAnalysisTool.setSumScore(Integer.parseInt(scoreCountObjectArray[1].toString()));
		//具体评分分析集合
		List<CurScoreAnalysisTool> curScoreAnalysisToolList = new ArrayList<CurScoreAnalysisTool>();
		//遍历评分倒序
		for(int i=5;i>0;i--){
			CurScoreAnalysisTool curScoreAnalysisTool = new CurScoreAnalysisTool();
			Map<String,Object> scoreCountMapTemp = bookscoreService.findCountEx(bookEntity.getId(),i);
			Object[] scoreCountObjectArrayTemp = new Object[]{0,0};
			if(scoreCountMapTemp!=null && scoreCountMapTemp.size()>0){
				if(scoreCountMapTemp.get("count")!=null && !scoreCountMapTemp.get("count").equals("")){
					scoreCountObjectArrayTemp[0] = scoreCountMapTemp.get("count");
				}
				if(scoreCountMapTemp.get("totalscore")!=null && !scoreCountMapTemp.get("totalscore").equals("")){
					scoreCountObjectArrayTemp[1] = scoreCountMapTemp.get("totalscore");
				}
			}
			curScoreAnalysisTool.setCurScore(i);
			curScoreAnalysisTool.setScoreCount(Integer.parseInt(scoreCountObjectArrayTemp[0].toString()));
			curScoreAnalysisTool.setPercent(scoreAnalysisTool.getScoreCount());
			curScoreAnalysisToolList.add(curScoreAnalysisTool);
		}
		scoreAnalysisTool.setCurScoreAnalysisToolList(curScoreAnalysisToolList);
		request.setAttribute("scoreAnalysisTool",scoreAnalysisTool);
		return "user/book/detail";
	}

}