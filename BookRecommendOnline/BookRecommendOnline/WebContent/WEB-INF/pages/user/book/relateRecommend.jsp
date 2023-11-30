<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<section class="pb-4">
    <div class="container">
        <div class="product-tabs">
            <ul class="nav product-nav-tabs" style="justify-content: left;">
                <li class="nav-item">
                    <a href="javascript:void(0);" class="nav-link active">猜你喜欢</a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade active show" >
                    <div class="row">
                        <c:choose>
							<c:when test="${relateRecommends!=null && relateRecommends.size()>0}">
								<c:forEach var="book" items="${relateRecommends}" varStatus="status">
					               <div class="col-lg-2">
					                   <div class="product-card-1">
					                       <div class="product-card-image">
					                           <div class="badge-ribbon">
					                               <span class="badge bg-danger">Love</span>
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
                </div>
            </div>
        </div>
    </div>
</section>