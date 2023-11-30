<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script src="${pageContext.request.contextPath}/static/js/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/static/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/static/js/ajax_public.js"></script>
<script>
	//请求url
	var basePath = "${pageContext.request.contextPath}/";
	//文件上传url
	var uploadBasePath = "${pageContext.request.scheme}://"+
			"${pageContext.request.serverName}:"+
			"${pageContext.request.serverPort}/"+
			"${applicationScope.uploadFileDir}/";
	var globalTimeout = 800;
	//判断管理员是否登录
	var isLoginGlobal = ${sessionScope.session_user==null?false:true};
</script>