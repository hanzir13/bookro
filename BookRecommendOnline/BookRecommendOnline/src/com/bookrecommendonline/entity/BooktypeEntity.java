package com.bookrecommendonline.entity;

/**
 * 图书类型实体类
 * BookTypeMapper.xml配置文件 将对应图书类型表db_booktype的查询结果 封装成图书类型实体类
 */
public class BooktypeEntity extends BaseEntity{
	
	private static final long serialVersionUID = 1L;
	
    private Integer id;//主键

    private String typename;//图书类型名称

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename == null ? null : typename.trim();
    }
}