package com.bookrecommendonline.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookrecommendonline.entity.BooktypeEntity;
import com.bookrecommendonline.mapper.BooktypeMapper;

/**
 * 图书类型service业务类，继承 泛型基础service
 * 调用不同mapper可以进行一些复杂业务处理
 */
@Service
public class BooktypeService extends BaseService<BooktypeEntity>{

	@Autowired
	private BooktypeMapper booktypeMapper;//注入图书类型mapper
	
	/**
	 * 批量删除
	 * @param idArray
	 * @return
	 */
	public int deleteBatch(String[] idArray){
		int success = 0;
		for(String id:idArray){
			success = booktypeMapper.deleteByPrimaryKey(Integer.parseInt(id));
			if(success<1){
				return success;
			}
		}
		return success;
	}
	
	/**
	 * 排行榜，查询浏览数量较多的图书类型
	 * @return
	 */
	public List<BooktypeEntity> findTopByBooklook(){
		return booktypeMapper.findTopByBooklook();
	}
	
}
