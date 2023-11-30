package com.bookrecommendonline.mapper;

import java.util.List;

import com.bookrecommendonline.entity.BookcommentEntity;

/**
 * 图书评论mapper，继承 泛型基础mapper
 * 与 resources下的mapper下的BookcommentMapper.xml文件相映射
 */
public interface BookcommentMapper extends BaseMapper<BookcommentEntity>{
	
    /**
     * 带参数关联查询，同时关联 评分记录数据 
     * @param params
     * @return
     */
    List<BookcommentEntity> findJoinEx(List<Object[]> params);
    
}