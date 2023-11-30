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
			            	<div class="card-header"><h4>图书类型新增或修改</h4></div>
				        	<div class="card-body">
				                <form action="admin/booktype/doAddOrUpdate" method="post" id="form" class="row">
				                	<input name="id" value="${booktype.id }" type="hidden" >
				                  	<div class="form-group col-md-12">
				                    	<%--@declare id="title"--%><label for="title">图书类型名称</label>
				                    	<input type="text" class="form-control" maxlength="255"
				                    		name="typename" value="${booktype.typename }" placeholder="请输入图书类型名称" >
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
	            common_ajax_other($("#form").attr("action"),$("#form").serialize());
	        });
	    });
	</script>
</html>