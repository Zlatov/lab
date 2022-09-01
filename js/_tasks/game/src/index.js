import "./index.scss"

import "jquery"

import "./field"

import { Timer } from "./timer"
import { Enemy } from "./enemy"
import { Field } from "./field"
window.Field = Field


$(document).ready(function() {
  Timer.init()
  Field.create(10, 10, [20,21,22,23,41,42,43,44,45,46,47,48], 10, 93)
  Field.calc_path()
  Field.instance.draw()
  Field.instance.add_enemy()
  // enemy.draw()

  var $canvas = $("#test")
  var canvas = $canvas[0]
  var context = canvas.getContext('2d')
  context.canvas.width = 500
  context.canvas.height = 500
  function point(x, y, color = "black") {
    context.beginPath()
    context.arc(x, y, 1, 0, 2 * Math.PI, true)
    context.fillStyle = color
    context.fill()
  }
  var xs = [...Array(500).keys()]
  for (var x in xs) {
    var y = 20 + 10 * Math.sin(x * 1 / (12 * Math.PI))
    point(x, y, "#cacaca")
  }
  var x1 = 100
  var y1 = 100
  point(x1, y1)
  var x2 = 300
  var y2 = 150
  point(x2, y2)

  var a = [...Array(30).keys()]

  var x = x1
  var y = y1
  var xl = x1
  var yl = y1
  var ds = 10
  var alfa = Math.atan((y2 - y1) / (x2 - x1))
  a.forEach(function(t) {
    xl = xl + ds * Math.cos(alfa)
    yl = yl + ds * Math.sin(alfa)
    point(xl, yl, "green")
  })

  var center_x = 250
  var center_y = 250
  point(center_x, center_y, "red")
  for (var i in [...Array(36)]) {
    var grad = i * 10
    var alfa = grad * Math.PI / 180
    var arr_x = center_x + 100 * Math.cos(alfa)
    var arr_y = center_y + 100 * Math.sin(alfa)
    point(arr_x, arr_y, "green")
    var dy = arr_y - center_y
    var dx = arr_x - center_x
    var beta = Math.atan(dy / dx)
    if (dx < 0) {
      beta = Math.PI + beta
    }
    if (dy < 0 && dx > 0) {
      beta = 2 * Math.PI + beta
    }
    console.log('grad, alfa, beta: ', grad, alfa, beta)
  }

})
