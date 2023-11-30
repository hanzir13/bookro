<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<title>管理员-在线图书推荐网</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
		<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
		<%@ include file="../public/css.jsp"%>
		<%@ include file="../public/js.jsp"%>
	</head>
	<body>
		<main class="ftdms-layout-content">
      		<div class="container-fluid" style="margin-bottom:90px;">
		        <div class="row" style="margin-top:15px;">
		          	<div class="col-lg-12">
			            <div class="card">
			            	<div class="card-header"><h4>图书新增或修改</h4></div>
				        	<div class="card-body">
				                <form action="admin/book/doAddOrUpdate" method="post" id="form" class="row">
				                	<input name="id" value="${book.id }" type="hidden" >
				                  	<div class="form-group col-md-12">
				                    	<%--@declare id="title"--%><label for="title">图书名称</label>
				                    	<input type="text" class="form-control" maxlength="255"
				                    		name="bookname" value="${book.bookname }" placeholder="请输入图书名称" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">图书类型</label>
				                    	<select name="booktypeid" class="form-control" id="booktypeid">
                        					<option value="0">请选择图书类型</option>
									        <c:if test="${booktypeList!=null && booktypeList.size()>0 }">
					              				<c:forEach var="booktype" items="${booktypeList }" varStatus="status">
				                                	<option value="${booktype.id }" ${booktype.id==book.booktypeid?"selected='selected'":"" }>
				                                		${booktype.typename }
				                                	</option>
					                        	</c:forEach>
											</c:if>
                      					</select>
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">图书图片</label>
				                    	<div class="">
											<div class="layui-upload">
											  	<button type="button" class="layui-btn layui-btn-danger" id="uploadFile">
											  		<i class="layui-icon"></i>上传图片
											  	</button>
											  	<input class="layui-upload-file" type="file" accept="" name="file">
											  	<div class="layui-inline layui-word-aux">
												  	大小10MB以内
												</div>
											  	<div class="layui-upload-list">
											  		<input name="image" id="image" value="${book.image }" type="hidden" lay-verify="image"/>
											    	<img class="layui-upload-img" id="showImage" 
											    		<c:if test="${book.image!=null && book.image!=''}">src="/${appMediaUrl }/${book.image}"</c:if>
											    		style="width:100px;height:100px;">
											   		<p id="imageText"></p>
											  	</div>
											  	<div style="width: 50%;">
											    	<div class="layui-progress layui-progress-big" lay-showpercent="yes" lay-filter="uploadProgress">
											      		<div class="layui-progress-bar" lay-percent=""><span class="layui-progress-text"></span></div>
											    	</div>
											  	</div>
											</div>
									    </div>
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">作者</label>
				                    	<input type="text" class="form-control" maxlength="255"
				                    		name="author" value="${book.author }" placeholder="请输入作者" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">出版社</label>
				                    	<input type="text" class="form-control" maxlength="255"
				                    		name="press" value="${book.press }" placeholder="请输入出版社" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">价格</label>
				                    	<input type="text" class="form-control" maxlength="8" id="price"
				                    		name="price" value="${book.price }" placeholder="请输入价格" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">ISBN</label>
				                    	<input type="text" class="form-control" maxlength="255"
				                    		name="isbn" value="${book.isbn }" placeholder="请输入ISBN" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">图书简介</label>
				                    	<textarea class="form-control" id="content" 
				                    		name="content" rows="5" placeholder="请输入图书简介" maxlength="5000">${book.content }</textarea>
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">豆瓣图书ID</label>
				                    	<input type="text" class="form-control" maxlength="255"
				                    		name="doubanid" value="${book.doubanid }" placeholder="请输入豆瓣图书ID" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                   		<button type="button" class="btn btn-success ajax-post" id="submitBtn">确 定</button>
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
	<script src="${pageContext.request.contextPath}/static/js/uploadfile_public.js"></script>
	<script>
		//使用layui文件上传组件
		layui.use(['upload', 'element'], function(){
		  	var layer = layui.layer;
		  	var upload = layui.upload;
		  	var element = layui.element;
		  	
		  	//图片上传
		  	upload_image("image", upload, element, 'admin/public/upload');
		  	
		});
		
		$(function(){
	    	//提交
	        $("#submitBtn").on("click",function(){
                var temp = true;
                $("#form").find("input[type='text']").each(function(){
                    if($(this).val()==null || $(this).val()==""){
                        temp = false;
                        return false;
                    }
                });
                if(!temp){
                    layer.msg("数据不能为空!");return false;
                }
                if($("#booktypeid").val()==null || $("#booktypeid").val()==""){
                    layer.msg("数据不能为空!");return false;
                }
                if($("#image").val()==null || $("#image").val()==""){
                    layer.msg("请上传图片!");return false;
                }
              	//价格
	            var pricereg = /(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/;
	            if(!pricereg.test($("#price").val())){
	                layer.msg("价格格式不正确!");return false;
	            }
                if($("#content").val()==null || $("#content").val()==""){
                    layer.msg("数据不能为空!");return false;
                }
                common_ajax_other($("#form").attr("action"),$("#form").serialize());
	        });
	    });
	</script>
</html>