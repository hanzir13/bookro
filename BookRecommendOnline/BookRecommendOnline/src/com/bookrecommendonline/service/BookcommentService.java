package com.bookrecommendonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookrecommendonline.entity.BookcommentEntity;
import com.bookrecommendonline.mapper.BookcommentMapper;

/**
 * 图书评论service业务类，继承 泛型基础service
 * 调用不同mapper可以进行一些复杂业务处理
 */
@Service
public class BookcommentService extends BaseService<BookcommentEntity>{

	@Autowired
	private BookcommentMapper bookcommentMapper;//注入图书评论mapper
	
	/**
	 * 批量删除
	 * @param idArray
	 * @return
	 */
	public int deleteBatch(String[] idArray){
		int success = 0;
		for(String id:idArray){
			success = bookcommentMapper.deleteByPrimaryKey(Integer.parseInt(id));
			if(success!=1){
				return success;
			}
		}
		return success;
	}
	
	/**
     * 带参数关联查询，同时关联 评分记录数据 
     * @param params
     * @return
     */
    public List<BookcommentEntity> findJoinEx(List<Object[]> params){
    	return bookcommentMapper.findJoinEx(params);
    }
	
}
