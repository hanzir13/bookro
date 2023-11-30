package com.bookrecommendonline.mapper;

import com.bookrecommendonline.entity.UserlabelEntity;

/**
 * 用户喜好标签mapper，继承 泛型基础mapper
 * 与 resources下的mapper下的UserlabelMapper.xml文件相映射
 */
public interface UserlabelMapper extends BaseMapper<UserlabelEntity>{
   
	/**
     * 根据用户id删除
     * @param userid
     * @return
     */
    int deleteByUserid(Integer userid);
    
}