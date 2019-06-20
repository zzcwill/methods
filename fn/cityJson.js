/*
* 省市对象处理相关方法
* */



//获取省份
function getProvince(data) {
	var arr = []
	if(!data.length) {
		return arr
	}
	for(var i = 0 ; i < data.length ; i++) {
		var index = arr.indexOf(data[i].province)
		if(index === -1) {
			arr.push(data[i].province)
		}
	}
	return arr
}

//获取省份下城市
function getCity(province, data) {
	var arr = []
	if(!data.length) {
		return arr
	}
	if(!province.length) {
		return arr
	}
	for(var i = 0 ; i < province.length ; i++) {
		var arr2 = []
		for(var j = 0 ; j < data.length ; j++) {
			if(province[i] === data[j].province) {
				arr2.push(data[j].city)
			}
		}
		arr[i] = arr2
	}
	return arr
}

//获取省份和城市一一对应
function getProvinceCity(province, city) {
	var arr = []
	if(!province.length) {
		return arr
	}
	if(!city.length) {
		return arr
	}

	for(var i = 0 ; i < province.length ; i++) {
		arr[province[i]] = city[i]
	}

	return arr
}