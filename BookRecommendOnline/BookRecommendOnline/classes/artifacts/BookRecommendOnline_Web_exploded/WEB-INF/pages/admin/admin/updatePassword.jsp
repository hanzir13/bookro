<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
			            	<div class="card-header"><h4>管理员修改密码</h4></div>
				        	<div class="card-body">
				                <form action="admin/admin/doUpdatePassword" method="post" id="form" class="row">
				                  	<div class="form-group col-md-12">
				                    	<%--@declare id="title"--%><label for="title">原密码</label>
				                    	<input type="password" class="form-control" maxlength="255"
				                    		name="oldPassword" id="oldPassword" placeholder="请输入原密码" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">新密码</label>
				                    	<input type="password" class="form-control" maxlength="255"
				                    		name="password" id="password" placeholder="请输入新密码" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">确认新密码</label>
				                    	<input type="password" class="form-control" maxlength="255"
				                    		name="confPassword" id="confPassword" placeholder="请输入确认新密码" >
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
	<script>
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
	                layer.msg("密码不能为空！");return false;
	            }
	            if($("#password").val()!=$("#confPassword").val()){
	                layer.msg("两次新密码不相同！");return false;
	            }
	            common_ajax_self_result($("#form").attr("action"),$("#form").serialize(),callback);
	        });
	    });
		
		//修改密码之后回调函数
		function callback(data){
			if(data.success>0){
				if(data.message!=null && data.message!=""){
					layer.msg(data.message);
				}else{
					layer.msg("操作成功！");
				}
				if(data.url!=null && data.url!=""){
					if(data.url=="reload"){
          				setTimeout(function () {window.top.location.reload(); }, globalTimeout);  
          			}else{
          				setTimeout(function () {window.top.location.href=basePath+data.url; }, globalTimeout);
          			}
				}
			}else{
				if(data.message!=null && data.message!=""){
					layer.msg(data.message);
				}else{
					layer.msg("操作失败！");
				}
			}
		}
	</script>
</html>