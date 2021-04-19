function fruit(){
  console.log(this.name);
}
var apple = {
  name: '苹果'
}
fruit = fruit.bind(apple);
fruit(); // 苹果