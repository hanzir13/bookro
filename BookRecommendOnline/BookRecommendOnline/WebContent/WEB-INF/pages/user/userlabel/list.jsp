<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
	<head>
		<title>喜好标签-在线图书推荐网</title>
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
                            	<div id="userlabel_div" style="margin:6% 6% 6% 6%;">
									<c:choose>
									  	<c:when test="${booktypeList!=null && booktypeList.size()>0}">
											<c:forEach var="booktype" items="${booktypeList}" varStatus="status">
												<c:set var="tempParam" value="false"/>
										  		<c:choose>
												  	<c:when test="${list!=null && list.size()>0}">
														<c:forEach var="userlabel" items="${list}" varStatus="status2">
															<c:if test="${userlabel.booktypeid == booktype.id }">
																<c:set var="tempParam" value="true"/>
															</c:if>
														</c:forEach>
													</c:when>
												</c:choose>
												<div class="form-check form-check-inline" style="margin-bottom: 1rem;margin-right: 3rem;">
											  		<input class="form-check-input" id="inlineCheckbox_${status.index }" type="checkbox" 
											  			name="booktypeid" value="${booktype.id }" ${tempParam==true?"checked='checked'":"" }>
											  		<label class="form-check-label" for="inlineCheckbox_${status.index }" style="color:#02010a" 
											  			>${booktype.typename }</label>
												</div>
										  	</c:forEach>
										</c:when>
									</c:choose>
									<div class="form-group" align="center" style="padding-top:20px">
										<div style="display:inline-block;" >
											<a href="javascript:doUserlabel()" id="submitBtn" class="btn btn-primary">
												&nbsp;&nbsp;&nbsp;&nbsp;保存信息&nbsp;&nbsp;&nbsp;&nbsp;
											</a>
										</div>
									</div>
								</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<%@ include file="../public/footer.jsp"%>
		<script type="text/javascript">
			function doUserlabel(){
				var booktypeids = "";
				$("input[type='checkbox']:checked").each(function(){
					booktypeids+=$(this).val()+",";
				});
				if(booktypeids==""){
					layer.msg("请至少选择一条数据！");
					return;
				}
				booktypeids = booktypeids.substring(0,booktypeids.lastIndexOf(","));
				var data ="booktypeids="+booktypeids;
				common_ajax_other("user/userlabel/doUpdate",data);
			}
		</script>
	</body>
</html>