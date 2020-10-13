/*
 * 对象的相关处理方法
 * */

//获取对象属性个数
function attributeCount(obj) {
    var count = 0;
    for (var i in obj) {
        if (obj.hasOwnProperty(i)) {
            count++;
        }
    }
    return count;
}

//对象赋值
function dataToData(data1, data2) {
	var data = {}
	for (key in data1) {
		data[key] = data2[key];
	}

	return data;
}

//检查对象属性是否存在
var obj = { a: 1 };
console.log(obj.hasOwnProperty('a'))
console.log('a' in obj); // true