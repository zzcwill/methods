/*
* 数组处理相关方法
* */


//是不是数组
function isArray(arr) {
	return Object.prototype.toString.call(arr)=== '[object Array]'
}

//让数组有indexOf方法
function getArrayIndexOf() {
	if(!Array.indexOf){
	    Array.prototype.indexOf = function(Object){
	        for(var i = 0;i<this.length;i++){
	            if(this[i] == Object){
	                return i;
	            }
	        }
	        return -1;
	    };
	};			
}


//去掉数组中重复元素方法
function getArrayOne(arr) {
	var newArr = []
	if(!arr.length) {
		return
	}
	for(var i = 0 ; i < arr.length ; i++) {
		if(newArr.indexOf(arr[i]) === -1) {
			newArr.push(arr[i])
		}
	}
	return newArr
}

//给数组都赋值false
function getArrayFalse(arr,key) {
	var newArr = []
	if(!arr.length) {
		return newArr
	}
	for(var i = 0 ; i < arr.length ; i++){
		newArr.push(false)
	}
	if(key !== -1) {
		newArr[key] = true
	}
	return newArr
	
}

//生成相应数组，元素为 n
function getArrNum(num) {
	var n = num * 1
	var arr = []
	for(var i = 0 ; i < n ; i++) {
		arr.push('');
	}
	return arr
}

//对象转数组
function objToArray(obj) {
	var arr = []
	var arr2 = []
	for(key in obj) {
		arr.push(key)
	}	
	for(var i = 0 ; i < arr.length ; i++) {
		arr2[arr[i]] = obj[arr[i]]
	}
	return arr2
}