// 浏览器环境

function foo(num){
  this.count++; // 记录 foo 被调用次数
}
foo.count = 0;

window.count = 0;

for(let i=0; i<10; i++){
  if(i > 5){
    foo(i);
  }
}
console.log(foo.count, window.count); // 0 4