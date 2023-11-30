package com.bookrecommendonline.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookrecommendonline.entity.BookscoreEntity;
import com.bookrecommendonline.mapper.BookscoreMapper;

/**
 * 图书评分service业务类，继承 泛型基础service
 * 调用不同mapper可以进行一些复杂业务处理
 */
@Service
public class BookscoreService extends BaseService<BookscoreEntity>{

	@Autowired
	private BookscoreMapper bookscoreMapper;//注入图书评分mapper
	
	/**
	 * 批量删除
	 * @param idArray
	 * @return
	 */
	public int deleteBatch(String[] idArray){
		int success = 0;
		for(String id:idArray){
			success = bookscoreMapper.deleteByPrimaryKey(Integer.parseInt(id));
			if(success!=1){
				return success;
			}
		}
		return success;
	}
	
	/**
	 * 聚合查询扩展方法，图书评分分析使用
	 * @param bookid
	 * @param score
	 * @return
	 */
	public Map<String,Object> findCountEx(int bookid,int score){
		return bookscoreMapper.findCountEx(bookid, score);
	}
	
	/**
     * 带参数聚合查询,平均评分
     * @param params
     * @return
     */
	public Long findAvg(List<Object[]> params){
		return bookscoreMapper.findAvg(params);
	}
	
}
