var foo = function () {
		(function () {
		console.log(local);
		}());
		var local = "局部变量";
	};

	foo()