Function.prototype.myBind = function() {
	var thatFunc = this,
			thatArg = arguments[0];
	var args = Array.prototype.slice.call(arguments, 1);
	console.info(args)
	if (typeof thatFunc !== 'function') {
throw new TypeError('Function.prototype.bind - ' +
					 'what is trying to be bound is not callable');
	}

	return function(){
		var funcArgs = args.concat(Array.prototype.slice.call(arguments));
			return thatFunc.apply(thatArg, funcArgs);
	};
}

var obj = {name:"Smiley"};
var greeting = function(str, lang){
	this.value = 'greetingValue';
	console.log("Welcome "+this.name+" to "+str+" in "+lang);
};
var objGreeting = greeting.myBind(obj, 'the world'); 

objGreeting('JS')