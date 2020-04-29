'use strict'
const EventEmitter = require('events');
class MyEmitter extends EventEmitter {}
const myEmitter = new MyEmitter();

function handler(n){
    console.log(n);
}

function handler2(n){
    console.log(n * n);
}

myEmitter.on('event1', handler);
myEmitter.on('event2', handler);
myEmitter.on('event2', handler2);

myEmitter.on('removeListener', (name, hander) => {
    debugger;
    console.log(name);
});

myEmitter.emit('event1', 1);
myEmitter.emit('event2', 2);

myEmitter.removeListener('event1', handler);

myEmitter.removeAllListeners('event2');

myEmitter.emit('event1', 1);
myEmitter.emit('event2', 2);