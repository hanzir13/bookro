<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-3 pb-4 pb-lg-0 " style="width:28%">
    <div class="bg-white border border-bottom-0 shadow-lg" id="menuid">
        <div class="d-flex p-3 align-items-center">
            <div class="avatar avatar-lg rounded-circle">
                <img src="/${appMediaUrl }/${sessionScope.session_user.header }" title="" alt="">
            </div>
            <div class="col ps-3 text-break">
                <h6 class="m-0">${sessionScope.session_user.username }</h6>
                <small><a href="javascript:void(0);">${sessionScope.session_user.email }</a></small>
            </div>
        </div>
        <div class="bg-gray-200 p-3 border-bottom border-top">
            <h6 class="m-0">信息设置</h6>
        </div>
        <ul class="list-unstyled mb-0 theme-link">
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center p-3" 
                	href="${pageContext.request.contextPath}/user/user/detail">
                    <i class="bi bi-person-circle me-2"></i> 个人中心
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center p-3" 
                	href="${pageContext.request.contextPath}/user/user/update">
                    <i class="bi bi-pencil-square me-2"></i> 信息修改
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center p-3" 
                	href="${pageContext.request.contextPath}/user/user/updatePassword">
                    <i class="bi bi-unlock me-2"></i> 密码修改
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center p-3" 
                	href="${pageContext.request.contextPath}/user/userlabel/list">
                    <i class="bi bi-bookmarks me-2"></i> 喜好标签
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center p-3" 
                	href="${pageContext.request.contextPath}/user/bookscore/list">
                    <i class="bi bi-star me-2"></i> 我的评分
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center p-3" 
                	href="${pageContext.request.contextPath}/user/bookcollect/list">
                    <i class="bi bi-heart me-2"></i> 我的收藏
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center p-3" 
                	href="${pageContext.request.contextPath}/user/bookcomment/list">
                    <i class="bi bi-chat-left-dots me-2"></i> 我的评论
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center p-3" 
                	href="${pageContext.request.contextPath}/user/booklook/list">
                    <i class="bi bi-clock-history me-2"></i> 浏览历史
                </a>
            </li>
            <li class="border-bottom mb-0">
                <a class="nav-link-style d-flex align-items-center p-3" href="javascript:doQuit();">
                    <i class="bi bi-box-arrow-left me-2"></i> 退出登录
                </a>
            </li>
        </ul>
    </div>
</div>
<script>
	var pathname = pathname?pathname:"";//pathname是为一个页面中有多个操作
	//菜单选中js
 	window.onload = function(){
    	$("#menuid").find("a").each(function(){
			if($(this).attr("href")==window.location.pathname
					|| $(this).attr("href")==pathname){
				$(this).addClass("active");
				return;
			}
		});
 	}
</script>