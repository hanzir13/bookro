<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<script src="${pageContext.request.contextPath}/static/js/jquery-3.5.1.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
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
	//判断用户是否登录
	var isLoginGlobal = ${sessionScope.session_user==null?false:true};
	//操作权限登录提示
	function doIsLogin(){
		if(!isLoginGlobal){
			layer.confirm('亲，请先登录！', {
			  	btn: ['登录','取消'] //按钮
			}, function(){
			  	location.href="${pageContext.request.contextPath}/login";
			}, function(){
				
			});
			return false;
		}
		return isLoginGlobal;
	}
	//退出登录
	function doQuit(){
		layer.confirm('确定退出登录？', {
		  	btn: ['确定','取消'] //按钮
		}, function(){
		  	location.href="${pageContext.request.contextPath}/quit";
		}, function(){
			
		});
		return false;
	}
</script>