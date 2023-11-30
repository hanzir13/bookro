/**
 * layui实现图片上传
 */
function upload_image(formFileId, upload, element, uploadUrl){
	//图片上传
  	var uploadInst = upload.render({
  	    elem: '#uploadFile',//上传文件按钮id
  	    url: basePath + uploadUrl,//上传url
  	    size: 10240,//限制文件大小，单位 KB
  	    number: 1,//上传文件数量
  	    accept: 'images',//文件格式
  	    method: 'post',//请求方式
  	    fileAccept: 'image/*',//文件格式
  	    exts: "jpg|png|gif|bmp|jpeg",//文件格式
  	    choose: function(obj){//选择文件之后的回调函数
  	      	//console.info('choose', obj);
  	    },
  	    before: function(obj){//选择文件之后，上传之前的回调函数
  	      	//预读本地文件示例，不支持ie8
  	      	obj.preview(function(index, file, result){
  	    	  	//选择之后，展示文件
  	       	  	$('#showImage').attr('src', result); //图片链接（base64）
  	      	});
  	    },
  	    done: function(res, index){//上传之后，回调函数
  	      	//如果上传失败
  	      	if(res.success > 0){
	  	      	layer.msg("文件上传成功！");
	  	      	console.info(res.newFileName);
	  	        $("#"+formFileId).val(res.newFileName);
  	      	}else{
  	      		return layer.alert('文件上传失败！');
  	      	}
  	    },
  	    error: function(index, upload){
  	      	this.item.html('重选上传');
  	      	layer.alert('文件上传失败！');
  	      	//演示失败状态，并实现重传
  	      	var fileText = $('#imageText');
  	      	//上传失败，展示 重试按钮
  	      	fileText.html('<a class="layui-btn layui-btn-mini upload-reload">重试</a>');
  	      	//重试按钮 绑定点击事件
  	  	  	fileText.find('.upload-reload').on('click', function(){
  	        	uploadInst.upload();
  	      	});
  	      	//上传进度条为0%
  	      	element.progress('uploadProgress', '0%');
  	    },
  	    progress: function(n, elem, res, index){//上传中回调函数
  	      	//console.log(n + '%', elem, res, index); //获取进度百分比
  	      	element.progress('uploadProgress', n + '%'); //可配合 layui 进度条元素使用
  	    }
    });
}
