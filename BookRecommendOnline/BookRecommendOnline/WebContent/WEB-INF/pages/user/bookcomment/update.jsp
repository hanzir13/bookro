<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>评论修改-在线图书推荐网</title>
		<%@ include file="../public/css.jsp"%>
		<%@ include file="../public/js.jsp"%>
	</head>
	<body>
		<%@ include file="../public/header.jsp"%>
		<%@ include file="../public/banner2.jsp"%>
		<div class="" style="padding-top:40px;padding-bottom: 3.75rem;">
            <div class="container">
                <div class="row">
                    <%@ include file="../public/menu.jsp"%>
                    <div class="col-lg-8 col-xxl-9" style="width:72%">
                        <div class="card mb-5" style="border-radius:unset">
                            <div class="card-body">
                            	<form class="" action="user/bookcomment/doAddOrUpdate" method="post" id="form" >
                            		<input type="hidden" name="id" value="${bookcomment.id }">
	                                <div class="row">
	                                    <div class="col-sm-12 mb-3">
	                                        <%--@declare id="formfile"--%><label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	图书名称：
	                                        </label>
	                                        <input type="text" value="${bookcomment.bookEntity.bookname }" 
												name="bookname" id="bookname" maxlength="255" placeholder="请输入图书名称"
												style="display: inline-block;width:70%;cursor: not-allowed;" readonly="readonly" 
												disabled="disabled" class="form-control">
	                                    </div>
	                                    <div class="col-sm-12 mb-3">
	                                        <label for="formFile" class="form-label text-dark" 
	                                        	style="font-size:0.93rem;width:15%;vertical-align: top;">
	                                        	评论内容：
	                                        </label>
	                                        <div class="" style="display: inline-block;width:80%;">
	                                        	<textarea id="UEcontainer" style="display: inline-block;width:100%">${bookcomment.content }</textarea>
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
														   initialFrameHeight:300,
														   initialFrameWidth:'100%',
														   initialContent:"请输入评论内容...",
														   textarea:"content",//提交表单属性名称
														   maximumWords:1000,
													});
													//富文本框结束
												</script>
	                                        </div>
	                                    </div>
	                                    <div class="col-sm-12 mb-3">
	                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	评论时间：
	                                        </label>
	                                        <input type="text" value="${bookcomment.createtime }" 
												name="createtime" id="createtime" maxlength="255" 
												style="display: inline-block;width:70%;cursor: not-allowed;" readonly="readonly" 
												disabled="disabled" class="form-control">
	                                    </div>
	                                    <div class="col-12 pt-2">
	                                        <button type="button" class="btn btn-primary" id="submitBtn">
	                                        	&nbsp;&nbsp;&nbsp;&nbsp;保存信息&nbsp;&nbsp;&nbsp;&nbsp;
	                                        </button>
	                                    </div>
	                                </div>
	                        	</form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<%@ include file="../public/footer.jsp"%>
		<script type="text/javascript">
			pathname = "${pageContext.request.contextPath}/user/bookcomment/list";
			
			$(function(){
	        	$("#submitBtn").on("click",function(){
// 	        		var content = document.getElementsByName("content")[0].value;
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
						common_ajax_other($("#form").attr("action"), $("#form").serialize());
					}
		        });
		    });
		</script>
	</body>
</html>