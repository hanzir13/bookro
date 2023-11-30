package com.bookrecommendonline.entity;

/**
 * 图书评分实体类
 * BookscoreMapper.xml配置文件 将对应图书评分表db_bookscore的查询结果 封装成图书评分实体类
 */
public class BookscoreEntity extends BaseEntity{
	
	private static final long serialVersionUID = 1L;
	
    private Integer id;//主键

    private Integer userid;//用户外键

    private Integer bookid;//图书外键

    private Integer score;//评分

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

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
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