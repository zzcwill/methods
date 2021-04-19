function child() {
  console.log(this.name);
}
let parent = {
  name: 'zhangsan',
  child,
}
parent.child(); // zhangsan