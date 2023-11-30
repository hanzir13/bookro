<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<title>管理员-在线图书推荐网</title>
		<%@ include file="../public/css.jsp"%>
		<%@ include file="../public/js.jsp"%>
	</head>
	<body>
		<main class="ftdms-layout-content">
			<div class="container-fluid" style="margin-bottom:90px;">
		        <div class="row" style="margin-top:15px;">
		          	<div class="col-lg-12">
		            	<div class="card">
			            	<div class="card-header"><h4>图书类型列表</h4></div>
		              		<div class="card-toolbar clearfix">
				                <form class="pull-right search-bar" 
				                	action="${pageContext.request.contextPath}/admin/booktype/list" method="post" id="form1">
									<div class="input-group">
		                    			<input type="text" class="form-control" 
											id="typename" name="typename" value="${typename }" maxlength="255"
											placeholder="请输入图书类型名称">
					                    <div class="input-group-btn">
					                      <button class="btn btn-warning dropdown-toggle" type="submit">
					                    		 搜索
					                      </button>
					                    </div>
					                </div>
				                </form>
				                <div class="toolbar-btn-action">
				                	<a class="btn btn-cyan submenuitem" 
				                  		href="javascript:location.href='${pageContext.request.contextPath}/admin/booktype/addOrUpdate'" >新增</a>
				                  	<a class="btn btn-danger submenuitem" 
				                  		href="javascript:deleteBatch(null,true)" >批量删除</a>
				                </div>
		              		</div>
			              	<div class="card-body">
				                <div class="table-responsive">
				                  	<table class="table table-bordered" id="table">
				                    	<thead>
					                      	<tr>
					                        	<th width="5">
					                          		<label class="ftdms-checkbox checkbox-primary">
					                            		<input type="checkbox" id="selectAll"><span></span>
					                          		</label>
					                        	</th>
						                        <th>序号</th>
												<th>图书类型名称</th>
												<th>操作</th>
					                      	</tr>
				                    	</thead>
				                    	<tbody>
				                    		<c:choose>
							                  	<c:when test="${pageBean!=null && pageBean.list!=null && pageBean.list.size()>0}">
							                  		<c:forEach var="booktype" items="${pageBean.list}" varStatus="status">
														<tr class="table-self-bg-${status.index+1 }">
															<td>
																<label class="ftdms-checkbox checkbox-primary">
										                            <input type="checkbox" name="id" value="${booktype.id }"><span></span>
									                            </label>
															</td>
															<td>${status.index+1 }</td>
															<td style="word-break: break-word">${booktype.typename }</td>
															<td class="td-manage">
																<div class="btn-group">
										                            <a class="btn btn-xs btn-info submenuitem" style="margin-right:2px" 
										                            	href="${pageContext.request.contextPath}/admin/booktype/addOrUpdate?booktypeid=${booktype.id}" 
										                            	title="编辑" data-toggle="tooltip" data-original-title="编辑">
										                            	<i class="ftsucai-edit-2"></i>
										                            </a>
										                            <a class="btn btn-xs btn-info submenuitem" style="margin-right:2px" 
										                            	href="javascript:deleteBatch(${booktype.id }false)"
										                            	title="删除" data-toggle="tooltip" data-original-title="删除">
										                            	<i class="ftsucai-del-2"></i>
										                            </a>
										                    	</div>
															</td>
														</tr>
													</c:forEach>
							                    </c:when>
							                    <c:otherwise>
							                    	<tr>
								                      	<td colspan="4">暂无数据</td>
								                    </tr>
							                    </c:otherwise>
						                    </c:choose>
				                    	</tbody>
				                  	</table>
				                </div>
								<form action="${pageContext.request.contextPath}/admin/booktype/list" method="post" id="form">
						        	<input type="hidden" name="pageNum" value="${pageBean.pageNum}" id="pageNum">
						        	<input type="hidden" name="typename" value="${typename }" >
						        </form>				                
				                <%@ include file="../public/page.jsp"%>
			              	</div>
		            	</div>
		          	</div>
		        </div>
	      	</div>
    	</main>
	</body>		
	<script src="${pageContext.request.contextPath}/static/js/common_public.js"></script>
	<script>
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
		        common_ajax_other("admin/booktype/deleteBatch",data);
		   	});
		}
	</script>
</html>