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
function getClientIp(req) {
	return req.headers['x-forwarded-for'] ||
	req.connection.remoteAddress ||
	req.socket.remoteAddress ||
	req.connection.socket.remoteAddress;
}