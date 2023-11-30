<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<section class="section" style="padding-top: 28px; padding-bottom: 0px">
	<div class="container">
		<div class="row section-heading" style="margin-bottom: 20px">
			<div class="col-lg-6" style="display: inline-block;">
				<h3 class="h2 mt-2" style="font-size: 24px; font-weight: 500">个性化推荐</h3>
			</div>
		</div>
		<div class="row g-3 g-lg-4">
			<c:choose>
				<c:when test="${recommendBooks!=null && recommendBooks.size()>0}">
					<c:forEach var="book" items="${recommendBooks}"
						varStatus="status">
						<div class="col-lg-2">
							<div class="product-card-1">
								<div class="product-card-image">
									<div class="badge-ribbon">
										<span class="badge bg-danger">Love</span>
									</div>
									<div class="product-media">
										<a
											href="${pageContext.request.contextPath}/user/book/detail?bookid=${book.id}"
											title="${book.bookname}"> <img class="img-fluid"
											src="/${appMediaUrl }/${book.image }" title="${book.bookname}"
											style="height: 235px; overflow: hidden; border-radius: 5px 5px 0px 0px;">
										</a>
									</div>
								</div>
								<div class="product-card-info">
									<div class="product-meta small">
										<a href="javascript:submitForm(${book.booktypeid })">
											${book.booktypeEntity.typename } </a>
									</div>
									<h6 class="product-title text-break text-truncate"
										style="margin: 0px 0px 0px 0px;">
										<a
											href="${pageContext.request.contextPath}/user/book/detail?bookid=${book.id}"
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
</section>