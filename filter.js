/*
* 过滤器相关方法
* */



//code过滤器
function codefilter(arr,code) {
	var index = code * 1
	return arr[index]
}

//风险状态过滤器
function riskStateFilter(code) {
  var arr = ['未命中', '资信不佳', '一般风险', '中风险', '高风险', '拒绝'];
  return arr[code] || '';
}


