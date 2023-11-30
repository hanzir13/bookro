<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
		<title>管理员-在线图书推荐网</title>
		<%@ include file="../public/css.jsp"%>
		<link href="${pageContext.request.contextPath}/static/css/theme.css" rel="stylesheet">
		<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
		<script src="${pageContext.request.contextPath}/static/js/bootstrap.js"></script>
		<script src="${pageContext.request.contextPath}/static/layer/layer.js"></script>
	</head>
	<body class="theme-blue-gradient pace-done" style="overflow: hidden;">
		<div class="pace pace-inactive">
			<div class="pace-progress" data-progress-text="100%"
				data-progress="99" style="width: 100%;">
				<div class="pace-progress-inner"></div>
			</div>
			<div class="pace-activity"></div>
		</div>
		<div class="pace pace-inactive">
			<div class="pace-progress" style="width: 100%;"
				data-progress-text="100%" data-progress="99">
				<div class="pace-progress-inner"></div>
			</div>
			<div class="pace-activity"></div>
		</div>
		<div id="theme-wrapper">
			<header class="navbar" id="header-navbar" style="border-bottom: 1px solid #414761;background: #2c3e50;">
				<div class="container" style="padding-right: 0px;">
					<a class="navbar-brand" id="logo" style="margin-left: 20px;padding-right:10px;font-weight:normal"
						href="${pageContext.request.contextPath}/admin" >
						<img src="${pageContext.request.contextPath}/static/images/logo.jpg" 
		    				style="border-radius: 4px;display: inline;padding-right: 0px;height:25px;">
							在线图书推荐网 | 后台管理系统
					</a>
					<div class="clearfix">
						<div class="nav-no-collapse navbar-left pull-left hidden-sm hidden-xs">
							<ul class="nav navbar-nav pull-left">
								<li>
									<a id="make-small-nav">
										<div class="ftdms-aside-toggler">
											<span class="ftdms-toggler-bar"></span> 
											<span class="ftdms-toggler-bar"></span> 
											<span class="ftdms-toggler-bar"></span>
										</div>
									</a>
								</li>
							</ul>
						</div>
						<div class="nav-no-collapse pull-right" id="header-nav">
							<ul class="nav navbar-nav pull-right">
								<li class="dropdown profile-dropdown">
									<a class="dropdown" href="#" data-toggle="dropdown" > 
										<span id="time"></span>
									</a>
								</li>
								<li class="dropdown profile-dropdown">
									<a class="dropdown" href="#" data-toggle="dropdown" > 
										<span class="hidden-xs">当前管理员：${sessionScope.session_admin.username }</span>
									</a>
									<ul class="dropdown-menu pull-right">
										<li>
											<a class="submenuitem" 
												href="${pageContext.request.contextPath}/admin/admin/addOrUpdate?adminid=${sessionScope.session_admin.id}"
												data-id="rofile" data-index="100" target="rightiframe">
												<i class="ft ftsucai-edit-1"></i>信息修改
											</a>
										</li>
										<li>
											<a class="submenuitem" href="${pageContext.request.contextPath}/admin/admin/updatePassword"
												data-id="linkpwd" data-index="101" target="rightiframe">
												<i class="ft ftsucai-53"></i>密码修改
											</a>
										</li>
										<li>
											<a href="javascript:doQuit()">
												<i class="ft ftsucai-exit"></i>退出登录
											</a>
										</li>
									</ul>
								</li>
								<li class="dropdown profile-dropdown">
									<a class="dropdown" href="${pageContext.request.contextPath}/" 
										target="_blank"> 
										前台首页
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</header>
			<div class="container" id="page-wrapper">
				<div class="row">
					<div id="nav-col">
						<section class="col-left-nano" id="col-left">
							<div class="col-left-nano-content" id="col-left-inner">
								<div class="collapse navbar-collapse navbar-ex1-collapse"
									id="sidebar-nav">
									<ul class="nav nav-pills nav-stacked">
										<li>
											<a class="" target="rightiframe"
												href="${pageContext.request.contextPath}/admin/content" data-id="a1">
												<i class="ft ftsucai-214"></i> <span>数据统计</span> 
											</a>
										</li>
										<li>
											<a class="dropdown-toggle" href="#" data-id="a2">
												<i class="ft ftsucai-58"></i> 
												<span>用户管理</span> 
												<i class="ft ftsucai-139 drop-icon"></i>
											</a>
											<ul class="submenu">
												<li>
													<a class="submenuitem" href="${pageContext.request.contextPath}/admin/user/list" 
														target="rightiframe"
														data-id="link21" data-index="21">
														用户列表
													</a>
												</li>
											</ul>
										</li>
										<li>
											<a class="dropdown-toggle" href="#" data-id="a3">
												<i class="ft ftsucai-appstore"></i> 
												<span>图书类型管理</span> 
												<i class="ft ftsucai-139 drop-icon"></i>
											</a>
											<ul class="submenu">
												<li>
													<a class="submenuitem" href="${pageContext.request.contextPath}/admin/booktype/list" 
														target="rightiframe"
														data-id="link31" data-index="31">
														图书类型列表
													</a>
												</li>
											</ul>
										</li>
										<li>
											<a class="dropdown-toggle" href="#" data-id="a4">
												<i class="ft ftsucai-29"></i> 
												<span>图书管理</span> 
												<i class="ft ftsucai-139 drop-icon"></i>
											</a>
											<ul class="submenu">
												<li>
													<a class="submenuitem" href="${pageContext.request.contextPath}/admin/book/list" 
														target="rightiframe"
														data-id="link41" data-index="41">
														图书列表
													</a>
												</li>
											</ul>
										</li>
										<li>
											<a class="dropdown-toggle" href="#" data-id="a5">
												<i class="ft ftsucai-information"></i> 
												<span>用户标签管理</span> 
												<i class="ft ftsucai-139 drop-icon"></i>
											</a>
											<ul class="submenu">
												<li>
													<a class="submenuitem" href="${pageContext.request.contextPath}/admin/userlabel/list" 
														target="rightiframe"
														data-id="link51" data-index="51">
														用户标签列表
													</a>
												</li>
											</ul>
										</li>
										<li>
											<a class="dropdown-toggle" href="#" data-id="a5">
												<i class="ft ftsucai-218"></i> 
												<span>图书评分管理</span> 
												<i class="ft ftsucai-139 drop-icon"></i>
											</a>
											<ul class="submenu">
												<li>
													<a class="submenuitem" href="${pageContext.request.contextPath}/admin/bookscore/list" 
														target="rightiframe"
														data-id="link51" data-index="51">
														图书评分列表
													</a>
												</li>
											</ul>
										</li>
										<li>
											<a class="dropdown-toggle" href="#" data-id="a5">
												<i class="ft ftsucai-110"></i> 
												<span>图书收藏管理</span> 
												<i class="ft ftsucai-139 drop-icon"></i>
											</a>
											<ul class="submenu">
												<li>
													<a class="submenuitem" href="${pageContext.request.contextPath}/admin/bookcollect/list" 
														target="rightiframe"
														data-id="link51" data-index="51">
														图书收藏列表
													</a>
												</li>
											</ul>
										</li>
										<li>
											<a class="dropdown-toggle" href="#" data-id="a5">
												<i class="ft ftsucai-info"></i> 
												<span>图书评论管理</span> 
												<i class="ft ftsucai-139 drop-icon"></i>
											</a>
											<ul class="submenu">
												<li>
													<a class="submenuitem" href="${pageContext.request.contextPath}/admin/bookcomment/list" 
														target="rightiframe"
														data-id="link51" data-index="51">
														图书评论列表
													</a>
												</li>
											</ul>
										</li>
										<li>
											<a class="dropdown-toggle" href="#" data-id="a5">
												<i class="ft ftsucai-eye"></i> 
												<span>图书浏览管理</span> 
												<i class="ft ftsucai-139 drop-icon"></i>
											</a>
											<ul class="submenu">
												<li>
													<a class="submenuitem" href="${pageContext.request.contextPath}/admin/booklook/list" 
														target="rightiframe"
														data-id="link51" data-index="51">
														图书浏览列表
													</a>
												</li>
											</ul>
										</li>
										<li>
											<a class="dropdown-toggle" href="#" data-id="a6">
												<i class="ft ftsucai-ic_leader"></i> 
												<span>管理员管理</span> 
												<i class="ft ftsucai-139 drop-icon"></i>
											</a>
											<ul class="submenu">
												<li>
													<a class="submenuitem" href="${pageContext.request.contextPath}/admin/admin/list" 
														target="rightiframe"
														data-id="link61" data-index="61">
														管理员列表
													</a>
												</li>
											</ul>
										</li>
									</ul>
								</div>
							</div>
						</section>
					</div>
					<div id="content-wrapper">
						<div class="content-iframe" style="background-color: #f9f9f9;">
							<div class="mainContent" id="content-main"
								style="margin: 0px; padding: 0px; height: 549px;">
								<iframe name="rightiframe" width="100%" height="100%"
									class="main_iframe" id="rightiframe"
									src="${pageContext.request.contextPath}/admin/content"
									frameborder="0" ></iframe>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
	<script src="${pageContext.request.contextPath}/static/js/index.js"></script>
	<script>
		//动态显示时间js
		function getTime() {
			var myDate = new Date();
			var myYear = myDate.getFullYear(); //获取完整的年份(4位,1970-????)
			var myMonth = myDate.getMonth() + 1; //获取当前月份(0-11,0代表1月)
			var myToday = myDate.getDate(); //获取当前日(1-31)
			var myDay = myDate.getDay(); //获取当前星期X(0-6,0代表星期天)
			var myHour = myDate.getHours(); //获取当前小时数(0-23)
			var myMinute = myDate.getMinutes(); //获取当前分钟数(0-59)
			var mySecond = myDate.getSeconds(); //获取当前秒数(0-59)
			var week = [ '星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六' ];
			var nowTime;
	
			nowTime = myYear + '-' + fillZero(myMonth) + '-' + fillZero(myToday)
					+ '&nbsp;&nbsp;' + fillZero(myHour) + ':' + fillZero(myMinute)
					+ ':' + fillZero(mySecond) + '&nbsp;&nbsp;' + week[myDay]
					+ '&nbsp;&nbsp;';
			$('#time').html(nowTime);
		};
		
		function fillZero(str) {
			var realNum;
			if (str < 10) {
				realNum = '0' + str;
			} else {
				realNum = str;
			}
			return realNum;
		}
		
		getTime();
		setInterval(getTime, 1000);
		
		//退出登录
		function doQuit(){
			layer.confirm('确定退出登录？', {
			  	btn: ['确定','取消'] //按钮
			}, function(){
			  	location.href="${pageContext.request.contextPath}/admin/quit";
			}, function(){
				
			});
			return false;
		}
	</script>
</html>