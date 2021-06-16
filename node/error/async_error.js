function test() {
  throw new Error('test error');
}

function main() {  
  // test();

	try{
		test()
	}catch(err){
		console.info(err)
	}

	// 异步-错误栈丢失
	// setImmediate(() => test());

	// try{
	// 	setImmediate(() => test());
	// }catch(err){
	// 	console.info(err)
	// }
}

main();

