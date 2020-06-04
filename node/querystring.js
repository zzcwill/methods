let querystring = require('querystring')
let url = 'a=a&b=b&c=c'
let urlObj = querystring.parse(url)
let urlStr =  querystring.stringify(urlObj)
let encode = querystring.escape(urlStr)
let unencode = querystring.unescape(encode)

console.info(urlObj)
console.info(urlStr)
console.info(encode)
console.info(unencode)

