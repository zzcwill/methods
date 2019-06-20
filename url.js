/*
 * url处理相关方法
 * */

//获取url相应参数值
function getUrlParam(name) {
	var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)', 'i')
	var r = window.location.search.substr(1).match(reg)
	if(r !== null) {
		return unescape(r[2])
	}
	return null
}

//json对象转url地址传参拼接
function jsonToUrlParam(obj) {
	var str = ''
	for(var key in obj) {
		str = str + key + '=' + obj[key] + '&'
	}
	return str.substring(0, str.length - 1)
}

//jump
function jumpUrl(url) {
	location.href = url
}
function openUrl(url) {
	window.open(url)
}