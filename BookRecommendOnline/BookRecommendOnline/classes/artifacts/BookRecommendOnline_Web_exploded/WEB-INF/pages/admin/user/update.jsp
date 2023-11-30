<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<title>管理员-在线图书推荐网</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
		<%@ include file="../public/css.jsp"%>
		<%@ include file="../public/js.jsp"%>
		<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
	</head>
	<body>
		<main class="ftdms-layout-content">
      		<div class="container-fluid" style="margin-bottom:90px;">
		        <div class="row" style="margin-top:15px;">
		          	<div class="col-lg-12">
			            <div class="card">
			            	<div class="card-header"><h4>用户修改</h4></div>
				        	<div class="card-body">
				                <form action="admin/user/doUpdate" method="post" id="form" class="row">
				                	<input name="id" value="${user.id }" type="hidden" >
				                  	<div class="form-group col-md-12">
				                    	<%--@declare id="title"--%><label for="title">用户名</label>
				                    	<input type="text" class="form-control" 
				                    		name="username" value="${user.username }" placeholder="请输入用户名" 
				                    		disabled="disabled" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">头像</label>
				                    	<div class="layui-upload" style="width:70%;">
										  	<button type="button" class="layui-btn layui-btn-danger" id="uploadFile">
										  		<i class="layui-icon"></i>上传图片
										  	</button>
										  	<input class="layui-upload-file" type="file" accept="" name="file">
										  	<div class="layui-inline layui-word-aux" style="font-size: 14px">
											  	大小10MB以内
											</div>
										  	<div class="layui-upload-list">
										  		<input name="header" id="header" value="${user.header }" type="hidden" lay-verify="header"/>
										    	<img class="layui-upload-img" id="showImage" 
										    		<c:if test="${user.header!=null && user.header!=''}">src="/${appMediaUrl }/${user.header}"</c:if>
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
				                  	<div class="form-group col-md-12">
				                    	<label for="title">电话</label>
				                    	<input type="text" class="form-control" 
											maxlength="11" oninput="value=value.replace(/[^\d]/g,'')"
											name="phone" id="phone" value="${user.phone }" placeholder="请输入电话">
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">邮箱</label>
				                    	<input type="text" class="form-control" 
				                    		value="${user.email }" name="email" id="email" maxlength="255" placeholder="请输入邮箱">
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">性别</label>
										<div class="clearfix">
					                      	<label class="ftdms-radio radio-inline radio-primary">
					                        	<input type="radio" name="gender" value="1" title="男" 
					                        		${user.gender==1?'checked="checked"':'' }><span>男</span>
					                      	</label>
					                      	<label class="ftdms-radio radio-inline radio-primary">
					                        	<input type="radio" name="gender" value="2" title="女"
					                        		${user.gender==2?'checked="checked"':'' }><span>女</span>
					                      	</label>
					                    </div>
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">年龄</label>
				                    	<input type="text" class="form-control" 
				                    		oninput = "value=value.replace(/[^\d]/g,'')"
											name="age" id="age" maxlength="2" value="${user.age }" placeholder="请输入年龄">
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">注册时间</label>
				                    	<input type="text" class="form-control" 
				                    		value="${user.createtime }" disabled="disabled">
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
		//使用layer文件上传组件
		layui.use(['form', 'upload', 'element'], function(){
		  	var form = layui.form;
		  	var layer = layui.layer;
		  	var upload = layui.upload;
		  	var element = layui.element;
		  	
		  	//文件上传
		  	upload_image("header", upload, element, 'admin/public/upload');
		});
	
		$(function(){
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
	          	//对头像进行验证
                var header = $("#header").val();
                if(header==null || header==""){
                	layer.msg("请上传头像！");return false;
                }
	            //对电话的验证
	            var phonereg = /^1[3-9]\d{9}$/;
	            if(!phonereg.test($("#phone").val())){
	                layer.msg("电话格式不正确!");return false;
	            }
	            //对电子邮件的验证
	            var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	            if(!emailreg.test($("#email").val())){
	                layer.msg("邮箱格式不正确!");return false;
	            }
	            //对性别验证
	            if($("#form").find("input[type='radio']:checked").length == 0){
	            	layer.msg("请选择性别!");return false;
	            }
	            //对年龄验证
	            var age = $("#age").val();
	            if(age==null || age=="" || parseInt(age)<1 || parseInt(age)>99){
	            	layer.msg("年龄范围不正确!");return false;
                }
	            common_ajax_other($("#form").attr("action"),$("#form").serialize());
	        });
	    });
	</script>
</html>