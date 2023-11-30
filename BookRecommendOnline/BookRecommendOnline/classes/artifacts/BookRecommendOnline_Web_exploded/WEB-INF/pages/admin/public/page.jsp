<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:choose>
	<c:when
		test="${pageBean!=null && pageBean.list!=null && pageBean.list.size()>0}">
		<c:set var="showPagesParam" value="9" />
		<c:set var="showHalfPagesParam" value="${(showPagesParam-1)/2 }" />
		<c:set var="beginPageNumParam" value="1" />
		<c:choose>
			<c:when
				test="${pageBean.pageNum-showHalfPagesParam>1 
				&& pageBean.pages-pageBean.pageNum>=showHalfPagesParam }">
				<c:set var="beginPageNumParam"
					value="${pageBean.pageNum-showHalfPagesParam }" />
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when
						test="${pageBean.pages-pageBean.pageNum<showHalfPagesParam 
						&& pageBean.pages>showPagesParam }">
						<c:set var="beginPageNumParam"
							value="${pageBean.pages-showPagesParam+1 }" />
					</c:when>
					<c:otherwise>
						<c:set var="beginPageNumParam" value="1" />
					</c:otherwise>
				</c:choose>
			</c:otherwise>
		</c:choose>
		<ul class="pagination no-gutters">
	        <li class="disabled"><span>共${pageBean.total}条&nbsp;&nbsp;${pageBean.pages}页</span></li>
	      	<li>  
	 			<a title="上一页"
	 				href="javascript:toPage(${pageBean.pageNum!=1?(pageBean.pageNum-1):pageBean.pageNum })" >上一页</a>       
	        </li>
			<c:forEach var="currentPageParam" begin="${beginPageNumParam }"
				end="${pageBean.pages>showPagesParam?beginPageNumParam+showPagesParam-1:pageBean.pages }">
				<c:choose>
					<c:when test="${currentPageParam==pageBean.pageNum }">
						<li class="active"><span>${currentPageParam }</span></li>
					</c:when>
					<c:otherwise>
						<li><a href="javascript:toPage(${currentPageParam })">${currentPageParam }</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<li>
            	<a title="下一页"
            		href="javascript:toPage(${pageBean.pageNum!=pageBean.pages?(pageBean.pageNum+1):pageBean.pageNum })">下一页</a>
            </li>
            <c:if test="${pageBean.pageNum!=1 && pageBean.pages!=0}">
				<li><a href="javascript:toPage(1)">首页</a></li>
			</c:if>
			<c:if test="${pageBean.pageNum!=pageBean.pages && pageBean.pages!=0}">
				<li><a href="javascript:toPage(${pageBean.pages})">尾页</a></li>
			</c:if>
		</ul>
	</c:when>
</c:choose>
<script>
	function toPage(pageNum) {
		$("#pageNum").val(pageNum);
		$("#form").submit();
	}
</script>