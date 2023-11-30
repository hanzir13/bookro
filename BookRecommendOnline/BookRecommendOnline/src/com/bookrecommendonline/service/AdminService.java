package com.bookrecommendonline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookrecommendonline.entity.AdminEntity;
import com.bookrecommendonline.mapper.AdminMapper;

/**
 * 管理员service业务类，继承 泛型基础service
 * 调用不同mapper可以进行一些复杂业务处理
 */
@Service
public class AdminService extends BaseService<AdminEntity>{

	@Autowired
	private AdminMapper adminMapper;//注入管理员mapper
	
	/**
	 * 批量删除
	 * @param idArray
	 * @param cid
	 * @return
	 */
	public int deleteBatch(String[] idArray, Integer cid){
		int success = 0;
		for(String id:idArray){
			if(Integer.parseInt(id)==cid){//当前管理员不能删除自己
				success = 1;
				continue;
			}
			success = adminMapper.deleteByPrimaryKey(Integer.parseInt(id));
			if(success!=1){
				return success;
			}
		}
		return success;
	}
	
}
