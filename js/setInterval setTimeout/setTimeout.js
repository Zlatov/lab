// var timerId = setTimeout(func / code, delay[, arg1, arg2...])

function func() {
  console.log('> Привет');
}
setTimeout(func, 1000);

function func2(phrase, who) {
  console.log( phrase + ', ' + who );
}

setTimeout(func2, 1000, "Привет", "Вася"); // Привет, Вася

var timerId = setTimeout(function() { alert(1) }, 1000);
// число - идентификатор таймера
console.log('timerId: ', timerId)

clearTimeout(timerId);
// всё ещё число, оно не обнуляется после отмены
console.log('timerId: ', timerId)


// Функция запускаемая множество раз
function function_name() {
  // Идентификатор setTimeout необходимо хранить в объекте, на крайний случай глобально:
  if (window.run_search_timeout_id != null) {
    clearTimeout(window.run_search_timeout_id)
  }
  window.run_search_timeout_id = setTimeout(function() {
    alert(1)
  }, 2000)
}
