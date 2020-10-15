let path = require('path')

console.info(process.env)
console.info(path.delimiter)
console.info(process.env.PATH.split(path.delimiter))
console.info('--')
console.info(process.argv)
console.info(process.cwd())

// 将当前控制台清空
// process.stdout.write('\033[2J')
// process.stdout.write('\033[0f')

const http = require('http');
const server = http.createServer((req, res) => {
    process.title = '测试进程Node.js'
    console.log(`process.pid: `, process.pid);

    res.end('zzc');
});

server.listen(3000);