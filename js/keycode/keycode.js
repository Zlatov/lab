;(function(){
"use strict"
  $(document).ready(function(){
    var body = window.document.getElementsByTagName('body')
    window.pressed_keys = {}
    window.is_key_pressed = function(keyCode) {
      return window.pressed_keys[keyCode] || false
    }
    $('body').on('keydown', function(event) {
      // if ( !e.metaKey ) {
      //   e.preventDefault();
      // }
      window.pressed_keys[event.keyCode] = true
    })
    $('body').on('keyup', function(event) {
      // if ( !e.metaKey ) {
      //   e.preventDefault();
      // }
      window.pressed_keys[event.keyCode] = false
    })
  })
})()

var body = document.querySelector('body')
body.onclick = function() {
  console.log(window.is_key_pressed(17))
}
