package com.bookrecommendonline.entity;

/**
 * 图书实体类
 * BookMapper.xml配置文件 将对应图书表db_book的查询结果 封装成图书实体类
 */
public class BookEntity extends BaseEntity{
	
	private static final long serialVersionUID = 1L;
	
    private Integer id;//主键

    private String bookname;//图书名称

    private Integer booktypeid;//图书类型外键

    private String image;//图书封面
    
    private String author;//作者

    private String press;//出版社

    private String price;//价格

    private String isbn;//isbn

    private String createtime;//添加时间

    private String doubanid;//豆瓣网站图书id

    private String content;//图书简介
    
    private BooktypeEntity booktypeEntity;//图书类型对象
    
    private Long avgscore;//平均评分
    
    private Integer countlook;//浏览次数

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBookname() {
        return bookname;
    }

    public void setBookname(String bookname) {
        this.bookname = bookname == null ? null : bookname.trim();
    }

    public Integer getBooktypeid() {
        return booktypeid;
    }

    public void setBooktypeid(Integer booktypeid) {
        this.booktypeid = booktypeid;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image == null ? null : image.trim();
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author == null ? null : author.trim();
    }

    public String getPress() {
        return press;
    }

    public void setPress(String press) {
        this.press = press == null ? null : press.trim();
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price == null ? null : price.trim();
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn == null ? null : isbn.trim();
    }

    public String getDoubanid() {
        return doubanid;
    }

    public void setDoubanid(String doubanid) {
        this.doubanid = doubanid == null ? null : doubanid.trim();
    }

    public String getCreatetime() {
        return createtime;
    }

    public void setCreatetime(String createtime) {
        this.createtime = createtime == null ? null : createtime.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

	public BooktypeEntity getBooktypeEntity() {
		return booktypeEntity;
	}

	public void setBooktypeEntity(BooktypeEntity booktypeEntity) {
		this.booktypeEntity = booktypeEntity;
	}

	public Long getAvgscore() {
		return avgscore;
	}

	public void setAvgscore(Long avgscore) {
		this.avgscore = avgscore;
	}

	public Integer getCountlook() {
		return countlook;
	}

	public void setCountlook(Integer countlook) {
		this.countlook = countlook;
	}
	
}