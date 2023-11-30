package com.bookrecommendonline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.mapper.UserMapper;

/**
 * 用户service业务类，继承 泛型基础service
 * 调用不同mapper可以进行一些复杂业务处理
 */
@Service
public class UserService extends BaseService<UserEntity>{

	@Autowired
	private UserMapper userMapper;//注入用户mapper
	
	/**
	 * 批量删除
	 * @param idArray
	 * @return
	 */
	public int deleteBatch(String[] idArray){
		int success = 0;
		for(String id:idArray){
			success = userMapper.deleteByPrimaryKey(Integer.parseInt(id));
			if(success!=1){
				return success;
			}
		}
		return success;
	}
	
}
