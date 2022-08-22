import "./index.scss"

import "jquery"

import "./field"

import { Field } from "./field"

Field.create(10, 10, [[1,2], [2,2]])

$(document).ready(function() {
  Field.draw()
})
