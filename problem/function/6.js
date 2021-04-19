function box(obj){ // 按对象传递
	obj.num+=10;

	return obj.num;
}
var obj = { num: 50 };

console.log(box(obj));  // 60
console.log(obj.num);    // 60