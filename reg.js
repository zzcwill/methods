/*
* 正则判断相关方法
* */



//一般个人信息
//是否中文名字
function judgeChinese(str) {	
	var reg = /^[\u4e00-\u9fa5]{2,11}$/
	return reg.test(str)
}

//是否是手机号
function judgePhone(str) {
	var reg = /^1[3456789]\d{9}$/
	return reg.test(str)
}

//是否邮箱
function judgeEmail(str) {	
	var reg = /^(\w)+(\.\w+)*@(\w)+((\.\w{2,3}){1,3})$/
	return reg.test(str)
}

//是否是QQ号 是 返回 true
function judgeQQ(str) {	
	var reg = /^[1-9]([0-9]{5,11})$/
	return reg.test(str)
}


//字符串判断
//是否正整数
function judgeZhengNumber(str) {	
	var reg = /^[1-9]\d*$/
	return reg.test(str)
}

//是否只有数字和字母
function judgeOnlyNumberLetter(str) {
	var reg = /^[0-9a-zA-Z]+$/
	return reg.test(str)
}
	
//是否包含汉字
function judgeHasChinese(str) {
	var reg = /.*[\u4e00-\u9fa5]+.*$/
	return reg.test(str)
}

//空格检验
function checkSpaceCharacter(val){
	var reg = /\s/;
	if(reg.exec(val)==null){
		return true;
	}else{
		return false;
	}
}

//是否有+号
function judgePlusSign(str) {
	var reg = /[\+]/g;
	return reg.test(str)
}

//判断是否满足保留几位小数
function judgeNumberDecimal(num, n) {
	var isOk = true;
	var str = num + '';
	var index = str.indexOf('.') + 1;
	var sum = str.length - index;

	if (sum > n) {
		isOk = false
	}
	return isOk;
}
//判断是否数字
function judgeNumber(num) {
	var isOK = true;
	var reg = /^[0-9]+.?[0-9]*/;
	if (!reg.test(num)) {
		isOK = false;
	}
	return isOK
}