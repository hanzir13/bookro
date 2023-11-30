package com.bookrecommendonline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookrecommendonline.entity.BookcollectEntity;
import com.bookrecommendonline.mapper.BookcollectMapper;

/**
 * 图书收藏service业务类，继承 泛型基础service
 * 调用不同mapper可以进行一些复杂业务处理
 */
@Service
public class BookcollectService extends BaseService<BookcollectEntity>{

	@Autowired
	private BookcollectMapper bookcollectMapper;//注入图书收藏mapper
	
	/**
	 * 批量删除
	 * @param idArray
	 * @return
	 */
	public int deleteBatch(String[] idArray){
		int success = 0;
		for(String id:idArray){
			success = bookcollectMapper.deleteByPrimaryKey(Integer.parseInt(id));
			if(success!=1){
				return success;
			}
		}
		return success;
	}
	
}
