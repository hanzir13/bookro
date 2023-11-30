package com.bookrecommendonline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookrecommendonline.entity.BooklookEntity;
import com.bookrecommendonline.mapper.BooklookMapper;

/**
 * 图书浏览service业务类，继承 泛型基础service
 * 调用不同mapper可以进行一些复杂业务处理
 */
@Service
public class BooklookService extends BaseService<BooklookEntity>{

	@Autowired
	private BooklookMapper booklookMapper;//注入图书浏览mapper
	
	/**
	 * 批量删除
	 * @param idArray
	 * @return
	 */
	public int deleteBatch(String[] idArray){
		int success = 0;
		for(String id:idArray){
			success = booklookMapper.deleteByPrimaryKey(Integer.parseInt(id));
			if(success!=1){
				return success;
			}
		}
		return success;
	}
	
}
