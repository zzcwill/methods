// 在 Node.js 环境里提供了 process.memoryUsage 方法用来查看当前进程内存使用情况，单位为字节
// rss（resident set size）：RAM 中保存的进程占用的内存部分，包括代码本身、栈、堆。
// heapTotal：堆中总共申请到的内存量。
// heapUsed：堆中目前用到的内存量，判断内存泄漏我们主要以这个字段为准。
// external： V8 引擎内部的 C++ 对象占用的内存。

// 单位为字节格式为 MB 输出
const format = function (bytes) {
  return (bytes / 1024 / 1024).toFixed(2) + ' MB';
};
// 封装 print 方法输出内存占用信息 
const print = function() {
  const memoryUsage = process.memoryUsage();

  console.log(JSON.stringify({
      rss: format(memoryUsage.rss),
      heapTotal: format(memoryUsage.heapTotal),
      heapUsed: format(memoryUsage.heapUsed),
      external: format(memoryUsage.external),
  }));
}


function Quantity(num) {
  if (num) {
      return new Array(num * 1024 * 1024);
  }

  return num;
}

function Fruit(name, quantity) {
  this.name = name
  this.quantity = new Quantity(quantity)
}

let apple = new Fruit('apple');
print();
let banana = new Fruit('banana', 20);
print();