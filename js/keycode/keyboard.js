// Класс отслеживающий нажатые клавиши, в том числе сочетания клавишь.
// Пример использования:
// 
// import { Keyboard } from "./keyboard"
// 
// $("body").on("keydown", function(event) {
//   var is_ctrl_q_pressed = Keyboard.shortcut_pressed(17, 81)
//   ...
// 
// Некоторые коды клавишь:
// Enter - 13
// Backspace - 8
// Space - 32
// Shift - 16
// Ctrl - 17
// Alt - 18, 230 (правый)
// Tab - 9
// ← - 37
// ↑ - 38
// → - 39
// ↓ - 40
// q - 81
// w - 87
// e - 69
// a - 65
// s - 83
// d - 68
// z - 90
// x - 88
// c - 67
// v - 86
// ` - 192
// - - 189
// _ - 16+189
// = - 187
// + - 16+187

"use strict"

var Keyboard = {
  pressed_keys: {}
}

Keyboard.key_pressed = function(keyCode) {
  return this.pressed_keys[keyCode] || false
}
Keyboard.shortcut_pressed = function() {
  var keys = [...arguments]
  for (var i = 0, l = keys.length; i < l; i++) {
    if (!this.key_pressed(keys[i])) {
      return false
    }
  }
  return true
}

$(document).on("turbolinks:load", function() {
  $("body").on("keydown", function(event) {
    // if ( !e.metaKey ) {
    //   e.preventDefault();
    // }
    Keyboard.pressed_keys[event.keyCode] = true
  })
  $("body").on("keyup", function(event) {
    // if ( !e.metaKey ) {
    //   e.preventDefault();
    // }
    Keyboard.pressed_keys[event.keyCode] = false
  })
})

export { Keyboard }
