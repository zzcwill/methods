'use strict'
function demo(){
  // TypeError: Cannot read property 'a' of undefined
  console.log(this.a);
}
const a = 1;
demo();