// 数组降维

// 1 将数组字符串化
// let arr = [[222, 333, 444], [55, 66, 77], 11, ]
// arr += '';
// arr = arr.split(',');
// arr = arr.map(item => Number(item));

// console.log(arr); // [222, 333, 444, 55, 66, 77, 11]


// 2 利用apply和concat转换
function reduceDimension(arr) {
	return Array.prototype.concat.apply([], arr);
}

console.log(reduceDimension([[123], 4, [7, 8],[9, [111]]]));