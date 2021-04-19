function box(num1,num2){
	return num1+num2;
}

function sum2(num1,num2){
	return box.call(this,num1,num2);
}

console.log(sum2(10,10)); //输出结果: 20