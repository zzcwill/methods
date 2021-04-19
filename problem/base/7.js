// ReferenceError错误
// 一个未声明的变量


// TypeError错误
// 引用null、undefined类型的值中的属性，将会抛出TypeError异常错误


let a = null; // 或者a = undefined
console.log(a.b); // Uncaught TypeError: Cannot read property 'b' of null