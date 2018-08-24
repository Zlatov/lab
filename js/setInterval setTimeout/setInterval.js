// 
// var timerId = setInterval(func / code, delay[, arg1, arg2...])
// 

// начать повторы с интервалом 2 сек
var timerId = setInterval(function() {
  console.log('> tic')
}, 2000);

// через 5 сек остановить повторы
setTimeout(function() {
  clearInterval(timerId);
  console.log('> stop')
}, 5000);
