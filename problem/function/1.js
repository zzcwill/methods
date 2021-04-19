console.log(test1(1, 2)); // 3
console.log(test2(1, 2)); // test2 is not defined

//函数声明
function test1(a, b){
    return a + b;
}

//函数表达式
const test2 = function f(a, b){
    return a + b;
}