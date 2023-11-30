<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>密码修改-在线图书推荐网</title>
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
                            	<form class="" action="user/user/doUpdatePassword" method="post" id="form" >
	                                <div class="row">
	                                    <div class="col-sm-12 mb-3">
	                                        <%--@declare id="formfile"--%><label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	原密码：
	                                        </label>
	                                        <input type="password" placeholder="请输入原密码" 
												id="oldPassword" name="oldPassword" maxlength="255"
												style="display: inline-block;width:70%" class="form-control">
	                                    </div>
	                                    <div class="col-sm-12 mb-3">
	                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	新密码：
	                                        </label>
	                                        <input type="password" placeholder="请输入新密码" 
												id="password" name="password" maxlength="255"
												style="display: inline-block;width:70%" class="form-control">
	                                    </div>
	                                    <div class="col-sm-12 mb-3">
	                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
	                                        	确认新密码：
	                                        </label>
	                                        <input type="password" placeholder="请输入确认密码" 
												id="confPassword" name="confPassword" maxlength="255"
												style="display: inline-block;width:70%" class="form-control">
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
			$(function(){
	        	$("#submitBtn").on("click",function(){
	        		var temp = true;
	                $("#form").find("input[type='password']").each(function(){
	                    if($(this).val()==null || $(this).val()==""){
	                        temp = false;
	                        return false;
	                    }
	                });
	                if(!temp){
	                    layer.msg("修改信息不能为空！");return false;
	                }
	                if($("#password").val()!=$("#confPassword").val()){
	                    layer.msg("两次新密码不相同！");return false;
	                }
	                common_ajax_other($("#form").attr("action"),$("#form").serialize());
		        });
		    });
		</script>
	</body>
</html>