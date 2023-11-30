package com.bookrecommendonline.entity;

/**
 * 用户兴趣标签实体类
 * UserlabelMapper.xml配置文件 将对应用户兴趣标签表db_userlabel的查询结果 封装成用户兴趣标签实体类
 */
public class UserlabelEntity extends BaseEntity{
	
	private static final long serialVersionUID = 1L;

	private Integer id;//主键

    private Integer userid;//用户外键

    private Integer booktypeid;//图书类型外键

    private String createtime;//添加时间
    
    private BooktypeEntity booktypeEntity;//图书类型对象
    
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

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

	public Integer getBooktypeid() {
		return booktypeid;
	}

	public void setBooktypeid(Integer booktypeid) {
		this.booktypeid = booktypeid;
	}

	public BooktypeEntity getBooktypeEntity() {
		return booktypeEntity;
	}

	public void setBooktypeEntity(BooktypeEntity booktypeEntity) {
		this.booktypeEntity = booktypeEntity;
	}

	public UserEntity getUserEntity() {
		return userEntity;
	}

	public void setUserEntity(UserEntity userEntity) {
		this.userEntity = userEntity;
	}

}