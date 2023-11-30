package com.bookrecommendonline.mapper;

import java.util.List;

import com.bookrecommendonline.entity.BookEntity;

/**
 * 图书mapper，继承 泛型基础mapper
 * 与 resources下的mapper下的BookMapper.xml文件相映射
 */
public interface BookMapper extends BaseMapper<BookEntity>{
    
	/**
	 * 相关推荐，根据总评分降序查找同类型下图书，同时不包括当前登录用户评分过的图书
	 * @param booktypeid
	 * @param userid
	 * @return
	 */
	List<BookEntity> findRelateByUserid(Integer cbookid, Integer booktypeid, Integer userid);
	
	/**
	 * 查找热点图书，根据登录用户喜好标签下的图书的总评分降序输出，同时不包括当前登录用户评分过的图书
	 * @param userid
	 * @return
	 */
	List<BookEntity> findHotByBookscore(Integer userid);
	
	/**
	 * 查找热点图书，根据登录用户喜好标签下的图书的收藏数量降序输出，同时不包括当前登录用户收藏过的图书
	 * @param userid
	 * @return
	 */
	List<BookEntity> findHotByBookcollect(Integer userid);
	
	/**
	 * 热点榜单，查询浏览数量最多的图书，同时不包括当前登录用户浏览过的图书
	 * @param userid
	 * @return
	 */
	List<BookEntity> findTopByBooklook(Integer userid);
	
}