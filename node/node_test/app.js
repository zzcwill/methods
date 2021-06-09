let http = require('http');

let server = http.createServer((req, res) => {
		console.info(res)
        debugger;
    res.writeHead(200);
    res.end('hello world');
});

server.listen(3000, () => {
    console.log('listenning on 3000');
});