package com.bookrecommendonline.entity;

/**
 * 图书收藏实体类
 * BookcollectMapper.xml配置文件 将对应图书收藏表db_bookcollect的查询结果 封装成图书收藏实体类
 */
public class BookcollectEntity extends BaseEntity{
	
	private static final long serialVersionUID = 1L;

	private Integer id;//主键

    private Integer userid;//用户外键

    private Integer bookid;//图书外键

    private String createtime;//添加时间
    
    private BookEntity bookEntity;//图书对象
    
    private UserEntity userEntity;//用户对象

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public Integer getBookid() {
        return bookid;
    }

    public void setBookid(Integer bookid) {
        this.bookid = bookid;
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

	public BookEntity getBookEntity() {
		return bookEntity;
	}

	public void setBookEntity(BookEntity bookEntity) {
		this.bookEntity = bookEntity;
	}

	public UserEntity getUserEntity() {
		return userEntity;
	}

	public void setUserEntity(UserEntity userEntity) {
		this.userEntity = userEntity;
	}
    
}