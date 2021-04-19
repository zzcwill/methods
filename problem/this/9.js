function Fruit(name) {
  this.name = name;
}
Fruit.prototype.info = function() {
  console.log(this.name);
}
const f1 = new Fruit('Apple');
f1.info();
const f2 = { name: 'Banana' };
f2.info = f1.info;
f2.info()