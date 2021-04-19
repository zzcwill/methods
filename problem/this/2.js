// 浏览器环境

function foo(){
  var a = 2;
  this.bar();
}
function bar(){
  console.log(this.a);
}
foo();