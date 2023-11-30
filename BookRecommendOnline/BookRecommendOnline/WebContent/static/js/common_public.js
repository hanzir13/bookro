//管理员/用户列表页面全部选中或者全部不选中
$("#selectAll").change(function(){
	var checkboxState = $(this).is(":checked");//true或者false
	$("#table tbody").find("input[name='id']:checkbox").each(function(index,e){
		$(this).attr("checked",checkboxState);
		$(this).prop("checked",checkboxState);
	});
});
