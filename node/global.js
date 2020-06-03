let { cacheData } = require('./cacheData')

let isImport = require.main === module
let isImport2 = module.parent === null
let cache = require.cache
let dirname = __dirname
let filename = __filename

console.info(!isImport)
console.info(!isImport2)
console.info(cache)
console.info(cacheData)
console.info(dirname)
console.info(filename)

console.time('time');
console.timeEnd('time');