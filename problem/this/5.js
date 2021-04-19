function fruit(...args){
  console.log(this.name, args);
}
var apple = {
  name: '苹果'
}
var banana = {
  name: '香蕉'
}
fruit.call(banana, 'a', 'b')  // [ 'a', 'b' ]
fruit.apply(apple, ['a', 'b']) // [ 'a', 'b' ]