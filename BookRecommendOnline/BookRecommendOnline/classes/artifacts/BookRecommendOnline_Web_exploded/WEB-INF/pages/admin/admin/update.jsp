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
			            	<div class="card-header"><h4>管理员新增或修改</h4></div>
				        	<div class="card-body">
				                <form action="admin/admin/doAddOrUpdate" method="post" id="form" class="row">
				                	<input name="id" value="${admin.id }" type="hidden" >
				                  	<div class="form-group col-md-12">
				                    	<%--@declare id="title"--%><label for="title">管理员名</label>
				                    	<input type="text" class="form-control" maxlength="255"
				                    		name="username" value="${admin.username }" placeholder="请输入管理员名" 
				                    		${admin.id!="" && admin.id!=null?'disabled="disabled"':'' }>
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">电话</label>
				                    	<input type="text" class="form-control" maxlength="11"
				                    		oninput="value=value.replace(/[^\d]/g,'')" placeholder="请输入电话"
											name="phone" id="phone" value="${admin.phone }">
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">邮箱</label>
				                    	<input type="text" class="form-control" maxlength="255"
				                    		placeholder="请输入邮箱"
											value="${admin.email }" name="email" id="email" >
				                  	</div>
				                  	<div class="form-group col-md-12">
				                    	<label for="title">管理员类型</label>
				                    	<div class="clearfix">
					                      	<label class="ftdms-radio radio-inline radio-primary">
					                        	<input type="radio" name="issuper" value="0" title="普通管理员" 
					                        		${admin.issuper==0?'checked="checked"':'' } 
						      						${sessionScope.session_admin.id==admin.id?'disabled="disabled"':'' }>
						      						<span>普通管理员</span>
					                      	</label>
					                      	<label class="ftdms-radio radio-inline radio-primary">
					                        	<input type="radio" name="issuper" value="1" title="超级管理员"
					                        		${admin.issuper==1?'checked="checked"':'' } 
									      			${sessionScope.session_admin.id==admin.id?'disabled="disabled"':'' }>
									      			<span>超级管理员</span>
					                      	</label>
					                    </div>
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
	            $("#form").find("input[type='text']").each(function(){
	                if($(this).val()==null || $(this).val()==""){
	                    temp = false;
	                    return false;
	                }
	            });
	            if(!temp){
	                layer.msg("数据不能为空!");return false;
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
	            //对管理员类型验证
	            if($("#form").find("input[type='radio']:checked").length == 0){
	            	layer.msg("请选择管理员类型!");return false;
	            }
	            common_ajax_other($("#form").attr("action"),$("#form").serialize());
	        });
	    });
	</script>
</html>