import "./index.scss"

import "jquery"

import "./field"

import { Timer } from "./timer"
import { Enemy } from "./enemy"
import { Field } from "./field"
window.Field = Field


$(document).ready(function() {
  Timer.init()
  Field.create(10, 10, [11,12], 0, 19)
  Field.calc_path()
  Field.show_path()
  Field.instance.draw()
  var enemy = new Enemy()
  Field.instance.enemies.push(enemy)
  enemy.draw()
})
