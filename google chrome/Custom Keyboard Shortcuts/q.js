;(function() {

  "use strict"
  
  var input = document.querySelector("textarea.gLFyf")
  if (input == null) {
    console.log('> Не найден поиск google.')
    return null
  } else {
    console.log('> Поиск google найден.')
  }

  if (input != document.activeElement) {
    input.focus()
  }

})();
