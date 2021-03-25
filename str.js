/*
* 字符串处理相关方法
* */



//去字符串左空格
function ltrim(str) {
	var reg = /^\s+/g
	return str.replace(reg,'')
}

//去字符串右空格
function rtrim(str) {
	var reg = /\s+$/g
	return str.replace(reg,'')
}

//去除字符串开始和结尾空格的方法；
function lrtrim(str) {
	var reg = /(^\s+)|(\s+$)/g
	return str.replace(reg,'')
}

//去除字符串里的所有空格
function alltrim(str) {
	var reg = /\s/g
	return str.replace(reg,'')
}


//替换url特殊字符
function encodeURIStr(str){ 
    str = str.replace(/"/g, "%22");
    str = str.replace(/:/g, "%3A");
    str = str.replace(/,/g, "%2C");
    str = str.replace(/\[/g, "%5B");
    str = str.replace(/\{/g, "%7B");
    str = str.replace(/\}/g, "%7D");
    str = str.replace(/\]/g, "%5D");
    return str; 
}

//str长度超出一定的数量，省略号处理
function strEllipsis(str,num) {
	if(str.length < num) {
		return str;
	}
	var newStr = str.slice(0,num-1) + '...';
	return newStr;
}

// 取num内随机数
function strRandomNumber(num) {
	var str = Math.round(Math.random()*num) + ''
	return str
}
