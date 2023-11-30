<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>首页-在线图书推荐网</title>
		<%@ include file="../public/css.jsp"%>
		<%@ include file="../public/js.jsp"%>
	</head>
	<body>
		<%@ include file="../public/header.jsp"%>
		<%@ include file="../public/banner1.jsp"%>
		<%@ include file="./top.jsp"%>
		<%@ include file="./recommend.jsp"%>
		<section class="section" style="padding-top:28px;">
            <div class="container">
                <div class="row justify-content-center section-heading" style="margin-bottom:20px">
                    <div class="col-lg-6" style="display: inline-block;">
                        <h3 class="h2 mt-2" style="font-size:24px;font-weight:500">最新图书</h3>
                    </div>
                    <div class="col-lg-6" style="display: inline-block;text-align: right;vertical-align: middle;">
                        <h3 class="h2 mt-2" style="font-size:15px;font-weight:500">
                        	<a href="${pageContext.request.contextPath}/user/book/list">
                        		更多图书 <i class="bi bi-arrow-right"></i>
                        	</a>
                        </h3>
                    </div>
                </div>
                <div class="row justify-content-center section-heading" style="margin-bottom:20px">
                    <div class="col-lg-12">
                		<div class="nav tag-cloud" id="myTab">
	                       	<a href="javascript:submitForm('')" 
	                       		class="rounded-pill px-3 small font-w-500 py-1 bg-gray-200 me-1 mb-3 type_all" 
	                       		title="全部类型">全部类型</a>
							<c:if test="${booktypeList!=null && booktypeList.size()>0 }">
		             			<c:forEach var="booktype" items="${booktypeList }" varStatus="status">
		                           	<a href="javascript:submitForm(${booktype.id })" 
		                           		class="rounded-pill px-3 small font-w-500 py-1 bg-gray-200 me-1 mb-3 mx-1"
		                           		data-info='${booktype.id }' title="${booktype.typename }">
		                               	${booktype.typename }
		                            </a>
		                       	</c:forEach>
							</c:if>	
                        </div>
                	</div>
                </div>
                <div class="row g-3 g-lg-4">
                 	<c:choose>
						<c:when test="${pageBean!=null && pageBean.list!=null && pageBean.list.size()>0}">
							<c:forEach var="book" items="${pageBean.list}" varStatus="status">
			                    <div class="col-lg-2">
			                        <div class="product-card-1">
			                            <div class="product-card-image">
			                                <div class="badge-ribbon">
			                                    <span class="badge bg-danger">New</span>
			                                </div>
			                                <div class="product-media">
			                                    <a href="${pageContext.request.contextPath}/user/book/detail?bookid=${book.id}" 
			                                    	title="${book.bookname}">
			                                        <img class="img-fluid" src="/${appMediaUrl }/${book.image }" title="${book.bookname}" 
														style="height:235px;overflow: hidden;border-radius: 5px 5px 0px 0px;">
			                                    </a>
			                                </div>
			                            </div>
			                            <div class="product-card-info">
			                                <div class="product-meta small">
			                                    <a href="javascript:submitForm(${book.booktypeid })" >
			                                    	${book.booktypeEntity.typename }
			                                    </a>
			                                </div>
			                                <div class="rating-star text">
			                                    <i class="bi small ${book.avgscore>=1.0?'bi-star-fill active':'bi-star' }"></i>
												<i class="bi small ${book.avgscore>=2.0?'bi-star-fill active':'bi-star' }"></i>
												<i class="bi small ${book.avgscore>=3.0?'bi-star-fill active':'bi-star' }"></i>
												<i class="bi small ${book.avgscore>=4.0?'bi-star-fill active':'bi-star' }"></i>
												<i class="bi small ${book.avgscore>=5.0?'bi-star-fill active':'bi-star' }"></i>
			                                </div>
			                                <h6 class="product-title text-break text-truncate" style="margin: 0px 0px 0px 0px;">
			                                    <a href="${pageContext.request.contextPath}/user/book/detail?bookid=${book.id}" 
			                                    	title="${book.bookname}">${book.bookname}</a>
			                                </h6>
			                            </div>
			                        </div>
			                    </div>
							</c:forEach>
                        </c:when>
		     			<c:otherwise>
		     				暂无数据
		     			</c:otherwise>
		   			</c:choose>
                </div>
                <form action="${pageContext.request.contextPath}/user/book/list" method="post" id="form">
	  				<input type="hidden" name="pageNum" value="${pageBean.pageNum}" id="pageNum">
	  				<input type="hidden" name="booktypeid" value="${booktypeid}" id="booktypeid">
	  				<input type="hidden" name="bookname" value="${bookname}">
	  			</form>
            </div>
        </section>
		<%@ include file="../public/footer.jsp"%>
		<script type="text/javascript">
			//图书类型选中
			var booktypeid = "${booktypeid}";
	        if(booktypeid!=null && booktypeid!=""){
	            $("#myTab").find("a").each(function(){
	                if($(this).attr("data-info")==booktypeid){
	                    $(this).addClass("active");
	                    return false;
	                }
	            });
	        }else{
	            $(".type_all").addClass("active");
	        }
	        
	        function submitForm(booktypeid){
	            $("#pageNum").val(1);
	            $("#booktypeid").val(booktypeid);
	            $("#form").submit();
	        }
	    </script>
	</body>
</html>