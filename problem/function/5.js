function box(num){ // 按值传递
	num+=10;
	return num;
}
var num=50;

console.log(box(num));  // 60
console.log(num);        // 50