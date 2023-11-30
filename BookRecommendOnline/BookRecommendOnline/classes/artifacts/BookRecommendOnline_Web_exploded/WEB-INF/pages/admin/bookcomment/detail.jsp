<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<title>管理员-在线图书推荐网</title>
		<%@ include file="../public/css.jsp"%>
		<%@ include file="../public/js.jsp"%>
		<style type="text/css">
			/* 			评论内容图片样式修改 */
			.bookcomment img{
				max-width: 100px;
				max-width: 100px
			}
		</style>
	</head>
	<body>
		<main class="ftdms-layout-content">
      		<div class="container-fluid" style="margin-bottom:90px;">
		        <div class="row" style="margin-top:15px;">
		          	<div class="col-lg-12">
			            <div class="card">
			            	<div class="card-header"><h4>评论信息</h4></div>
				        	<div class="card-body">
				                <form action="" method="post" id="form" class="row">
				                	<input name="id" value="${user.id }" type="hidden" >
				                  	<div class="form-group col-md-12">
				                    	<%--@declare id="title"--%><label for="title">用户名</label>
				                    	<input type="text" class="form-control" 
				                    		name="username" value="${bookcomment.userEntity.username }" 
				                    		disabled="disabled" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">图书名称</label>
				                    	<input type="text" class="form-control" 
				                    		name="username" value="${bookcomment.bookEntity.bookname }" 
				                    		disabled="disabled" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">评论内容</label>
				                    	<div class="bookcomment" style="word-break: break-word;">
									      	${bookcomment.content }
									    </div>
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">评论时间</label>
				                    	<input type="text" class="form-control" 
				                    		value="${bookcomment.createtime }" disabled="disabled">
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<button type="button" class="btn btn-info" onclick="javascript:history.back(-1);return false;">返 回</button>
				                  	</div>
				                </form>
				       		</div>
			            </div>
		          	</div>
		        </div>
      		</div>
    	</main>
	</body>
</html>