package com.bookrecommendonline.mapper;

import java.util.List;

/**
 * 泛型基础mapper，进行简单的增删改查操作
 * 其他具体mapper继承该泛型基础mapper，并指明实体类T，同时其他具体mapper也可以定义自己需要使用的数据库操作方法
 * 项目启动过程中 mybatis框架会扫描 *Mapper.java文件 与 *Mapper.xml配置文件，
 * 通过 *Mapper.xml配置文件找到*Mapper.java文件，同时会将*Mapper.java中的方法与*Mapper.xml配置文件中的标签绑定，
 * 最终可通过*Mapper.java文件中的方法找到*Mapper.xml配置文件中的标签中的sql语句并执行
 * @param <T>
 */
public interface BaseMapper<T> {

	/**
	 * 根据主键删除
	 * @param id
	 * @return
	 */
	int deleteByPrimaryKey(Integer id);

	/**
	 * 保存数据（全部属性，包含id）
	 * @param t
	 * @return
	 */
    int insert(T t);

    /**
     * 保存数据（不为空属性）
     * @param t
     * @return
     */
    int insertSelective(T t);

    /**
     * 根据主键查询
     * @param id
     * @return
     */
    T selectByPrimaryKey(Integer id);

    /**
     * 根据主键更新数据（不为空属性）
     * @param t
     * @return
     */
    int updateByPrimaryKeySelective(T t);

    /**
     * 根据主键更新数据（全部）
     * @param t
     * @return
     */
    int updateByPrimaryKey(T t);
    
    /**
     * 带参数查询
     * @param params
     * @return
     */
    List<T> find(List<Object[]> params);
    
    /**
     * 带参数关联查询
     * @param params
     * @return
     */
    List<T> findJoin(List<Object[]> params);
    
    /**
     * 带参数查询一个
     * @param params
     * @return
     */
    T findFirst(List<Object[]> params);
    
    /**
     * 带参数关联查询一个
     * @param params
     * @return
     */
    T findFirstJoin(List<Object[]> params);
    
    /**
     * 带参数聚合查询
     * @param params
     * @return
     */
    Long findCount(List<Object[]> params);
	
}
