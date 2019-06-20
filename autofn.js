var n = {
	name : '1',
	name2 : '2'
}

;(function(t){
	//console.log(t.name)
})(n)

;!function (t) {
	//console.log(t.name2)
}(n)

function demo() {
	var s = '3'	
	;(function(t){
		//console.log(t)
	})(s)	
}
demo()

//考虑兼容用这个 不然直接typeof
function isFunction(fn) {
   return Object.prototype.toString.call(fn)=== '[object Function]'
}

//判断数据类型
function getType(obj) {
    var dataType = {
        '[object Null]': 'null',
        '[object Undefined]': 'undefiend',
        '[object Boolean]': 'boolean',
        '[object Number]': 'number',
        '[object String]': 'string',
        '[object Function]': 'function',
        '[object Array]': 'array',
        '[object Date]': 'date',
        '[object RegExp]': 'regexp',
        '[object Object]': 'object',
        '[object Error]': 'error'
    }
    return dataType[Object.prototype.toString.call(obj)];
}