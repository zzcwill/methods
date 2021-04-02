// 压缩图片
function compressImage(file, success, error) {
	// 图片小于1M不压缩
	if (file.size < Math.pow(1024*1, 2)) {
			return success(file);
	}

	var fileTypeImgPdf = ["image/png","image/jpeg"];
	if(fileTypeImgPdf.indexOf(file.type) === -1) {
			return success(file);
	}	

	var name = file.name; //文件名
	var reader = new FileReader();
	reader.readAsDataURL(file);
	reader.onload = e => {
			var src = e.target.result;
			
			var img = new Image();
			img.src = src;
			img.onload = e => {
					var w = img.width;
					var h = img.height;
					var quality = 0.5;  // 默认图片质量为0.92
					// 生成canvas
					var canvas = document.createElement('canvas');
					var ctx = canvas.getContext('2d');
					// 创建属性节点
					var anw = document.createAttribute("width");
					anw.nodeValue = w;
					var anh = document.createAttribute("height");
					anh.nodeValue = h;
					canvas.setAttributeNode(anw);
					canvas.setAttributeNode(anh);

					// 铺底色 PNG转JPEG时透明区域会变黑色
					ctx.fillStyle = "#fff";
					ctx.fillRect(0, 0, w, h);

					ctx.drawImage(img, 0, 0, w, h);
					// quality值越小，所绘制出的图像越模糊
					var base64 = canvas.toDataURL('image/jpeg', quality); // 图片格式jpeg或webp可以选0-1质量区间

					// 返回base64转blob的值
					console.log(`原图${(src.length/1024).toFixed(2)}kb`, `新图${(base64.length/1024).toFixed(2)}kb`);
					// 去掉url的头，并转换为byte
					var bytes = window.atob(base64.split(',')[1]);
					// 处理异常,将ascii码小于0的转换为大于0
					var ab = new ArrayBuffer(bytes.length);
					var ia = new Uint8Array(ab);
					for (let i = 0; i < bytes.length; i++) {
							ia[i] = bytes.charCodeAt(i);
					}
					var blob = new Blob([ab], {type : 'image/jpeg'});
					blob.name = name;

					success(blob);
			}
			img.onerror = e => {
					error(e);
			}
	}
	reader.onerror = e => {
			error(e);
	}
}	


compressImage(this.files[0], function(newBlob) {
	var formData = new FormData();
	formData.append('file', newBlob, newBlob.name);

	$.ajax({
		url: interUrl.basic + "storage/single",
		type: "post",
		data: formData,
		processData: false,
		contentType: false,
		success: function (res) {
			console.info(res)			
			//清空文件信息
			$("#upImageInput").val('')
		}
	});
});