"use strict"

// Создание ячейки
// Вызывается через создание поля Field
function Cell(id, x, y, is_rock) {
  this.id = id
  this.x = x
  this.y = y
  this.drawing = new Path2D()
  this.drawing.rect(this.x * Field.scale, this.y * Field.scale, Field.scale, Field.scale)
  this.siblings = []
  this.rock = is_rock
  this.draw = function() {
    Field.instance.context.strokeStyle = "rgb(0,200,0)"
    if (this.rock) {
      Field.instance.context.fillStyle = "rgb(155,155,100)"
    } else {
      Field.instance.context.fillStyle = "rgb(0,255,0)"
    }
    Field.instance.context.fill(this.drawing)
    Field.instance.context.stroke(this.drawing)
  }
}

// Создание поля
// Вызывается через Field.create(параметры создания)
function Field(width, height, rocks) {
  this.width = width
  this.height = height
  this.cells = []
  this.xy_cells = []
  this.$canvas = $("#field")
  this.canvas = this.$canvas[0]
  this.context = this.canvas.getContext('2d')
  this.enemies = []
  this.context.canvas.width = this.width * Field.scale
  this.context.canvas.height = this.height * Field.scale
  var id = 0
  for (var y = 0; y < this.height; y++) {
    for (var x = 0; x < this.width; x++) {
      var is_rock = rocks.includes(id)
      var cell = new Cell(id, x, y, is_rock)
      this.cells.push(cell)
      if (this.xy_cells[x] == undefined) {
        this.xy_cells[x] = []
      }
      this.xy_cells[x][y] = cell
      id ++
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
  this.clear = function() {
    this.context.clearRect(0, 0, this.canvas.width, this.canvas.height)
  }
  this.draw = function() {
    this.context.lineWidth = 4
    this.context.strokeStyle = "rgb(0,200,0)"
    this.cells.forEach(function(cell, i, a) {
      cell.draw()
    })
    // for (var i = 0; i < this.cells.length; i++) {
    //   var cell = this.instance.cells[i]
    //   if (cell.rock == false) {
    //     this.context.fillStyle = "rgb(0,255,0)"
    //   } else {
    //     this.context.fillStyle = "rgb(155,155,100)"
    //   }
    //   this.context.fill(cell.drawing)
    //   this.context.stroke(cell.drawing)
    // }
  }
}

Field.instance = undefined
Field.scale = 50

Field.create = function(width, height, rocks) {
  this.instance = new Field(width, height, rocks)
  // $canvas.on("mousemove", function(event) {
  //   // for (var i = 0; i < Field.instance.cells.length; i++) {
  //   //   var cell = Field.instance.cells[i]
  //   //   if (context.isPointInPath(cell.drawing, event.offsetX, event.offsetY)) {
  //   //     context.fillStyle = 'green';
  //   //   } else {
  //   //     context.fillStyle = 'red';
  //   //   }
  //   //   context.fill(cell.drawing)
  //   // }
  //   Field.context.fillStyle = "rgb(0,255,0)"
  //   Field.context.strokeStyle = "rgb(0,200,0)"
  //   for (var i = 0; i < Field.instance.cells.length; i++) {
  //     var cell = Field.instance.cells[i]
  //     if (cell.rock == false) {
  //       Field.context.fillStyle = "rgb(0,255,0)"
  //     } else {
  //       Field.context.fillStyle = "rgb(155,155,100)"
  //     }
  //     Field.context.fill(cell.drawing)
  //     Field.context.stroke(cell.drawing)
  //   }
  //   var x = Math.floor(event.offsetX / Field.scale)
  //   var y = Math.floor(event.offsetY / Field.scale)
  //   var cell = Field.instance.xy_cells[x][y]
  //   Field.context.fillStyle = "rgb(155,255,155)"
  //   Field.context.strokeStyle = "rgb(155,200,155)"
  //   Field.context.fill(cell.drawing)
  //   Field.context.stroke(cell.drawing)
  //   // context.fillStyle = "rgb(0,255,0)"
  //   // context.strokeStyle = "rgb(0,200,0)"
  //   // cell.siblings.forEach(function(e, i, a) {
  //   //   context.fill(e.drawing)
  //   //   context.stroke(e.drawing)
  //   // })
  // })
  // $canvas.on("mouseleave", function(event) {
  //   Field.context.strokeStyle = "rgb(0,200,0)"
  //   for (var i = 0; i < Field.instance.cells.length; i++) {
  //     var cell = Field.instance.cells[i]
  //     if (cell.rock == false) {
  //       Field.context.fillStyle = "rgb(0,255,0)"
  //     } else {
  //       Field.context.fillStyle = "rgb(155,155,100)"
  //     }
  //     Field.context.fill(cell.drawing)
  //     Field.context.stroke(cell.drawing)
  //   }
  // })
  return this.instance
}

export { Field }
