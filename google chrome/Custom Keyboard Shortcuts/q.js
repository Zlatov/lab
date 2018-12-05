;(function() {

  "use strict"
  
  // var input = window['lst-ib']
  var input = document.querySelector("input.gLFyf")
  if (input == null) {
    console.log('> no google input.')
    return null
  }
  if (input != document.activeElement) {
    input.focus()
  }

})();
