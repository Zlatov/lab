"use strict"

var x = '"\\u003cb\\u003estring\\u003c/b\\u003e"';
var a = JSON.parse(x)
console.log('a: ', a)
