let path = require('path')

console.info(path.dirname(__filename))
console.info(path.extname(__filename))
console.info(path.basename(__filename,'.js'))
console.info('--')
console.info(path.join(__dirname,'path2.js'))
console.info(path.resolve(__dirname,'path2.js'))
console.info(path.relative(__dirname,'/Users/zhengzhichao/Desktop/github-git/methods/demo/1.js'))
console.info('--')
console.info(path.parse(__filename))
console.info(path.format(path.parse(__filename)))
console.info(path.isAbsolute(__filename))