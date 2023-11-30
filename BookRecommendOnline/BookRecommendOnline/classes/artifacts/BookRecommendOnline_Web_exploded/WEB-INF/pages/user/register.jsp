<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>用户注册-在线图书推荐网</title>
		<%@ include file="./public/css.jsp"%>
		<%@ include file="./public/js.jsp"%>
	</head>
	<body>
		<%@ include file="./public/header.jsp"%>
		<%@ include file="./public/banner2.jsp"%>
		<div class="section" style="padding-top: 40px;">
            <div class="container">
                <div class="justify-content-center row">
                    <div class="col-lg-10 col-xxl-6">
                        <div class="card">
                            <div class="card-header bg-transparent py-3">
                                <h3 class="h4 mb-0 text-center" style="font-size:24px;font-weight:500">用户注册</h3>
                            </div>
                            <div class="card-body">
                                <form action="doRegister" method="post" id="form">
                                	<div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group mb-3">
                                                <%--@declare id="email_1"--%><label for="email_1" class="form-label">用户名<span class="text-danger">*</span></label>
                                        		<input type="text" name="username" id="username" maxlength="255" 
                                        			placeholder="请输入用户名" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-3">
                                                <label for="email_1" class="form-label">电话<span class="text-danger">*</span></label>
		                                        <input type="text" placeholder="请输入电话" maxlength="11"
		                                            oninput="value=value.replace(/[^\d]/g,'')"
													name="phone" id="phone" class="form-control">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-3">
                                                <label for="email_1" class="form-label">邮箱<span class="text-danger">*</span></label>
		                                        <input type="text" placeholder="请输入邮箱" 
													name="email" id="email" maxlength="255" class="form-control" >
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-3">
                                                <%--@declare id="exampleinputpassword01"--%><label class="form-label col" for="exampleInputPassword01">密码<span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="请输入密码" 
													name="password" id="password" maxlength="255">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-3">
                                                <label class="form-label col" for="exampleInputPassword01">确认密码<span class="text-danger">*</span></label>
                                                <input type="password" class="form-control" placeholder="请输入确认密码" 
													name="passwordConf" id="passwordConf" maxlength="255">
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group mb-3">
                                                <label class="form-label col" for="exampleInputPassword01">验证码<span class="text-danger">*</span></label>
                                                <div>
			                                        <input type="text" name="valcode" id="valcode" maxlength="4" autocomplete="off" value="" 
			                                        	placeholder="请输入验证码" class="form-control" style="display: inline-block;width:50%">
			                                        <img src="" class="pull-right" id="valcodeImg" 
									            		style="cursor: pointer;display: inline-block;width:auto;margin-left:10px" 
									            		onclick="changeValCode()" title="点击刷新" alt="验证码">
										        </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row align-items-center">
                                        <div class="col">
                                            <button type="button" id="submitBtn" class="btn btn-primary w-50">
                                                	注&nbsp;&nbsp;册
                                            </button>
                                        </div>
                                        <div class="col-12 col-sm text-sm-end mt-3 mt-sm-0">
                                            <span class="text-muted">
                                            	已有账号? <a href="${pageContext.request.contextPath}/login">立即登录</a>
                                            </span>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<%@ include file="./public/footer.jsp"%>
		<script type="text/javascript">
			//更换验证码
			function changeValCode(){
				var valcodeImg = document.getElementById("valcodeImg");
				valcodeImg.src="${pageContext.request.contextPath}/user/public/doValCode?"+new Date().getTime();
			}
		
			jQuery(document).ready(function() {
				changeValCode();//获取验证码
				$("#submitBtn").on("click",function(){
					 var temp = true;
	                $("#form").find("input").each(function(){
	                    if($(this).val()==null || $(this).val()==""){
	                        temp = false;
	                        return false;
	                    }
	                });
	                if(!temp){
	                    layer.msg("用户注册信息不能为空！");return false;
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
					if($("#password").val()!=$("#passwordConf").val()){
						layer.msg("两次密码不一致！");return false;
					}
					common_ajax_other($("#form").attr("action"),$("#form").serialize());
// 					changeValCode();//获取验证码
				});
			});
	    </script>
	</body>
</html>