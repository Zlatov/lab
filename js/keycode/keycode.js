;(function() {

  "use strict"

  $(document).ready(function(){
    var body = window.document.getElementsByTagName('body')
    window.pressed_keys = {}
    window.is_key_pressed = function(keyCode) {
      return window.pressed_keys[keyCode] || false
    }
    window.is_keys_pressed = function() {
      var keys = [...arguments]
      for (var index in keys) {
        var key = keys[index]
        if (!window.is_key_pressed(key)) {
          return false
        }
      }
      return true
    }
    $('body').on('keydown', function(event) {
      // if ( !e.metaKey ) {
      //   e.preventDefault();
      // }
      window.pressed_keys[event.keyCode] = true
    })
    $('body').on('keyup', function(event) {
      console.log('event.keyCode: ', event.keyCode)
      // if ( !e.metaKey ) {
      //   e.preventDefault();
      // }
      window.pressed_keys[event.keyCode] = false
    })


    $('body').on('keydown', function(event) {
      var ctrl_q = window.is_keys_pressed(17, 81)
      console.log('ctrl_q: ', ctrl_q)
    })
  })

})();

var body = document.querySelector('body')
body.onclick = function() {
  console.log(window.is_key_pressed(17))
}
