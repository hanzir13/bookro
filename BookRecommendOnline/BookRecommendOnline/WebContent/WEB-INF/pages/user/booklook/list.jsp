<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>浏览历史-在线图书推荐网</title>
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
                        <div class="row g-4">
                        	<c:choose>
								<c:when test="${pageBean!=null && pageBean.list!=null && pageBean.list.size()>0}">
									<c:forEach var="booklook" items="${pageBean.list}" varStatus="status">
				                        <div class="col-6 col-md-3">
			                                <div class="product-card-1">
			                                    <div class="product-card-image">
			                                        <div class="product-media">
			                                            <a href="${pageContext.request.contextPath}/user/book/detail?bookid=${booklook.bookEntity.id}" 
					                                    	title="${booklook.bookEntity.bookname}">
					                                        <img class="img-fluid" src="/${appMediaUrl }/${booklook.bookEntity.image }" 
					                                        	title="${booklook.bookEntity.bookname}" 
																style="height:235px;overflow: hidden;border-radius: 5px 5px 0px 0px;">
					                                    </a>
			                                        </div>
			                                    </div>
			                                    <div class="product-card-info">
			                                        <h6 class="product-title text-break text-truncate">
			                                            <a href="${pageContext.request.contextPath}/user/book/detail?bookid=${booklook.bookEntity.id}" 
					                                    	title="${booklook.bookEntity.bookname}">
					                                    	${booklook.bookEntity.bookname}
					                                    </a>
			                                        </h6>
			                                        <div class="product-price">
			                                            <span class="text-muted"><small>${booklook.createtime }</small></span>
			                                        </div>                                       
			                                    </div>
			                                </div>
			                            </div>
                       				</c:forEach>
	                      		</c:when>
				     			<c:otherwise>
				     				<div>暂无数据</div>
				     			</c:otherwise>
				   			</c:choose>
                       	</div>
                       	<form action="${pageContext.request.contextPath}/user/booklook/list" method="post" id="form">
			  				<input type="hidden" name="pageNum" value="${pageBean.pageNum}" id="pageNum">
			  			</form>
						<%@ include file="../public/page.jsp"%>
                    </div>
                </div>
            </div>
        </div>
		<%@ include file="../public/footer.jsp"%>
		<script src="${pageContext.request.contextPath}/static/js/common_public.js"></script>
	</body>
</html>