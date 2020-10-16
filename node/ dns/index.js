const dns = require('dns');

dns.lookup('wwww.baidu.com', (err, address, family) => {
    console.log('地址: %j 地址族: IPv%s', address, family);
});

dns.resolve('wwww.baidu.com', (err, records) => {
	console.log(records);
});

// DNS-解析过程
// 浏览器 DNS 缓存 —> 系统（OS）缓存 -> 路由器缓存 -> ISP DNS 缓存


// DNS-本地解析
// 浏览器 DNS 缓存 —> 系统（OS）缓存