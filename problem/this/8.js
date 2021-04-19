function fruit(){
  return () => {
    console.log(this.name);
  }
}
var apple = {
  name: '苹果'
}
var banana = {
  name: '香蕉'
}
var fruitCall = fruit.call(apple);
fruitCall.call(banana); // 苹果