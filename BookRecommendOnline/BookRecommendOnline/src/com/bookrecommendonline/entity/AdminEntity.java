package com.bookrecommendonline.entity;

/**
 * 管理员实体类
 * AdminMapper.xml配置文件 将对应管理员表db_admin的查询结果 封装成管理员实体类
 */
public class AdminEntity extends BaseEntity{
	
	private static final long serialVersionUID = 1L;

	private Integer id;//主键

    private String username;//管理员登录名

    private String phone;//电话

    private String email;//邮箱

    private String password;//管理员登录密码

    private String createtime;//添加时间

    private Integer issuper;//是否是超级管理员（0：不是，1：是）
    
    private String lastlogintime;//最后一次登录时间

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone == null ? null : phone.trim();
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email == null ? null : email.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

    public Integer getIssuper() {
        return issuper;
    }

    public void setIssuper(Integer issuper) {
        this.issuper = issuper;
    }

	public String getLastlogintime() {
		return lastlogintime;
	}

	public void setLastlogintime(String lastlogintime) {
		this.lastlogintime = lastlogintime;
	}
    
}