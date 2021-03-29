//上传图片
$("#upImage").click(function () {
	$("#upImageInput").trigger("click");
});
$("#upImageInput").change(function () {
	var formData = new FormData();
	var _this = this;

	var limitByte = 5 * 1024 * 1024

	console.info(_this.files[0].size / 1024 / 1024)
	if (_this.files[0].size > limitByte) {
		tip({
			content: '上传的文件,大小不能超过5mb'
		})
		return
	}
	var fileTypeImgPdf = ["image/png", "image/jpeg", "application/pdf"];
	if (fileTypeImgPdf.indexOf(_this.files[0].type) === -1) {
		tip({
			content: '上传的文件,只能图片和pdf'
		})
		return
	}


	formData.append('file', _this.files[0]);

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