function box(num1,num2){
	return num1+num2;
}

function sum(num1,num2){
	//this 表示全局作用域，浏览器环境下window，node环境global，[]表示传递的参数
	return box.apply(this,[num1,num2]);

	//或者下面写法arguments可以当数组传递
	//return box.apply(this,arguments);
}

console.log(sum(10,10)); //输出结果: 20