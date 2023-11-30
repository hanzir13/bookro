<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<section class="section" style="padding-top: 28px; padding-bottom: 0px">
	<div class="container">
		<div class="row g-4">
			<div class="col-lg-12">
				<h3 class="h2 mt-2" style="font-size: 24px; font-weight: 500">热点榜单</h3>
			</div>
			<c:choose>
				<c:when test="${topBooks!=null && topBooks.size()>0}">
					<c:forEach var="book" items="${topBooks }">
						<div class="col-lg-4">
							<div class="product-card-4 ">
								<div class="product-card-image">
									<a
										href="${pageContext.request.contextPath}/user/book/detail?bookid=${book.id}"
										title="${book.bookname }"> <img
										src="/${appMediaUrl }/${book.image }"
										title="${book.bookname}"
										style="border-radius: 4px; height: 160px; width: 110px;">
									</a>
								</div>
								<div class="product-card-info">
									<h6 class="product-title text-break text-truncate">
										<a
											href="${pageContext.request.contextPath}/user/book/detail?bookid=${book.id}"
											title="${book.bookname }" tabindex="0">${book.bookname }</a>
									</h6>
									<div class="produc-card-cart text-break text-truncate">
										<a class="link-effect"
											href="javascript:submitForm(${book.booktypeEntity.id })">
											${book.booktypeEntity.typename } </a>
									</div>
									<div class="product-price text-break text-truncate">
										<span class="text-secondary" style="font-weight: normal">
											<small>作者：${book.author }</small>
										</span>
									</div>
									<div class="product-price text-break text-truncate">
										<span class="text-secondary" style="font-weight: normal">
											<small>出版社：${book.press }</small>
										</span>
									</div>
									<div class="product-price text-break text-truncate">
										<span class="text-secondary" style="font-weight: normal">
											<small><i class="bi bi-eye-fill"></i>
												${book.countlook }</small>
										</span>
									</div>
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