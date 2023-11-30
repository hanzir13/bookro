//公共ajax异步提交数据
function common_ajax(url,data){
	var tempUrl = url;
	var options = {
			url: basePath+url,
			type: 'post',
            dataType: 'json',
            data:data,
            success: function (data) {
            	if(data.success>0){
            		layer.msg("操作成功！");
              		if(data.url!=null && data.url!=""){
              			if(data.url=="reload"){
              				setTimeout(function () {window.location.reload(); }, globalTimeout); 
              			}else{
              				setTimeout(function () {location.href=basePath+data.url; }, globalTimeout);
              			}
              		}
              	}else{
              		layer.msg("操作失败！");
              	}
            },
            error:function(data){
            	errorFunction(data,tempUrl);
            }
     };
     $.ajax(options);
}

//公共ajax请求，自行处理返回结果
function common_ajax_self_result(url,data,callback){
	var tempUrl = url;
	var options = {
			url: basePath+url,
			type: 'post',
			dataType: 'json',
			data:data,
			success: function (data) {
				if(callback!=null){
					callback(data);
				}
			},
	        error:function(data){
	        	errorFunction(data,tempUrl);
	        }
	};
	$.ajax(options);
}


function common_ajax_other(url,data){
	var tempUrl = url;
	var options = {
			url: basePath+url,
			type: 'post',
			dataType: 'json',
			data:data,
			success: function (data) {
				if(data.success>0){
					if(data.message!=null && data.message!=""){
						layer.msg(data.message);
					}else{
						layer.msg("操作成功！");
					}
					if(data.url!=null && data.url!=""){
						if(data.url=="reload"){
              				setTimeout(function () {window.location.reload(); }, globalTimeout);  
              			}else{
              				setTimeout(function () {location.href=basePath+data.url; }, globalTimeout);
              			}
					}
				}else{
					if(data.message!=null && data.message!=""){
						layer.msg(data.message);
					}else{
						layer.msg("操作失败！");
					}
				}
			},
		    error:function(data){
		    	errorFunction(data,tempUrl);
		    }
	};
	$.ajax(options);
}


function common_ajax_callback_other(url,data,callbackSuccess,callbackError){
	var tempUrl = url;
	var options = {
			url: basePath+url,
			type: 'post',
			dataType: 'json',
			data:data,
			success: function (data) {
				if(data.success>0){
					if(data.message!=null && data.message!=""){
						layer.msg(data.message);
					}else{
						layer.msg("操作成功！");
					}
					if(data.url!=null && data.url!=""){
						if(data.url=="reload"){
              				setTimeout(function () {window.location.reload(); }, globalTimeout);             
              			}else{
              				setTimeout(function () {location.href=basePath+data.url; }, globalTimeout);
              			}
					}
					if(callbackSuccess!=null){
						callbackSuccess(data);
					}
				}else{
					if(data.message!=null && data.message!=""){
						layer.msg(data.message);
					}else{
						layer.msg("操作失败！");
					}
					if(callbackError!=null){
						callbackError(data);
					}
				}
			},
			error:function(data){
				errorFunction(data,tempUrl);
			}
	};
	$.ajax(options);
}

//如果操作失败，在这里处理
function errorFunction(data,tempUrl){
	console.info("ajaxError...");
	layer.msg("操作失败！请重新登录！");
	var loginUrl = "";
	//这里是直接跳转到admin登录页面,如果是front或者其他，需要添加跳转到front
	if(tempUrl.indexOf("admin")!=-1){
		loginUrl = "admin/login";
	}else{
		if(tempUrl.indexOf("user")!=-1){
			loginUrl = "login";
		}
	}
    if (window != top){
    	setTimeout(function () {
    		window.top.location.href = basePath+loginUrl;
    	}, globalTimeout);
    }else{
    	setTimeout(function () {
    		location.href = basePath+loginUrl;
    	}, globalTimeout);
    }
}

	