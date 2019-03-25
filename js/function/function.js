"use strict"

console.log("> Параметры функии в js хранятся в объекте arguments,\n\
  хотя должны называться \"параметрами\" или \"переданными аргументами\",\n\
  так как аргументами они били тогда, когда их ещё передавали в функию.")
var a = function() {
  // arguments - объект с параметрами (переданными аргументами)
  console.log('arguments: ', arguments)
  console.log('arguments.length: ', arguments.length)
  console.log('arguments[0]: ', arguments[0])
  // аргументамы в массив
  var params = [...arguments]
  console.log('params: ', params)
  // передать массив как аргументы
  b(...params)
}
function b() {
  console.log('arguments: ', arguments)
}
a()
a(1)
return null

a = {
  "this is": "a",
  c: function() {
    console.log('this: ', this)
  }
}

a.b = function() {
  console.log('this: ', this)
}

d = {
  "this is": "d",
  e: function() {
    console.log('this: ', this)
  }
}

a.b()             // > this: {this is: "a", c: ƒ, b: ƒ}
a.c()             // > this: {this is: "a", c: ƒ, b: ƒ}
d.e()             // > this: {this is: "d", e: ƒ}

d.e.bind(a)()     // > this: {this is: "a", c: ƒ, b: ƒ}
d.e.call(a, 0)    // > this: {this is: "a", c: ƒ, b: ƒ}
d.e.apply(a, [0]) // > this: {this is: "a", c: ƒ, b: ƒ}

// 
// Использование .bind() возвращает новую функцию с новым контекстом, можно вызвать позже, удобно для назначения обработчиков событий.
// Использование .call() или .apply() если вы хотите немедленно вызвать функцию, изменив её контекст.
// 
// func.call(context, arg1, arg2)
// идентичен вызову
// func.apply(context, [arg1, arg2])
// 
