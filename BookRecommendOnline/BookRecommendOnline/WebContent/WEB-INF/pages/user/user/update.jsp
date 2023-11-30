<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>信息修改-在线图书推荐网</title>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/static/layui/css/layui.css">
		<%@ include file="../public/css.jsp"%>
		<%@ include file="../public/js.jsp"%>
		<script src="${pageContext.request.contextPath}/static/layui/layui.js"></script>
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
                            	<form class="" action="user/user/doUpdate" method="post" id="form" >
	                                <div class="row">
	                                    <div class="col-sm-12 mb-3">
	                                        <%--@declare id="formfile"--%><label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	用户名：
	                                        </label>
	                                        <input type="text" value="${user.username }" 
												name="username" id="username" maxlength="255" placeholder="请输入用户名"
												style="display: inline-block;width:70%;cursor: not-allowed;" readonly="readonly" 
												disabled="disabled" class="form-control">
	                                    </div>
	                                    <div class="col-sm-12 mb-3">
	                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	头像：
	                                        </label>
	                                        <div class="layui-upload" style="display: inline-block;width:70%;">
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
	                                    <div class="col-sm-12 mb-3">
	                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	电话：
	                                        </label>
	                                        <input type="text" placeholder="请输入电话" maxlength="11"
                                                oninput = "value=value.replace(/[^\d]/g,'')"
												name="phone" id="phone" value="${user.phone }"
												style="display: inline-block;width:70%" class="form-control">
	                                    </div>
	                                    <div class="col-sm-12 mb-3">
	                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	邮箱：
	                                        </label>
	                                        <input type="text" placeholder="请输入邮箱" 
												name="email" id="email" maxlength="255" value="${user.email }"
												style="display: inline-block;width:70%" class="form-control">
	                                    </div>
	                                    <div class="col-sm-12 mb-3">
	                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	年龄：
	                                        </label>
	                                        <input type="text" placeholder="请输入年龄" 
									      		oninput = "value=value.replace(/[^\d]/g,'')"
												name="age" id="age" maxlength="2" value="${user.age }" 
												style="display: inline-block;width:70%" class="form-control">
	                                    </div>
	                                    <div class="col-sm-12 mb-3">
	                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	性别：
	                                        </label>
	                                        <label class="" style="display: inline-block;">
											  	<input type="radio" name="gender" value="1" 
						      						${user.gender==1?'checked="checked"':'' }
											  		style="display: inline-block;width:auto"> 男
											</label>
											&nbsp;&nbsp;&nbsp;&nbsp;
											<label class="" style="display: inline-block;">
											  	<input type="radio" name="gender" value="2" 
						      						${user.gender==2?'checked="checked"':'' } 
											  		style="display: inline-block;width:auto"> 女
											</label>
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
		<script src="${pageContext.request.contextPath}/static/js/uploadfile_public.js"></script>
		<script type="text/javascript">
			//使用layer文件上传组件
			layui.use(['form', 'upload', 'element'], function(){
			  	var form = layui.form;
			  	var layer = layui.layer;
			  	var upload = layui.upload;
			  	var element = layui.element;
			  	
			  	//文件上传
			  	upload_image("header", upload, element, 'user/public/upload');
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
	                if($("#form").find("input[type='radio']:checked").length == 0){
		                temp = false;
		            }
	                if(!temp){
	                    layer.msg("修改信息不能为空！");return false;
	                }
	                //对头像进行验证
	                var header = $("#header").val();
	                if(header==null || header==""){
	                	layer.msg("请上传头像！");return false;
	                }
	                //设置正则表达式的手机号码格式 规则 ^起点 $终点 1第一位数是必为1  [3-9]第二位数可取3-9的数字  \d{9} 匹配9位数字 
	                var phoneReg = /^1[3-9]\d{9}$/;
	                if(!phoneReg.test($("#phone").val())){
	                    layer.msg("手机格式不正确！");return false;
	                }
	                //对电子邮件的验证
	                var emailreg = /^([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+@([a-zA-Z0-9]+[_|\_|\.]?)*[a-zA-Z0-9]+\.[a-zA-Z]{2,3}$/;
	                if(!emailreg.test($("#email").val())){
	                    layer.msg("邮箱格式不正确！");return false;
	                }
	                //验证年龄：1-99
	                var age = parseInt($("#age").val());
	                if(age<1 || age>99){
	                	layer.msg("年龄范围不正确！");return false;
	                }
	                
	                common_ajax_other($("#form").attr("action"),$("#form").serialize());
		        });
		    });
		</script>
	</body>
</html>