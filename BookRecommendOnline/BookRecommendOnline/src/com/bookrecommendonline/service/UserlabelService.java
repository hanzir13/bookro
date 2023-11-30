package com.bookrecommendonline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bookrecommendonline.entity.BooktypeEntity;
import com.bookrecommendonline.entity.UserEntity;
import com.bookrecommendonline.entity.UserlabelEntity;
import com.bookrecommendonline.mapper.UserlabelMapper;
import com.bookrecommendonline.tool.DateTool;

/**
 * 用户喜好标签service业务类，继承 泛型基础service
 * 调用不同mapper可以进行一些复杂业务处理
 */
@Service
public class UserlabelService extends BaseService<UserlabelEntity>{
	
	@Autowired
	private UserlabelMapper userlabelMapper;//注入喜好标签mapper
	
	/**
	 * 保存
	 * @param userEntity
	 * @param booktypeids 
	 * @return
	 */
	public Integer save(UserEntity userEntity,String booktypeids){
		int success = 0;
		String[] typeid = booktypeids.split(",");
		for(String str:typeid){
			BooktypeEntity booktypeEntity = new BooktypeEntity();
			booktypeEntity.setId(Integer.parseInt(str));
			UserlabelEntity labelrecord = new UserlabelEntity();
			labelrecord.setUserid(userEntity.getId());
			labelrecord.setBooktypeid(booktypeEntity.getId());
			labelrecord.setCreatetime(DateTool.getCurrentDate());
			success = userlabelMapper.insertSelective(labelrecord);
		}
		return success;
	}
	
	/**
	 * 修改
	 * @param userEntity
	 * @param booktypeids
	 * @return
	 */
	public Integer update(UserEntity userEntity,String booktypeids){
		int success = 0;
		success = userlabelMapper.deleteByUserid(userEntity.getId());
		String[] typeid = booktypeids.split(",");
		for(String str:typeid){
			BooktypeEntity booktypeEntity = new BooktypeEntity();
			booktypeEntity.setId(Integer.parseInt(str));
			UserlabelEntity labelrecord = new UserlabelEntity();
			labelrecord.setUserid(userEntity.getId());
			labelrecord.setBooktypeid(booktypeEntity.getId());
			labelrecord.setCreatetime(DateTool.getCurrentDate());
			success = userlabelMapper.insertSelective(labelrecord);
		}
		return success;
	}
	
	/**
	 * 批量删除
	 * @param idArray
	 * @return
	 */
	public int deleteBatch(String[] idArray){
		int success = 0;
		for(String id:idArray){
			success = userlabelMapper.deleteByPrimaryKey(Integer.parseInt(id));
			if(success<1){
				return success;
			}
		}
		return success;
	}

}
