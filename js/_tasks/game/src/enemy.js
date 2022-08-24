import { Field } from "./field"

var Enemy = function() {
  this.i = 0
  this.j = 0
  this.x = Math.round(this.i*Field.scale/2 + Field.scale/2)
  this.y = Math.round(this.j*Field.scale/2 + Field.scale/2)
  this.draw = function() {
    Field.instance.context.fillStyle = "rgb(0,0,200)"
    Field.instance.context.strokeStyle = "rgb(0,0,255)"
    Field.instance.context.lineWidth = 10
    var drawing = new Path2D()
    drawing.arc(this.x, this.y, Field.scale/3, 0, Math.PI * 2)
    Field.instance.context.fill(drawing)
    Field.instance.context.stroke(drawing)
  }
  this.run = function() {
    this.x = this.x + 1
  }
}

export { Enemy }
