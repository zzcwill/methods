const buf = Buffer.from('Node.js 技术栈', 'utf8');

console.log(buf); // <Buffer 4e 6f 64 65 2e 6a 73 20 e6 8a 80 e6 9c af e6 a0 88>
console.log(buf.length); // 17
console.log(buf.toString('utf8', 0, 9)); // Node.js �
console.log(buf.toString('utf8')); // Node.js �