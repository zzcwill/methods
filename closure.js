function f1() {

	let n = 0;

	nAdd = function () { n += 1 }

	function f2() {
		console.info(n);
	}

	return f2;

}

let result =  f1();

result(); // 999

nAdd();

result(); // 1000