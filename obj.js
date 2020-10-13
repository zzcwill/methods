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

//深度copy
function deepCopy(elments){
    //根据传入的元素判断是数组还是对象
    let newElments = elments instanceof Array ? [] : {};

    for(let key in elments){
        //注意数组也是对象类型，如果遍历的元素是对象，进行深度拷贝
        newElments[key] = typeof elments[key] === 'object' ? copy(elments[key]) : elments[key];
    }

    return newElments;
}