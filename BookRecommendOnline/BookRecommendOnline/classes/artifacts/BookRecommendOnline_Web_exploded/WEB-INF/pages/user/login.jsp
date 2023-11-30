<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>用户登录-在线图书推荐网</title>
		<%@ include file="./public/css.jsp"%>
		<%@ include file="./public/js.jsp"%>
	</head>
	<body>
		<%@ include file="./public/header.jsp"%>
		<%@ include file="./public/banner2.jsp"%>
		<div class="section" style="padding-top: 40px;">
            <div class="container">
                <div class="justify-content-center row">
                    <div class="col-lg-5 col-xxl-4">
                        <div class="card">
                            <div class="card-header bg-transparent py-3">
                                <h3 class="h4 mb-0 text-center" style="font-size:24px;font-weight:500">用户登录</h3>
                            </div>
                            <div class="card-body">
                                <form action="doLogin" method="post" id="form">
                                    <div class="form-group mb-3">
                                        <%--@declare id="email_1"--%><label for="email_1" class="form-label">用户名<span class="text-danger">*</span></label>
                                        <input type="text" name="username" id="username" maxlength="255" 
                                        	placeholder="请输入用户名" class="form-control" value="">
                                    </div>
                                    <div class="form-group mb-3">
                                        <div class="row align-items-center">
                                            <%--@declare id="exampleinputpassword01"--%><label class="form-label col" for="exampleInputPassword01">密码<span class="text-danger">*</span></label>
                                        </div>
                                        <input type="password" class="form-control" placeholder="请输入密码" value="" 
											name="password" id="password" maxlength="255">
                                    </div>
                                    <div class="form-group mb-3">
                                        <label for="email_1" class="form-label">验证码<span class="text-danger">*</span></label>
                                        <div>
	                                        <input type="text" name="valcode" id="valcode" maxlength="4" autocomplete="off" value="" 
	                                        	placeholder="请输入验证码" class="form-control" style="display: inline-block;width:50%">
	                                        <img src="" class="pull-right" id="valcodeImg" 
							            		style="cursor: pointer;display: inline-block;width:auto;margin-left:10px" 
							            		onclick="changeValCode()" title="点击刷新" alt="验证码">
								        </div>
                                    </div>
                                    <div class="form-group text-center" style="margin-top:40px">
                                        <button type="button" id="submitBtn" class="btn btn-primary w-100">
                                            	登&nbsp;&nbsp;录
                                        </button>
                                    </div>
                                </form>
                                <div class="text-center pt-4 pb-4">
                                    <span class="px-3 bg-white d-inline-block align-top lh-sm"></span>
                                    <div class="border-bottom mt-n3"></div>
                                </div>
                                <div class="text-center">
                                    <span class="text-muted">
                                    	没有账号? <a href="${pageContext.request.contextPath}/register">立即注册</a>
                                    </span>
                                </div>
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
				$("#submitBtn").on("click",function() {
					if ($("#username").val() == "" || $("#password").val() == "" || $("#valcode").val()=="") {
						layer.msg("用户登录信息不能为空！");
					} else {
						common_ajax_self_result($("#form").attr("action"), $("#form").serialize(), callback);
						//changeValCode();//获取验证码
					}
				});
			});
			
			//登录之后的回调函数（登录成功，如果没有喜好标签需要选择）
			function callback(data){
				if(data.success>0){
					if(data.userid==null){//用户已有喜好标签
						//返回提示信息
						if(data.message!=null && data.message!=""){
							layer.msg(data.message);
						}else{
							layer.msg("操作成功！");
						}
						//跳转
						if(data.url!=null && data.url!=""){
							if(data.url=="reload"){
	              				setTimeout(function () {window.location.reload(); }, globalTimeout);             
	              			}else{
	              				setTimeout(function () {location.href=basePath+data.url; }, globalTimeout);
	              			}
						}
					}else{//选择喜好标签
						selectLabel(data.userid);
					}
				}else{//登录失败：用户名、密码、验证码不正确
					if(data.message!=null && data.message!=""){
						layer.msg(data.message);
					}else{
						layer.msg("操作失败！");
					}
				}
			}
			
			//选择喜好标签
			function selectLabel(userid){
				layer.open({
					  type: 2,
					  skin: 'layui-layer-molv', //加上边框
					  closeBtn: 1, //不显示关闭按钮
					  shadeClose: true, //开启遮罩关闭
					  area: ['630px', '380px'], //宽高
					  title:"请选择喜好标签",
					  content: "${pageContext.request.contextPath}/user/userlabel/listCommon?userid="+userid
				});
			}
		</script>
	</body>
</html>