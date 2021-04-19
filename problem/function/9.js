var box={
	user: 'zs',
	getThis:function(){
			return function(){
					return this;   
			};
	}
}

console.log(box.getThis()());