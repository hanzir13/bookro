package com.bookrecommendonline.entity;

/**
 * 用户实体类
 * UserMapper.xml配置文件 将对应用户表db_user的查询结果 封装成用户实体类
 */
public class UserEntity extends BaseEntity{
	
	private static final long serialVersionUID = 1L;
	
    private Integer id;//主键

    private String username;//用户登录名

    private String password;//用户登录密码
    
    private String header;//用户头像

    private Integer gender;//用户性别

    private Integer age;//用户年龄

    private String phone;//电话

    private String email;//邮箱
    
    private String lastlogintime;//最后一次登录时间

    private Integer state;//用户状态（1：正常，2：锁定）

    private String createtime;//添加时间

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public Integer getGender() {
        return gender;
    }

    public void setGender(Integer gender) {
        this.gender = gender;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
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

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getLastlogintime() {
		return lastlogintime;
	}

	public void setLastlogintime(String lastlogintime) {
		this.lastlogintime = lastlogintime;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}
    
}