package com.bookrecommendonline.mapper;

import java.util.List;
import java.util.Map;

import com.bookrecommendonline.entity.BookscoreEntity;

/**
 * 图书评分mapper，继承 泛型基础mapper
 * 与 resources下的mapper下的BookscoreMapper.xml文件相映射
 */
public interface BookscoreMapper extends BaseMapper<BookscoreEntity>{
    
	/**
	 * 聚合查询扩展方法，图书评分分析使用
	 * @param bookid
	 * @param score
	 * @return
	 */
	Map<String,Object> findCountEx(int bookid,int score);
	
	/**
     * 带参数聚合查询,平均评分
     * @param params
     * @return
     */
    Long findAvg(List<Object[]> params);
	
}