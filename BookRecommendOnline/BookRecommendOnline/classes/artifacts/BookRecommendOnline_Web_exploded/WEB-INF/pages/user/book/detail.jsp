<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>图书详情-在线图书推荐网</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
		<%@ include file="../public/css.jsp"%>
		<%@ include file="../public/js.jsp"%>
		<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
		<style>
/* 			评论内容图片样式修改 */
			.review-body img{
				max-width: 100px;
				max-width: 100px
			}
/* 			layui评分样式修改 */
			.layui-rate{
				margin-bottom:0px;
				margin-left:0px;
			}
			.rating-star i{
				color:#7d879c
			}
		</style>
	</head>
	<body>
		<%@ include file="../public/header.jsp"%>
		<%@ include file="../public/banner2.jsp"%>
		<section class="product-details" style="padding-top:40px">
            <div class="container">
                <div class="row">
                	<div class="col-lg-4">
						<div class="product_view_slider">
							<img src="/${appMediaUrl }/${book.image }"
								style="border-radius: 3px;max-width:100%;max-height: 400px;">
						</div>
					</div>
                    <div class="col-lg-6 ps-lg-5">
                        <div class="product-detail pt-4 pt-lg-0">
                            <div class="products-title mb-2 text-break">
                                <h4 class="h4">${book.bookname }</h4>
                            </div>
                            <div class="rating-star text pb-4">
                                <i class="bi small ${scoreAnalysisTool.avgScore>=1.0?'bi-star-fill active':'bi-star' }"></i>
								<i class="bi small ${scoreAnalysisTool.avgScore>=2.0?'bi-star-fill active':'bi-star' }"></i>
								<i class="bi small ${scoreAnalysisTool.avgScore>=3.0?'bi-star-fill active':'bi-star' }"></i>
								<i class="bi small ${scoreAnalysisTool.avgScore>=4.0?'bi-star-fill active':'bi-star' }"></i>
								<i class="bi small ${scoreAnalysisTool.avgScore>=5.0?'bi-star-fill active':'bi-star' }"></i>
                                <span>${scoreAnalysisTool.avgScore }/5 (${scoreAnalysisTool.scoreCount }个评分)</span>
                            </div>
                            <div class="product-attribute">
                                <label class="fs-6 text-dark pb-2 fw-500 d-block text-break">图书类型：${booktype.typename }</label>
                                <label class="fs-6 text-dark pb-2 fw-500 d-block text-break">作者：${book.author }</label>
                                <label class="fs-6 text-dark pb-2 fw-500 d-block text-break">出版社：${book.press }</label>
                                <label class="fs-6 text-dark pb-2 fw-500 d-block text-break">价格：${book.price }</label>
                                <label class="fs-6 text-dark pb-2 fw-500 d-block text-break">ISBN：${book.isbn }</label>
                                <label class="fs-6 text-dark pb-2 fw-500 d-block text-break">添加时间：${book.createtime }</label>
                            </div>
                            <div class="product-detail-actions d-flex flex-wrap pt-3">
                                <div class="cart-button mb-3 d-flex">
                                    <c:choose>
									<c:when test="${bookcollect==null }">
										<a href="javascript:doCollect(${book.id })" class="btn btn-warning me-3">
	                                        <i class="bi bi-heart"></i> 收藏图书
	                                    </a> 
									</c:when>
										<c:otherwise>
											<a href="javascript:doCollect(${book.id })"
												class="btn btn-warning me-3">
												<i class="bi bi-heart-fill" style="color:#c80b0b"></i> 取消收藏
											</a> 
										</c:otherwise>
									</c:choose>
                                    <a href="https://book.douban.com/subject/${book.doubanid }" target="_blank"
                                    	class="btn btn-success" title="豆瓣图书信息">
                                        <i class="bi bi-link-45deg"></i> 豆瓣图书信息
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
		<section class="pb-4 pt-4">
            <div class="container">
                <div class="product-tabs text-break">
                    <ul class="nav product-nav-tabs" style="justify-content: left;">
                        <li class="nav-item">
                            <a href="javascript:void(0);" class="nav-link active">图书简介</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade active show" >
                            <div class="row">
                                <div class="col-lg-12">
                                    <p>${book.content }</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%@ include file="./relateRecommend.jsp"%>
        <section class="pb-4">
            <div class="container">
                <div class="product-tabs">
                    <ul class="nav product-nav-tabs" style="justify-content: left;">
                        <li class="nav-item">
                            <a href="javascript:void(0);" class="nav-link active">图书评价</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <div class="tab-pane fade active show" >
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="row align-items-end">
                                        <div class="col-lg-12" style="color:#02010a">
                                            <div class="rating-star pb-2">
                                                <i class="bi small ${scoreAnalysisTool.avgScore>=1.0?'bi-star-fill active':'bi-star' }"></i>
												<i class="bi small ${scoreAnalysisTool.avgScore>=2.0?'bi-star-fill active':'bi-star' }"></i>
												<i class="bi small ${scoreAnalysisTool.avgScore>=3.0?'bi-star-fill active':'bi-star' }"></i>
												<i class="bi small ${scoreAnalysisTool.avgScore>=4.0?'bi-star-fill active':'bi-star' }"></i>
												<i class="bi small ${scoreAnalysisTool.avgScore>=5.0?'bi-star-fill active':'bi-star' }"></i>
                                                <span>${scoreAnalysisTool.avgScore }/5 (${scoreAnalysisTool.scoreCount }个评分)</span>
                                            </div>
											<div class="rating-star" style="display: inline-block;">
												<c:forEach var="curScoreAnalysisTool" items="${scoreAnalysisTool.curScoreAnalysisToolList}" varStatus="status">
													<ul class="ul_li mb-2" style="padding-left:0px">
														<li style="display: inline-block;"><span style="width:30px;display: block;">${5-status.index} 星</span></li>
														<li style="display: inline-block;" style="">
															<div class="progress" style="width:400px">
		  														<div class="progress-bar" style="width: ${curScoreAnalysisTool.percent}%;overflow: visible;">
														    		${curScoreAnalysisTool.percent}%
														  		</div>
															</div>
														</li>
														<li style="display: inline-block;" class="">
															<i class="bi small ${curScoreAnalysisTool.curScore>=1.0?'bi-star-fill active':'bi-star' }"></i>
															<i class="bi small ${curScoreAnalysisTool.curScore>=2.0?'bi-star-fill active':'bi-star' }"></i>
															<i class="bi small ${curScoreAnalysisTool.curScore>=3.0?'bi-star-fill active':'bi-star' }"></i>
															<i class="bi small ${curScoreAnalysisTool.curScore>=4.0?'bi-star-fill active':'bi-star' }"></i>
															<i class="bi small ${curScoreAnalysisTool.curScore>=5.0?'bi-star-fill active':'bi-star' }"></i>
														</li>
													</ul>
												</c:forEach>
											</div>
											<div style="display: inline-block;margin-left:80px;vertical-align: top;">
												<div class="product_buttons">
													<span>我的评价：</span>
													<div id="star" class="layui-inline"></div>
												</div>
											</div>
										</div>
                                    </div>
                                    <div class="col-lg-12" style="padding-top:40px">
	                                    <div class="review-form mt-4 mt-lg-0">
	                                        <form action="user/bookcomment/doAddOrUpdate" method="post" id="commentForm">
	                                            <div class="row g-2">
	                                                <div class="col-sm-12">
	                                                	<input type="hidden" name="bookid" value="${book.id }">
	                                                    <textarea id="UEcontainer" maxlength="1000"></textarea>
	                                                </div>
	                                                <div class="col-sm-12 pt-2">
	                                                    <button type="button" class="btn btn-primary" onclick="doComment()">
	                                                    	&nbsp;&nbsp;&nbsp;&nbsp;提交评论&nbsp;&nbsp;&nbsp;&nbsp;
	                                                    </button>
	                                                </div>
	                                            </div>
	                                            <script src="${pageContext.request.contextPath}/static/ueditor/lang/zh-cn/zh-cn.js" type="text/javascript" defer="defer"></script>
												<script type="text/javascript" src="${pageContext.request.contextPath}/static/ueditor/ueditor.config.js"></script>
												<script type="text/javascript" src="${pageContext.request.contextPath}/static/ueditor/ueditor.all.min.js"></script>
												<script type="text/javascript">
													//富文本框开始
													//与滚动效果冲突
													var ueditor = UE.getEditor('UEcontainer', {
														//这里可以选择自己需要的工具按钮名称,此处仅选择如下五个
														   toolbars:[['Source','undo','redo',
														              'fontfamily','fontsize',
																	  'forecolor','backcolor','bold','italic','underline',
																	  'lineheight',
																	  'strikethrough','formatmatch','removeformat','emotion','justifyleft',
																	  'justifyright','justifycenter','justifyjustify',
																	  'link','unlink',
																	  'pasteplain','selectall','time','date','cleardoc',
																	  'spechars',
																	  'simpleupload','insertimage','searchreplace','preview','help','FullScreen',
																	]],
														   //关闭elementPath
														   elementPathEnabled:false,
														   //默认的编辑区域高度
														   initialFrameHeight:200,
														   initialContent:"请输入评论内容...",
														   textarea:"content",//提交表单属性名称
														   maximumWords:1000,
													});
													//富文本框结束
												</script>
	                                        </form>
	                                    </div>
	                                </div>
                                    <c:choose>
			 	  						<c:when test="${pageBean!=null && pageBean.list!=null && pageBean.list.size()>0}">
			 	  							<c:forEach var="bookcomment" items="${pageBean.list}" varStatus="status">
			                                    <div class="d-flex review-box border-top mt-4 pt-4">
			                                        <div>
			                                            <div class="review-image">
			                                                <img class="img-fluid" title="${bookcomment.userEntity.username}" alt="" 
			                                                	src="/${appMediaUrl}/${bookcomment.userEntity.header}">
			                                            </div>
			                                        </div>
			                                        <div class="col ps-3 review-body" style="word-break: break-word;">
			                                            <h6>${bookcomment.userEntity.username}</h6>
			                                            <div class="rating-star">
			                                                <i class="bi small ${bookcomment.bookscoreEntity.score>=1.0?'bi-star-fill active':'bi-star' }"></i>
															<i class="bi small ${bookcomment.bookscoreEntity.score>=2.0?'bi-star-fill active':'bi-star' }"></i>
															<i class="bi small ${bookcomment.bookscoreEntity.score>=3.0?'bi-star-fill active':'bi-star' }"></i>
															<i class="bi small ${bookcomment.bookscoreEntity.score>=4.0?'bi-star-fill active':'bi-star' }"></i>
															<i class="bi small ${bookcomment.bookscoreEntity.score>=5.0?'bi-star-fill active':'bi-star' }"></i>
			                                                <span>&nbsp;&nbsp;&nbsp;&nbsp;${bookcomment.createtime}</span>
			                                            </div>
			                                            <p class="m-0 pt-3" style="word-break: break-word;">
			                                            	${bookcomment.content}
			                                            </p>
			                                        </div>
			                                    </div>
		                                    </c:forEach>
			                        	</c:when>
						     			<c:otherwise>
						     				<div class="d-flex review-box border-top mt-4 pt-4">暂无评论</div>
						     			</c:otherwise>
						   			</c:choose>
						   			<form action="${pageContext.request.contextPath}/user/book/detail?bookid=${book.id}" method="post" id="form">
							  			<input type="hidden" name="pageNum" value="${pageBean.pageNum}" id="pageNum">
							  		</form>
							  		<%@include file="../public/page.jsp" %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
		<%@ include file="../public/footer.jsp"%>
		<script type="text/javascript">
			//layui评分
			layui.use([ 'rate' ],function() {
				var rate = layui.rate;
				rate.render({
					elem : '#star',
					value : "${bookscore.score==null?'':bookscore.score}",
					text : true,
					theme : "#fea569",
					setText : function(value) { //自定义文本的回调
						var arrs = {
							'1' : '1星',
							'2' : '2星',
							'3' : '3星',
							'4' : '4星',
							'5' : '5星',
							'0' : ''
						};
						this.span.text(arrs[value] || "");
					},
					choose : function(value) {//点击回调函数
						if (doIsLogin()) {
							var data = "bookid=${book.id}" + "&score=" + value;
							common_ajax_other("user/bookscore/doAddOrUpdate",data);
						}else{
							this.value = 0;
						}
					}
				});
			});
			
			//添加或者取消收藏
		  	function doCollect(bookid){
		  		if(doIsLogin()){
	            	common_ajax_other("user/bookcollect/doSave","bookid="+bookid);
	            }
		  	}
			
		    //评论
			function doComment(){
// 		    	console.info(ueditor.getContentTxt());
// 		    	console.info(ueditor.getContent());
				var content = ueditor.getContent();
				if(content==null || content=="" || content=="<p>请输入评论内容...</p>"){
					layer.msg("评论内容不能为空！");
					return false;
				}
				if(content.length>1000){
					layer.msg("评论内容已超出字数限制！");
					return false;
				}
				if(doIsLogin()){
					common_ajax_other($("#commentForm").attr("action"), $("#commentForm").serialize());
				}
			}
		</script>
	</body>
</html>