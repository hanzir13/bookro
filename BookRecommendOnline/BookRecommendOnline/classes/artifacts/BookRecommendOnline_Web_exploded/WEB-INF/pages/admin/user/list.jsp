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
			            	<div class="card-header"><h4>用户列表</h4></div>
		              		<div class="card-toolbar clearfix">
				                <form class="pull-right search-bar" style="max-width:470px"
				                	action="${pageContext.request.contextPath}/admin/user/list" method="post" id="form1">
									<div class="input-group">
										<div class="input-group-btn" style="width:200px;">
											<select class="form-control" name="state">
						                        <option value="0">请选择用户状态</option>
			                                	<option value="1" ${1==state?"selected='selected'":"" }>正常</option>
			                                	<option value="2" ${2==state?"selected='selected'":"" }>锁定</option>
					                      	</select>
						                </div>
		                    			<input type="text" class="form-control" style="width:200px;float:right"
											id="username" name="username" value="${username }" maxlength="255"
											placeholder="请输入用户名">
					                    <div class="input-group-btn">
					                      	<button class="btn btn-warning dropdown-toggle" type="submit">
				                    	  		搜索
					                      	</button>
					                    </div>
					                </div>
				                </form>
				                <div class="toolbar-btn-action">
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
												<th>用户名</th>
												<th>手机</th>
												<th>邮箱</th>
												<th>用户状态</th>
												<th>注册时间</th>
												<th>操作</th>
					                      	</tr>
				                    	</thead>
				                    	<tbody>
				                    		<c:choose>
							                  	<c:when test="${pageBean!=null && pageBean.list!=null && pageBean.list.size()>0}">
							                  		<c:forEach var="user" items="${pageBean.list}" varStatus="status">
														<tr class="table-self-bg-${status.index+1 }">
															<td>
																<label class="ftdms-checkbox checkbox-primary">
										                            <input type="checkbox" name="id" value="${user.id }"><span></span>
									                            </label>
															</td>
															<td>${status.index+1 }</td>
															<td style="word-break: break-word">${user.username }</td>
															<td>${user.phone }</td>
															<td style="word-break: break-word">${user.email }</td>
															<td>
																<label class="ftdms-switch switch-outline switch-success">
										                        	<input type="checkbox" ${user.state==1?'checked=""':'' } 
										                        		onclick="doUpdateState(${user.id},${user.state==1?2:1 },this)">
										                        	<span></span>
										                      	</label>
															</td>
															<td>${user.createtime }</td>
															<td class="td-manage">
																<div class="btn-group ">
										                            <a class="btn btn-xs btn-info submenuitem" style="margin-right:2px"
										                            	href="${pageContext.request.contextPath}/admin/user/update?id=${user.id}" 
										                            	title="编辑" data-toggle="tooltip" data-original-title="编辑">
										                            	<i class="ftsucai-edit-2"></i>
										                            </a>
										                            <a class="btn btn-xs btn-info submenuitem" style="margin-right:2px"
										                            	title="重置密码" href="javascript:resetPassword(${user.id })">
																		<i class="ftsucai-117"></i>
																	</a>
										                            <a class="btn btn-xs btn-info submenuitem" 
										                            	href="javascript:deleteBatch(${user.id }false)"
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
								                      	<td colspan="8">暂无数据</td>
								                    </tr>
							                    </c:otherwise>
						                    </c:choose>
				                    	</tbody>
				                  	</table>
				                </div>
								<form action="${pageContext.request.contextPath}/admin/user/list" method="post" id="form">
						        	<input type="hidden" name="pageNum" value="${pageBean.pageNum}" id="pageNum">
						        	<input type="hidden" name="username" value="${username }" >
						        	<input type="hidden" name="state" value="${state }" >
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
				$("#table tbody").find("input[name='id']:checkbox:checked").each(function(){
					ids+=$(this).val()+",";
				});
				if(ids==""){
					layer.msg("请至少选择一条数据！");return;
				}
			}
		    layer.confirm("确认删除？",{icon:7,title:"删除"},function(index){
			   layer.close(index);
			   var data = "ids="+ids;
		       common_ajax_other("admin/user/deleteBatch",data);
		   	});
		}
		
		//重置密码
		function resetPassword(id){
			layer.confirm("确认重置用户密码？",{icon:7,title:"重置密码"},function(index){
			   layer.close(index);
			   var data = "id="+id;
		       common_ajax_other("admin/user/resetPassword",data);
		   	});
		}
		
		//解锁或者锁定
		function doUpdateState(userid, state, thisCheckbox){
			var stateName = state==1?"解锁":(state==2?"锁定":"??");
			layer.confirm("确认"+stateName+"用户？",{icon:7,title:stateName+"用户"},function(index){
			   	layer.close(index);
			   	var data = "id="+userid+"&state="+state;
		       	common_ajax_other("admin/user/doUpdateState",data);
		   	},function(index){
		   		$(thisCheckbox).attr("checked",state==1?false:true);
		   		$(thisCheckbox).prop("checked",state==1?false:true);
				layer.close(index);
		   	});
		}
	</script>
</html>