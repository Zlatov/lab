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

// Use .bind() возвращает новую функцию с новым контекстом, можно вызвать позже,
// useful in events. Use .call() or .apply() when you want to invoke the function
// immediately, and modify the context.
// func.call(context, arg1, arg2);
// // идентичен вызову
// func.apply(context, [arg1, arg2]);
