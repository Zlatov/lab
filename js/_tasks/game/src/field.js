"use strict"

function Cell(id, x, y) {
  this.id = id
  this.x = x
  this.y = y
  this.drawing = new Path2D()
  this.drawing.rect(this.x * Field.scale, this.y * Field.scale, Field.scale, Field.scale)
  this.siblings = []
  this.rock = false
}

function Field(width, height, rocks) {
  this.width = width
  this.height = height
  this.cells = []
  this.xy_cells = []
  var id = 0
  var rock_sids = rocks.map(function(e) {
    return `${e[0]}-${e[1]}`
  })
  for (var x = 0; x < this.width; x++) {
    if (this.xy_cells[x] == undefined) {
      this.xy_cells[x] = []
    }
    for (var y = 0; y < this.height; y++) {
      var cell = new Cell(id, x, y)
      id ++
      this.cells.push(cell)
      this.xy_cells[x][y] = cell
      if (rock_sids.includes(`${x}-${y}`)) {
        cell.rock = true
      }
    }
  }
  for (var x = 0; x < this.width; x++) {
    for (var y = 0; y < this.height; y++) {
      var cell = this.xy_cells[x][y]
      var sibling_xys = [
        [x-1, y-1],
        [x-1, y  ],
        [x-1, y+1],
        [x  , y-1],
        [x  , y+1],
        [x+1, y-1],
        [x+1, y  ],
        [x+1, y+1]
      ]
      sibling_xys.forEach((e, i, a) => {
        if (e[0] >= 0 && e[0] < this.width && e[1] >= 0 && e[1] < this.height) {
          cell.siblings.push(this.xy_cells[e[0]][e[1]])
        }
      })
    }
  }
}

Field.instance = undefined
Field.scale = 50
Field.create = function(width, height, rocks) {
  var instance = new Field(width, height, rocks)
  Field.instance = instance
  return instance
}
Field.draw = function() {
  var $canvas = $("#field")
  var canvas = $canvas[0]
  var context = canvas.getContext('2d')
  context.canvas.width = this.instance.width * this.scale
  context.canvas.height = this.instance.height * this.scale
  context.lineWidth = 4
  context.strokeStyle = "rgb(0,200,0)"
  for (var i = 0; i < this.instance.cells.length; i++) {
    var cell = this.instance.cells[i]
    if (cell.rock == false) {
      context.fillStyle = "rgb(0,255,0)"
    } else {
      context.fillStyle = "rgb(155,155,100)"
    }
    context.fill(cell.drawing)
    context.stroke(cell.drawing)
  }
  $canvas.on("mousemove", function(event) {
    // for (var i = 0; i < Field.instance.cells.length; i++) {
    //   var cell = Field.instance.cells[i]
    //   if (context.isPointInPath(cell.drawing, event.offsetX, event.offsetY)) {
    //     context.fillStyle = 'green';
    //   } else {
    //     context.fillStyle = 'red';
    //   }
    //   context.fill(cell.drawing)
    // }
    context.fillStyle = "rgb(0,255,0)"
    context.strokeStyle = "rgb(0,200,0)"
    for (var i = 0; i < Field.instance.cells.length; i++) {
      var cell = Field.instance.cells[i]
      if (cell.rock == false) {
        context.fillStyle = "rgb(0,255,0)"
      } else {
        context.fillStyle = "rgb(155,155,100)"
      }
      context.fill(cell.drawing)
      context.stroke(cell.drawing)
    }
    var x = Math.floor(event.offsetX / Field.scale)
    var y = Math.floor(event.offsetY / Field.scale)
    var cell = Field.instance.xy_cells[x][y]
    context.fillStyle = "rgb(155,255,155)"
    context.strokeStyle = "rgb(155,200,155)"
    context.fill(cell.drawing)
    context.stroke(cell.drawing)
    // context.fillStyle = "rgb(0,255,0)"
    // context.strokeStyle = "rgb(0,200,0)"
    // cell.siblings.forEach(function(e, i, a) {
    //   context.fill(e.drawing)
    //   context.stroke(e.drawing)
    // })
  })
  $canvas.on("mouseleave", function(event) {
    context.strokeStyle = "rgb(0,200,0)"
    for (var i = 0; i < Field.instance.cells.length; i++) {
      var cell = Field.instance.cells[i]
      if (cell.rock == false) {
        context.fillStyle = "rgb(0,255,0)"
      } else {
        context.fillStyle = "rgb(155,155,100)"
      }
      context.fill(cell.drawing)
      context.stroke(cell.drawing)
    }
  })
}

export { Field }
