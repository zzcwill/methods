function decipher(encrypted){
	try{
			const crypto = require('crypto');

			const decipher = crypto.createDecipheriv('des-ecb', '12345678', '');

			let decrypted = decipher.update(encrypted, 'hex', 'utf8');
					decrypted += decipher.final('utf8');

			return decrypted;
	}catch(e){
			console.log('解密失败');

			return e.message || e;
	}
}

let str = decipher('28dba02eb5f6dd479a6144f98622a55caa67f06240f93005'); // hello world ！！！

console.info(str)