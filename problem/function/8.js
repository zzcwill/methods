{
	function test1() {
		var age = 1;

		return function () {
			// a++;
			// return a;
			// 或以下写法
			return ++age;
		}
	}

	var test2 = test1();

	console.log(test2()); // 2
	console.log(test2()); // 3
	console.log(test2()); // 4

	//不能这样写,这样外层函数每次也会执行，从而age每次都会初始化
	console.log(test1()()); // 2
	console.log(test1()()); // 2
	console.log(test1()()); // 2
}