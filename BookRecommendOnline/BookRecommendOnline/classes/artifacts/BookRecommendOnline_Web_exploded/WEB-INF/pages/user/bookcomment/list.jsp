<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>我的评论-在线图书推荐网</title>
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
                        <div class="row g-4">
                        	<c:choose>
								<c:when test="${pageBean!=null && pageBean.list!=null && pageBean.list.size()>0}">
									<c:forEach var="bookcomment" items="${pageBean.list}" varStatus="status">
				                        <div class="col-6 col-md-3">
			                                <div class="product-card-1">
			                                    <div class="product-card-image">
			                                    	<div class="product-action">
					                                    <a href="${pageContext.request.contextPath}/user/bookcomment/update?commentid=${bookcomment.id }" 
					                                    	class="btn btn-outline-primary" title="修改评论">
					                                        <i class="bi bi-pencil-square"></i>
					                                    </a>
					                                </div>
			                                        <div class="product-media">
			                                            <a href="${pageContext.request.contextPath}/user/book/detail?bookid=${bookcomment.bookEntity.id}" 
					                                    	title="${bookcomment.bookEntity.bookname}">
					                                        <img class="img-fluid" src="/${appMediaUrl }/${bookcomment.bookEntity.image }" 
																title="${bookcomment.bookEntity.bookname}" 
																style="height:235px;overflow: hidden;border-radius: 5px 5px 0px 0px;">
					                                    </a>
			                                            <div class="product-cart-btn">
			                                                <a href="javascript:deleteBatch(${bookcomment.id }false)"
			                                                	class="btn btn-danger btn-sm w-100">
			                                                    <i class="bi bi-x-circle"></i> 删除
			                                                </a>
			                                            </div>
			                                        </div>
			                                    </div>
			                                    <div class="product-card-info">
			                                        <h6 class="product-title text-break text-truncate">
			                                            <a href="${pageContext.request.contextPath}/user/book/detail?bookid=${bookcomment.bookEntity.id}" 
					                                    	title="${bookcomment.bookEntity.bookname}">
					                                    	${bookcomment.bookEntity.bookname}
					                                    </a>
			                                        </h6>
			                                        <div class="product-price">
			                                            <span class="text-muted"><small>${bookcomment.createtime }</small></span>
			                                        </div>                                       
			                                    </div>
			                                </div>
			                            </div>
                       				</c:forEach>
	                      		</c:when>
				     			<c:otherwise>
				     				<div>暂无数据</div>
				     			</c:otherwise>
				   			</c:choose>
                       	</div>
                       	<form action="${pageContext.request.contextPath}/user/bookcomment/list" method="post" id="form">
			  				<input type="hidden" name="pageNum" value="${pageBean.pageNum}" id="pageNum">
			  			</form>
						<%@ include file="../public/page.jsp"%>
                    </div>
                </div>
            </div>
        </div>
		<%@ include file="../public/footer.jsp"%>
		<script src="${pageContext.request.contextPath}/static/js/common_public.js"></script>
		<script type="text/javascript">
			//批量删除
			function deleteBatch(ids,selectAll){
				//是否是选中删除
				if(selectAll){
					ids = "";
					//获取选中的数据
					$("#table tbody").find("input:checkbox:checked").each(function(){
						ids+=$(this).val()+",";
					});
					if(ids==""){
						layer.msg("请至少选择一条数据！");return;
					}
				}
			    layer.confirm("确认删除？",{icon:7,title:"删除"},function(index){
				   layer.close(index);
				   var data = "ids="+ids;
			       common_ajax_other("user/bookcomment/deleteBatch",data);
			   	});
			}
	    </script>
	</body>
</html>