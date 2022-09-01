import { Field } from "./field"

var Enemy = function(id) {
  this.id = id
  this.path = Field.instance.path.slice(0)
  this.get_next_cell = function() {
    var i = Math.floor(this.x / Field.scale)
    var j = Math.floor(this.y / Field.scale)
    var curr_cell = Field.instance.xy_cells[i][j]
    var current_path_index = this.path.indexOf(curr_cell.id)
    var next_cell_id = this.path[current_path_index + 1]
    return Field.instance.cells[next_cell_id]
  }
  var i = Field.instance.cells[Field.instance.start_id].x
  var j = Field.instance.cells[Field.instance.start_id].y
  this.x = i * Field.scale + Math.round(Field.scale/2)
  this.y = j * Field.scale + Math.round(Field.scale/2)
  this.speed = 2
  this.draw = function() {
    Field.instance.context.fillStyle = "rgb(0,0,200)"
    Field.instance.context.strokeStyle = "rgb(0,0,255)"
    Field.instance.context.lineWidth = 10
    var drawing = new Path2D()
    drawing.arc(this.x, this.y, Field.scale/3, 0, Math.PI * 2)
    Field.instance.context.fill(drawing)
    Field.instance.context.stroke(drawing)
    // Field.instance.context.fillStyle = "black"
    // Field.instance.context.fillText(this.next_cell.id.toString(), this.x, this.y)
  }
  this.run = function() {
    var next_cell = this.get_next_cell()
    if (next_cell == null) {
      this.damage()
      this.destroy()
      return true
    }

    var dest_x = next_cell.x * Field.scale + Math.round(Field.scale/2) 
    var dest_y = next_cell.y * Field.scale + Math.round(Field.scale/2) 
    var dx = dest_x - this.x
    var dy = dest_y - this.y
    var alfa = Math.atan(dy / dx)
    if (dx < 0) {
      alfa = Math.PI + alfa
    }
    if (dy < 0 && dx > 0) {
      alfa = 2 * Math.PI + alfa
    }
    this.x = this.x + this.speed * Math.cos(alfa)
    this.y = this.y + this.speed * Math.sin(alfa)
  }
  this.damage = function() {
  }
  this.destroy = function() {
    delete Field.instance.enemies[this.id]
  }
}

export { Enemy }
