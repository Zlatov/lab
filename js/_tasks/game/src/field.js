"use strict"

// Создание ячейки
// Вызывается через создание поля Field
function Cell(id, x, y, type) {
  this.id = id
  this.x = x
  this.y = y
  this.drawing = new Path2D()
  this.drawing.rect(this.x * Field.scale, this.y * Field.scale, Field.scale, Field.scale)
  this.siblings = []
  // 0 - свободное поле
  // 1 - препятствие
  // 2 - стартовая ячейка
  // 3 - финишная ячейка
  this.type = type
  this.draw = function() {
    Field.instance.context.lineWidth = 1
    switch(this.type) {
      case 0:
        Field.instance.context.fillStyle = "rgb(220,220,200)"
        Field.instance.context.strokeStyle = "rgb(200,200,180)"
      break
      case 1:
        Field.instance.context.fillStyle = "#7c7758"
        Field.instance.context.strokeStyle = "#7b7657"
      break
      case 2:
        Field.instance.context.fillStyle = "rgb(255,10,10)"
        Field.instance.context.strokeStyle = "rgb(0,200,0)"
      break
      case 3:
        Field.instance.context.fillStyle = "rgb(10,255,10)"
        Field.instance.context.strokeStyle = "rgb(0,200,0)"
      break
      default:
        throw new Error("Тип ячейки не определён");
      break
    }
    Field.instance.context.fill(this.drawing)
    Field.instance.context.stroke(this.drawing)
  }
}

// Создание поля
// Вызывается через Field.create(параметры создания)
function Field(width, height, rocks, start_id, finish_id) {
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
  this.path = []
  this.start_id = start_id
  this.finish_id = finish_id
  var id = 0
  for (var y = 0; y < this.height; y++) {
    for (var x = 0; x < this.width; x++) {
      var type = 0
      if (rocks.includes(id)) {
        type = 1
      }
      if (id == start_id) {
        type = 2
      }
      if (id == finish_id) {
        type = 3
      }
      var cell = new Cell(id, x, y, type)
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

Field.create = function(width, height, rocks, start_id, finish_id) {
  this.instance = new Field(width, height, rocks, start_id, finish_id)
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

Field.calc_path = function(start_cell_id) {
  var open_ids = []
  var close_ids = []
  var cell_datas = {}
  var current_id = start_cell_id || this.instance.start_id

  console.log('current_id: ', current_id)

  // Текущую в Закрытый список
  close_ids.push(current_id)
  console.log('close_ids: ', close_ids)

  // Поиск соседей
  open_ids = open_ids.filter((e) => !close_ids.includes(e))
  open_ids.push(...(Field.nearest(current_id)).filter((e) => !close_ids.includes(e)))
  console.log('open_ids: ', open_ids)

  // while(!close_ids.includes(this.instance.finish_id)) {
  for (var i = 0; i < 20; i++) {






    // Расчёт Открытого списка
    open_ids.forEach((open_id, i, a) => {
      var passed = 10
      if (current_id != this.instance.start_id) {
        passed = passed + cell_datas[current_id].passed
      }
      var gotta = Field.gotta(open_id)
      var weight = passed + gotta
      cell_datas[open_id] = {
        id: open_id,
        prev_id: current_id,
        passed: passed,
        gotta: gotta,
        weight: weight
      }
    })
    console.log('cell_datas: ', cell_datas)


    // Выбор Текущей
    current_id = open_ids.reduce((prev, curr) => cell_datas[prev].weight < cell_datas[curr].weight ? prev : curr)
    console.log('current_id: ', current_id)

    // Текущую в Закрытый список
    close_ids.push(current_id)
    console.log('close_ids: ', close_ids)

    // Поиск соседей
    // = + (Ближайшие - Закрытые)
    open_ids = open_ids.filter((e) => !close_ids.includes(e))
    open_ids.push(...(Field.nearest(current_id).filter((e) => !close_ids.includes(e))))
    console.log('open_ids: ', open_ids)





  }
}

// Поиск клеток для открытого списка (клетки на которые можно ступить за 1
// шаг).
Field.nearest = function(cell_id) {
  var result = []
  var cell = this.instance.cells[cell_id]
  if (cell.x > 0) {
    if (this.instance.xy_cells[cell.x - 1][cell.y].type == 0) {
      result.push(this.instance.xy_cells[cell.x - 1][cell.y].id)
    }
  }
  if (cell.x < this.instance.width - 1) {
    if (this.instance.xy_cells[cell.x + 1][cell.y].type == 0) {
      result.push(this.instance.xy_cells[cell.x + 1][cell.y].id)
    }
  }
  if (cell.y > 0) {
    if (this.instance.xy_cells[cell.x][cell.y - 1].type == 0) {
      result.push(this.instance.xy_cells[cell.x][cell.y - 1].id)
    }
  }
  if (cell.y < this.instance.height - 1) {
    if (this.instance.xy_cells[cell.x][cell.y + 1].type == 0) {
      result.push(this.instance.xy_cells[cell.x][cell.y + 1].id)
    }
  }
  return result
}

// Эвристическое приближение расстояние которое осталось пройти до выхода.
Field.gotta = function(cell_id) {
  var finish_cell = this.instance.cells[this.instance.finish_id]
  var cell = this.instance.cells[cell_id]
  return (Math.abs(finish_cell.x - cell.x) + Math.abs(finish_cell.y - cell.y)) * 10
}

Field.show_path = function() {
  $("#field_path span").text(this.instance.path.join(', '))
}

export { Field }
