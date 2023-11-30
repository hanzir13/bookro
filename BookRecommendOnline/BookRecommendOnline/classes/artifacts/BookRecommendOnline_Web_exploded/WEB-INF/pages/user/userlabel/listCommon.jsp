<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML>
<html>
 	<head>
 		<title>用户选择喜好标签-在线图书推荐网</title>
		<%@ include file="../public/css.jsp"%>
		<%@ include file="../public/js.jsp"%>
  	</head>
  	<body>
	  	<div id="userlabel_div" style="margin:6% 6% 6% 6%;">
			<c:choose>
			  	<c:when test="${booktypeList!=null && booktypeList.size()>0}">
					<c:forEach var="booktype" items="${booktypeList}" varStatus="status">
					  	<div class="form-check form-check-inline" style="margin-bottom: 1rem;margin-right: 3rem;">
					  		<input class="form-check-input" id="inlineCheckbox_${status.index }" type="checkbox" 
					  			name="booktypeid" value="${booktype.id }">
					  		<label class="form-check-label" for="inlineCheckbox_${status.index }" style="color:#02010a" 
					  			>${booktype.typename }</label>
						</div>
				  	</c:forEach>
				</c:when>
			</c:choose>
			<div class="form-group" align="center" style="padding-top:0px">
				<div style="display:inline-block;" >
					<a href="javascript:doUserlabel()" id="submitBtn" class="btn btn-success">
						&nbsp;&nbsp;&nbsp;&nbsp;提&nbsp;&nbsp;交&nbsp;&nbsp;&nbsp;&nbsp;
					</a>
				</div>
			</div>
		</div>
  	</body>
  	<script>
		function doUserlabel(){
			var data = "userid=${userid}";
			var booktypeids = "";
			$("input[type='checkbox']:checked").each(function(){
				booktypeids+=$(this).val()+",";
			});
			if(booktypeids==""){
				layer.msg("请至少选择一条数据！");
				return;
			}
			booktypeids = booktypeids.substring(0,booktypeids.lastIndexOf(","));
			data+="&booktypeids="+booktypeids;
			common_ajax_callback_other("user/userlabel/doSaveCommon",data,callbackSuccess,null);
		}
		
		//操作成功之后，跳转到前台首页
		function callbackSuccess(data){
			setTimeout(function () {parent.location.href=basePath; }, globalTimeout);
		}
	</script>
</html>