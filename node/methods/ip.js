//koa获取ip方法
function getips() {
	const proxy = this.app.proxy;
	const val = this.get(this.app.proxyIpHeader);
	let ips = proxy && val
		? val.split(/\s*,\s*/)
		: [];
	if (this.app.maxIpsCount > 0) {
		ips = ips.slice(-this.app.maxIpsCount);
	}
	return ips;
}
function getip() {
	if (!this[IP]) {
		this[IP] = this.ips[0] || this.socket.remoteAddress || '';
	}
	return this[IP];
}

//express
// req.ip

//node
function clientIPAddress(req) {
	const address = req.headers['x-forwarded-for'] || // 判断是否有反向代理 IP
	req.connection.remoteAddress || // 判断 connection 的远程 IP
	req.socket.remoteAddress || // 判断后端的 socket 的 IP
	req.connection.socket.remoteAddress;

	return address.replace(/::ffff:/ig, '');
}

const interfaces = require('os').networkInterfaces();
function serviceIPAddress(){
	for (const devName in interfaces) {
		const iface = interfaces[devName];

		for (let i = 0; i < iface.length; i++) {
				const alias = iface[i];
				if (alias.family === 'IPv4' && alias.address !== '127.0.0.1' && !alias.internal) {
						console.info(alias.address)
						return alias.address;
				}
		}
	}
}
serviceIPAddress()