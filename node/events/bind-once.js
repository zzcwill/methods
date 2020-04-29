
'use strict'
const EventEmitter = require('events');
class MyEmitter extends EventEmitter {}

const myEmitter = new MyEmitter();
var m = 0;

myEmitter.on('event', () => {
    console.log(++m);
});
myEmitter.once('event2', () => {
  console.log(`Once: ${++m}`);
});

myEmitter.emit('event');
myEmitter.emit('event');
myEmitter.emit('event2');
myEmitter.emit('event2');