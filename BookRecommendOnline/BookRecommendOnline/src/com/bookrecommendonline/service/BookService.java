package com.bookrecommendonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookrecommendonline.entity.BookEntity;
import com.bookrecommendonline.mapper.BookMapper;

/**
 * 图书service业务类，继承 泛型基础service
 * 调用不同mapper可以进行一些复杂业务处理
 */
@Service
public class BookService extends BaseService<BookEntity>{

	@Autowired
	private BookMapper bookMapper;//注入图书mapper
	
	/**
	 * 批量删除
	 * @param idArray
	 * @return
	 */
	public int deleteBatch(String[] idArray){
		int success = 0;
		for(String id:idArray){
			success = bookMapper.deleteByPrimaryKey(Integer.parseInt(id));
			if(success!=1){
				return success;
			}
		}
		return success;
	}
	
	/**
	 * 相关推荐，根据总评分降序查找同类型下图书，同时不包括当前登录用户评分过的图书
	 * @param booktypeid
	 * @param userid
	 * @return
	 */
	public List<BookEntity> findRelateByUserid(Integer cbookid, Integer booktypeid, Integer userid){
		return bookMapper.findRelateByUserid(cbookid, booktypeid, userid);
	}
	
	/**
	 * 查找热点图书，根据登录用户喜好标签下的图书的总评分降序输出，同时不包括当前登录用户评分过的图书
	 * @param userid
	 * @return
	 */
	public List<BookEntity> findHotByBookscore(Integer userid){
		return bookMapper.findHotByBookscore(userid);
	}
	
	/**
	 * 查找热点图书，根据登录用户喜好标签下的图书的收藏数量降序输出，同时不包括当前登录用户收藏过的图书
	 * @param userid
	 * @return
	 */
	public List<BookEntity> findHotByBookcollect(Integer userid){
		return bookMapper.findHotByBookcollect(userid);
	}
	
	/**
	 * 热点榜单，查询浏览数量最多的图书，同时不包括当前登录用户浏览过的图书
	 * @param userid
	 * @return
	 */
	public List<BookEntity> findTopByBooklook(Integer userid){
		return bookMapper.findTopByBooklook(userid);
	}
	
}
