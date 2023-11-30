package com.bookrecommendonline.mapper;

import java.util.List;

import com.bookrecommendonline.entity.BooktypeEntity;

/**
 * 图书类型mapper，继承 泛型基础mapper
 * 与 resources下的mapper下的BooktypeMapper.xml文件相映射
 */
public interface BooktypeMapper extends BaseMapper<BooktypeEntity>{
	
	/**
	 * 排行榜，查询浏览数量较多的图书类型
	 * @return
	 */
	List<BooktypeEntity> findTopByBooklook();
    
}