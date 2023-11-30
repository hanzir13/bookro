<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<title>管理员-在线图书推荐网</title>
		<%@ include file="./public/css.jsp"%>
		<%@ include file="./public/js.jsp"%>
		<style>
			.loginpage {
			    position: relative;
			}
			.login {
			    display: flex !important;
			    min-height: 100vh;
			    align-items: center !important;
			    justify-content: center !important;
			}
			.login-center {
			    background: #9cfae08c;
			    min-width: 58rem;
			    padding: 3em 3em;
			    border-radius: 5px;
			    margin: 2em 0;
			}
			.login-header {
			    margin-bottom: 2rem !important;
			}
			.login-center .has-feedback.feedback-left .form-control {
			    padding-left: 38px;
			    padding-right: 12px;
			}
			.login-center .has-feedback.feedback-left .form-control-feedback {
			    left: 0;
			    right: auto;
			    width: 38px;
			    height: 38px;
			    line-height: 38px;
			    z-index: 4;
			    color: #dcdcdc;
			}
			.login-center .has-feedback.feedback-left.row .form-control-feedback {
			    left: 15px;
			}
		</style>
	</head>
	<body style="background:url(${pageContext.request.contextPath}/static/images/admin-login-bg.jpeg) repeat center;
    	background-size: cover;">
		<div class="loginpage">
		  	<div class="login">
			    <div class="login-center">
			      	<div class="login-header text-center">
			        	<a href="${pageContext.request.contextPath}/" >
			        		<img src="${pageContext.request.contextPath}/static/images/logo.jpg" 
			        			style="width:44px;height:44px;border-radius:4px">
			        			&nbsp;&nbsp;
			        			<span style="font-size: 28px;color:#b02a37;vertical-align: middle;">在 线 图 书 推 荐 网</span>
			        	</a>
			        	<div style="font-size: 20px;color:#4d5259;margin-top: 10px;">后台管理系统</div>
			      	</div>
			      	<form action="admin/doLogin" id="form" method="post">
				        <div class="form-group has-feedback feedback-left">
				          	<input type="text" placeholder="请输入用户名" class="form-control" 
				          		name="username" id="username" value="admin" maxlength="255" 
				          		style="color:#192c4c;background-color: #9cfae08c;border-color: #80baaa8c;height:44px">
				          	<span class="ftsucai-65 form-control-feedback" aria-hidden="true" style="color:#a19999"></span>
				        </div>
				        <div class="form-group has-feedback feedback-left">
				          	<input type="password" placeholder="请输入密码" class="form-control" id="password" name="password"
				          		value="admin" maxlength="255" 
				          		style="color:#192c4c;background-color: #9cfae08c;border-color: #80baaa8c;height:44px">
				          	<span class="ftsucai-216 form-control-feedback" aria-hidden="true" style="color:#a19999"></span>
				        </div>
				        <div class="form-group has-feedback feedback-left row">
				          	<div class="col-xs-7">
				          	  	<input type="text" name="valcode" id="valcode" class="form-control" value=""
				          	  		maxlength="4" placeholder="请输入验证码" autocomplete="off" 
				          	  		style="color:#192c4c;background-color: #9cfae08c;border-color: #80baaa8c;height:44px">
				            	<span class="ftsucai-mao form-control-feedback" aria-hidden="true" style="color:#a19999"></span>
				          	</div>
				          	<div class="col-xs-5">
				            	<img src="" class="pull-left" id="valcodeImg" 
				            		style="cursor: pointer;" 
				            		onclick="changeValCode()" title="点击刷新" alt="验证码">
				          	</div>
				        </div>
				        <div class="form-group" style="margin-top: 40px;">
				          	<button class="btn btn-block btn-danger" id="submitBtn" type="button" 
				          		style="font-size: 16px;height: 44px;"
				          		>立即登录</button>
				        </div>
			      	</form>
			    </div>
		  	</div>
		</div>
	</body>
	<script>
		//更换验证码
		function changeValCode(){
			var valcodeImg = document.getElementById("valcodeImg");
			valcodeImg.src="${pageContext.request.contextPath}/admin/public/doValCode?"+new Date().getTime();
		}
	
		$(function(){
			changeValCode();//获取验证码
			$("#submitBtn").on("click",function(){
				var temp = true;
				$("#form input[type='text']").each(function(){
					if($(this).val()==null || $(this).val()==""){
						temp = false;
						return false;
					}
				});
				if($("#password").val()==null || $("#password").val()==""){
					temp = false;
				}
				if(!temp){
					layer.msg("数据不能为空!");return false;
				}
				common_ajax_other($("#form").attr("action"),$("#form").serialize());
// 				changeValCode();//获取验证码
			});
		});
    </script>
</html>