process.nextTick(function () {
	console.log('nextTick延迟执行');
});
setImmediate(function () {
	console.log('setImmediate延迟执行');
});
setTimeout(function(){
	console.log('setTimeout延迟执行');
},0)
console.log('正常执行');