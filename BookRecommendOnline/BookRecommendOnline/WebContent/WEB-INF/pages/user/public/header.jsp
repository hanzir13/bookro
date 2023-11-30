<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<header class="header-main bg-white header-dark header-option-1"
	style="top: 0px;">
	<div class="header-top pt-3 pb-2 py-md-2 py-lg-4">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-6 col-lg-4 text-center text-md-start">
					<a class="navbar-brand" href="${pageContext.request.contextPath}/" 
						style="font-size: 24px;color: #000;" title="在线图书推荐网">
						<img src="${pageContext.request.contextPath}/static/images/logo.jpg" 
							style="width:45px;border-radius:4px">
						在线图书推荐网
					</a>
				</div>
				<div class="col-lg-5 d-lg-block">
					<form class="d-flex input-group" action="${pageContext.request.contextPath}/user/book/list"
						method="post">
                        <input type="text" class="form-control" placeholder="请输入图书名称、作者..." 
                        	maxlength="255" id="bookname" name="bookname" value="${bookname }"
                        	style="background-color: unset;border-radius: 4px 0px 0px 4px;border-right:unset">
                        <button class="btn btn-primary flex-shrink-0" type="submit" title="搜索"
                        	style="border-radius: 0px 4px 4px 0px;"><i class="bi bi-search"></i></button>
                    </form>
				</div>
				<div class="col-md-6 col-lg-3">
					<div class="nav flex-nowrap align-items-center justify-content-md-end 
						header-right header-right-light w-100 w-md-auto position-relative">
						<c:if test="${sessionScope.session_user==null}">
							<div class="nav-item">
								<a class="nav-link" href="${pageContext.request.contextPath}/login">用户登录</a>
							</div>
							<div class="nav-item">
								<a class="nav-link" href="${pageContext.request.contextPath}/register">用户注册</a>
							</div>
						</c:if>
						<c:if test="${sessionScope.session_user!=null}">
							<div class="nav-item dropdown">
								<a class="nav-link" href="javascript:void(0);" role="button"
									id="dropdown_myaccount" data-bs-toggle="dropdown"
									data-bs-display="static" aria-haspopup="true"
									aria-expanded="false" style="padding:0px 0px 0px 0px;">
									<img src="/${appMediaUrl }/${sessionScope.session_user.header }"
										style="width: 44px; height: 44px; border-radius: 4px">
									<c:if test="${fn:length(sessionScope.session_user.username)>10}">
					                	${fn:substring(sessionScope.session_user.username, 0, 10)} ...
					                </c:if>
					                <c:if test="${fn:length(sessionScope.session_user.username)<=10}">
					                   	 ${sessionScope.session_user.username }
					                </c:if>
								</a>
								<div class="dropdown-menu dropdown-menu-hover right shadow"
									aria-labelledby="dropdown_myaccount" style="right:auto;left:-30%;">
									<a class="dropdown-item" href="${pageContext.request.contextPath}/user/user/detail">
										<i class="bi bi-person-circle me-2"></i>个人中心
									</a> 
									<a class="dropdown-item" href="${pageContext.request.contextPath}/user/user/update">
										<i class="bi bi-pencil-square me-2"></i>信息设置
									</a> 
									<a class="dropdown-item" href="${pageContext.request.contextPath}/user/bookscore/list">
										<i class="bi bi-star me-2"></i>我的评分
									</a> 
									<a class="dropdown-item" href="${pageContext.request.contextPath}/user/userlabel/list">
										<i class="bi bi-bookmarks me-2"></i>喜好标签
									</a> 
									<a class="dropdown-item" href="${pageContext.request.contextPath}/user/bookcollect/list">
										<i class="bi bi-heart me-2"></i>我的收藏
									</a> 
									<a class="dropdown-item" href="${pageContext.request.contextPath}/user/bookcomment/list">
										<i class="bi bi-chat-left-dots me-2"></i>我的评论
									</a> 
									<a class="dropdown-item" href="javascript:doQuit();">
										<i class="bi bi-box-arrow-left me-2"></i>退出登录
									</a> 
								</div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</header>