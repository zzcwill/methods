// var box={
// 	user: 'zs',
// 	getThis:function(){
// 			return function(){
// 					return this;   
// 			};
// 	}
// }

// console.log(box.getThis().call(box)); // { user: 'zs', getThis: [Function: getThis] }


var box={
	user: 'zs',
	getThis:function(){
			var that = this; // 此时的this指的是box对象
			return function(){
					return that.user;   
			};
	}
}

console.log(box.getThis()()); 