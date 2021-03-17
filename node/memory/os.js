const os = require('os');

function format(bytes) {
	return (bytes / 1024 / 1024).toFixed(2) + "MB";
}

const totalmem = format(os.totalmem())
const freemem = format(os.freemem())

// 系统的总内存
console.info(totalmem)

// 系统的闲置内存
console.info(freemem)


// 内存泄漏原因
// 缓存
// 队列消费不及时
// 作用域未释放