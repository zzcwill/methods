function Fruit(name){
  this.name = name;
}

const f1 = new Fruit('apple');
const f2 = new Fruit('banana');
console.log(f1.name, f2.name); // apple banana