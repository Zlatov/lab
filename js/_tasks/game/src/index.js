import "./index.scss"

import "jquery"

import "./field"

import { Timer } from "./timer"
import { Enemy } from "./enemy"
import { Field } from "./field"
window.Field = Field


$(document).ready(function() {
  Timer.init()
  Field.create(10, 10, [21,22], 0, 23)
  Field.instance.draw()
  Field.calc_path()
  var enemy = new Enemy()
  Field.instance.enemies.push(enemy)
  enemy.draw()
})
