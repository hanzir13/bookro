<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>个人中心-在线图书推荐网</title>
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
                        <div class="card mb-5" style="border-radius:unset">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-12 mb-3">
                                        <%--@declare id="formfile"--%><label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
                                        	用户名：
                                        </label>
                                        <label for="formFile" class="form-label text-dark text-break" style="font-size:0.93rem">
                                        	${user.username}
                                        </label>
                                    </div>
                                    <div class="col-sm-12 mb-3">
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
                                        	头像：
                                        </label>
                                        <img src="/${appMediaUrl }/${user.header}"
								    		style="width:100px;height:100px;display: inline-block;">
                                    </div>
                                    <div class="col-sm-12 mb-3">
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
                                        	电话：
                                        </label>
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem">
                                        	${user.phone}
                                        </label>
                                    </div>
                                    <div class="col-sm-12 mb-3">
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
                                        	邮箱：
                                        </label>
                                        <label for="formFile" class="form-label text-dark text-break" style="font-size:0.93rem">
                                        	${user.email}
                                        </label>
                                    </div>
                                    <div class="col-sm-12 mb-3">
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
                                        	年龄：
                                        </label>
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem">
                                        	${user.age}
                                        </label>
                                    </div>
                                    <div class="col-sm-12 mb-3">
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
                                        	性别：
                                        </label>
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem">
                                        	${user.gender==1?"男":(user.gender==2?"女":"") }
                                        </label>
                                    </div>
                                    <div class="col-sm-12 mb-3">
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
                                        	状态：
                                        </label>
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem">
                                        	${user.state==1?"正常":"锁定" }
                                        </label>
                                    </div>
                                    <div class="col-sm-12 mb-3">
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
                                        	注册时间：
                                        </label>
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem">
                                        	${user.createtime}
                                        </label>
                                    </div>
                                    <div class="col-sm-12 mb-3">
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem;width:15%">
                                        	最近登录时间：
                                        </label>
                                        <label for="formFile" class="form-label text-dark" style="font-size:0.93rem">
                                        	${user.lastlogintime}
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<%@ include file="../public/footer.jsp"%>
	</body>
</html>