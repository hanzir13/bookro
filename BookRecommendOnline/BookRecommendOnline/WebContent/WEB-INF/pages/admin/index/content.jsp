<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<title>管理员-在线图书推荐网</title>
		<%@ include file="../public/css.jsp"%>
		<%@ include file="../public/js.jsp"%>
	</head>
	<body>
	    <main class="ftdms-layout-content">
	      	<div class="container-fluid" style="margin-bottom:90px;">
	        	<div class="row" style="margin-top:15px;">
	        		<div class="col-lg-12">
		        		<div class="card">
		        			<div class="card-header"><h4>数据统计</h4></div>
		        		</div>
	        		</div>
	          		<div class="col-sm-3">
	            		<div class="card bg-danger">
	              			<div class="card-body clearfix">
				                <div class="pull-left">
				                  	<p class="h6 text-white m-t-0">用户数量</p>
				                  	<p class="h3 text-white m-b-0">${userCount==null?0:userCount }</p>
				                </div>
		                		<div class="pull-right"> 
		                			<span class="img-avatar img-avatar-48 bg-translucent">
		                				<i class="ftsucai-214 fa-1-5x"></i>
		                			</span>
		                		</div>
		             	 	</div>
	            		</div>
	          		</div>
	          		<div class="col-sm-3">
	            		<div class="card bg-warning">
	              			<div class="card-body clearfix">
				                <div class="pull-left">
				                  	<p class="h6 text-white m-t-0">图书类型数量</p>
				                  	<p class="h3 text-white m-b-0">${booktypeCount==null?0:booktypeCount }</p>
				                </div>
		                		<div class="pull-right"> 
		                			<span class="img-avatar img-avatar-48 bg-translucent">
		                				<i class="ftsucai-214 fa-1-5x"></i>
		                			</span>
		                		</div>
		             	 	</div>
	            		</div>
	          		</div>
	          		<div class="col-sm-3">
	            		<div class="card bg-pink">
	              			<div class="card-body clearfix">
				                <div class="pull-left">
				                  	<p class="h6 text-white m-t-0">图书数量</p>
				                  	<p class="h3 text-white m-b-0">${bookCount==null?0:bookCount }</p>
				                </div>
		                		<div class="pull-right"> 
		                			<span class="img-avatar img-avatar-48 bg-translucent">
		                				<i class="ftsucai-214 fa-1-5x"></i>
		                			</span>
		                		</div>
		             	 	</div>
	            		</div>
	          		</div>
	          		<div class="col-sm-3">
	            		<div class="card bg-cyan">
	              			<div class="card-body clearfix">
				                <div class="pull-left">
				                  	<p class="h6 text-white m-t-0">图书评分数量</p>
				                  	<p class="h3 text-white m-b-0">${bookscoreCount==null?0:bookscoreCount }</p>
				                </div>
		                		<div class="pull-right"> 
		                			<span class="img-avatar img-avatar-48 bg-translucent">
		                				<i class="ftsucai-214 fa-1-5x"></i>
		                			</span>
		                		</div>
		             	 	</div>
	            		</div>
	          		</div>
	          		<div class="col-sm-3">
	            		<div class="card bg-info">
	              			<div class="card-body clearfix">
				                <div class="pull-left">
				                  	<p class="h6 text-white m-t-0">图书收藏数量</p>
				                  	<p class="h3 text-white m-b-0">${bookcollectCount==null?0:bookcollectCount }</p>
				                </div>
		                		<div class="pull-right"> 
		                			<span class="img-avatar img-avatar-48 bg-translucent">
		                				<i class="ftsucai-214 fa-1-5x"></i>
		                			</span>
		                		</div>
		             	 	</div>
	            		</div>
	          		</div>
	          		<div class="col-sm-3">
	            		<div class="card bg-success">
	              			<div class="card-body clearfix">
				                <div class="pull-left">
				                  	<p class="h6 text-white m-t-0">图书评论数量</p>
				                  	<p class="h3 text-white m-b-0">${bookcommentCount==null?0:bookcommentCount }</p>
				                </div>
		                		<div class="pull-right"> 
		                			<span class="img-avatar img-avatar-48 bg-translucent">
		                				<i class="ftsucai-214 fa-1-5x"></i>
		                			</span>
		                		</div>
		             	 	</div>
	            		</div>
	          		</div>
	          		<div class="col-sm-3">
	            		<div class="card bg-purple">
	              			<div class="card-body clearfix">
				                <div class="pull-left">
				                  	<p class="h6 text-white m-t-0">用户喜好标签数量</p>
				                  	<p class="h3 text-white m-b-0">${userlabelCount==null?0:userlabelCount }</p>
				                </div>
		                		<div class="pull-right"> 
		                			<span class="img-avatar img-avatar-48 bg-translucent">
		                				<i class="ftsucai-214 fa-1-5x"></i>
		                			</span>
		                		</div>
		             	 	</div>
	            		</div>
	          		</div>
	          		<div class="col-sm-3">
	            		<div class="card bg-yellow">
	              			<div class="card-body clearfix">
				                <div class="pull-left">
				                  	<p class="h6 text-white m-t-0">图书浏览数量</p>
				                  	<p class="h3 text-white m-b-0">${booklookCount==null?0:booklookCount }</p>
				                </div>
		                		<div class="pull-right"> 
		                			<span class="img-avatar img-avatar-48 bg-translucent">
		                				<i class="ftsucai-214 fa-1-5x"></i>
		                			</span>
		                		</div>
		             	 	</div>
	            		</div>
	          		</div>
	        	</div>
	      	</div>
	    </main>
	</body>
</html>