/*
* 时间处理相关方法
* */
function sleep(ms) {
  var start = Date.now(), expire = start + ms;
  while (Date.now() < expire) ;
  return true;
}
function sleepPromise(ms) {
	return new Promise((resolve, reject) => setTimeout(() => {
		resolve(ms);
		
	}, ms));
}
// console.time('zzc')
// sleepPromise(4000).then((data)=>{
// 	console.info(data)
// 	console.timeEnd('zzc')
// })


//获取当前时间的毫秒
function getTimeMs() {
	var t = new Date()
	return t.getTime()
}

//获取明天开始时间毫秒
function getTomorrowMs(){
	var t = new Date()
	t.setHours(0)
	t.setMinutes(0)
	t.setSeconds(0)
	t.setMilliseconds(0)
	var tomorrowMs = t.getTime() + 1000 * 60 * 60 * 24
	return tomorrowMs
}

//获取当前时间小时和分
function getTimeHM(){
	var date = new Date()
	var h = date.getHours()
	var m = date.getMinutes()
		m = m < 10 ? '0' + m : '' + m		
	return h + ':' + m
}

//获取当前日期时间，转成形如2019-02-28
function getTimeYMD() {
	var t = new Date()
	var y = t.getFullYear()
	var m = t.getMonth() + 1
	var d = t.getDate()
	m = m < 10 ? '0' + m : m
	d = d < 10 ? '0' + d : d
	var str = y + '-' + m + '-' + d
	return str
}

//获取当前时间  全部信息
function getTime() {
	var date = new Date()
	var y = date.getFullYear() + '年'
	var m = date.getMonth() + 1 + '月'
	var d = date.getDate() + '日'
	var w = date.getDay()
	var week = ['日','一','二','三','四','五','六']
		w = ' 星期' + week[w]
	var am = date.getHours() >= 12 ? ' 下午 ' : ' 上午 '
	var h = date.getHours() >12 ? date.getHours() - 12:date.getHours()
		h = h < 10 ? '0' + h : '' + h
	var mi = date.getMinutes()
		mi = mi<10 ? '0' + mi : '' + mi
	var s = date.getSeconds()
		s = s<10 ? '0' + s : '' + s
	var str = y + m + d + w + am + h + ':' + mi + ':' + s
		return str
}


//根据毫秒  转换时间
function msToTime(t) {
	var t = new Date(t)
	var y = t.getFullYear()
	var m = t.getMonth() + 1
	var d = t.getDate()
	m = m < 10 ? '0' + m : m
	d = d < 10 ? '0' + d : d
	var str = y + '-' + m + '-' + d
	return str
}

//把毫秒的日期时间，转成形如2019-02-28  减去或者加几年
function msToTime2(date,type) {
	var t = new Date(date)
	var y=t.getFullYear()+type
	var m=t.getMonth()+1
	m = m < 10 ? '0'+m : m
	var d=t.getDate()
	d = d < 10 ? '0'+d : d
	var str=y+'-'+m+'-'+d
	return str
}

//毫秒时间判断今天明天
function msjudgeDay(time){
	var t = new Date();
	t.setHours(0);
	t.setMinutes(0);
	t.setSeconds(0);
	t.setMilliseconds(0);
	tnd = t.getTime()+1000 * 60 * 60 * 24;
	tnnd = t.getTime()+1000 * 60 * 60 * 48;
	if(time >= tnnd){
		return '后天';
	}else if(time >= tnd){
		return '明天';
	}else if(time < tnd){
		return '今天';
	}else{
		return '时间有误';
	}
}

//毫秒转天时小时毫秒
function getTimeDHMS(t){
	function checkTime(i) { //将0-9的数字前面加上0，例1变为01 
		if(i < 10) {
			i = "0" + i;
		}
		return i;
	}    	
	var days = parseInt(t / 1000 / 60 / 60 / 24 , 10); //计算剩余的天数 
	var hours = parseInt(t / 1000 / 60 / 60 % 24 , 10); //计算剩余的小时 
	var minutes = parseInt(t / 1000 / 60 % 60, 10);//计算剩余的分钟 
	var seconds = parseInt(t / 1000 % 60, 10);//计算剩余的秒数 
	days = checkTime(days); 
	hours = checkTime(hours); 
	minutes = checkTime(minutes); 
	seconds = checkTime(seconds);
	
	return days+"天" + hours+"小时" + minutes+"分"+seconds+"秒";		
}

//获取上个月1号日期
function getPreMonthOneDay() {
	var date = getTimeYMD();
	var arr = date.split('-');
	var year = arr[0]; //获取当前日期的年份
	var month = arr[1]; //获取当前日期的月份

	var year2 = year;
	var month2 = parseInt(month) - 1;
	if (month2 == 0) {
			year2 = parseInt(year2) - 1;
			month2 = 12;
	}

	if (month2 < 10) {
			month2 = '0' + month2;
	}
	var t2 = year2 + '-' + month2 + '-' + '01';
	return t2;
}


//获取下几个月的日期
function getNextSomeMonthOneDay(day, loanTerm) {
	var date = day;
	var arr = date.split('-');
	var year = arr[0]; //获取当前日期的年份
	var month = arr[1]; //获取当前日期的月份

	var nextYearNum = parseInt(loanTerm / 12);
	var nextMonthNum = loanTerm % 12;

	var year2 = parseInt(year) + nextYearNum;
	var month2 = parseInt(month) + nextMonthNum;

	if (month2 > 12) {
		month2 = month2 - 12;
		year2 = year2 + 1
	}

	if (month2 < 10) {
			month2 = '0' + month2;
	}
	var t2 = year2 + '-' + month2 + '-' + arr[2];
	return t2;
}