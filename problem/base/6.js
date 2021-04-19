// typeof
// 检测基本类型

// instanceof
// 检测引用类型  数组，对象，正则


let box = [1,2,3];
console.log(box instanceof Array); //true

let box1={};
console.log(box1 instanceof Object); //true

let box2=/g/;
console.log(box2 instanceof RegExp); //true