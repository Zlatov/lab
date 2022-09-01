var $canvas = $("#field")
var canvas = $canvas[0]
var context = canvas.getContext('2d')
context.canvas.width = 600
context.canvas.height = 400

// Оси
context.beginPath()
context.moveTo(0, 0)
context.lineTo(0, 400)
context.lineTo(10, 390)
context.moveTo(0, 0)
context.lineTo(600, 0)
context.lineTo(590, 10)
context.strokeStyle = "black"
context.lineWidth = 1
context.stroke()

// Разметка осей
for (var i = 0; i < 3; i++) {
  var x = i * 200
  context.beginPath()
  context.moveTo(x, 0)
  context.lineTo(x, 5)
  context.strokeStyle = "black"
  context.stroke()
  context.fillStyle = "black"
  context.fillText(x.toString(), x + 2, 10)
}
for (var j = 1; j < 2; j++) {
  var y = j * 200
  context.beginPath()
  context.moveTo(0, y)
  context.lineTo(5, y)
  context.strokeStyle = "black"
  context.stroke()
  context.fillStyle = "black"
  context.fillText(y.toString(), 1, y + 10)
}

var is = [...Array(41)]
var js = [...Array(41)]
for (var i in is) {
  for (var j in js) {
    var x = i * 10 + 5
    var y = j * 10 + 5
    context.beginPath()
    context.arc(x, y, 1, 0, 2 * Math.PI)
    context.fillStyle = "black"
    context.fill()
    var x2 = x - 10
    var y2 = y - 10
    var alfa = Math.PI/2 - ((x-200)/200) * Math.PI/4 - ((y)/400) * Math.PI/4 * ((x-200)/200)
    var x2 = x + 10 * Math.cos(alfa)
    var y2 = y + 10 * Math.sin(alfa)
    context.beginPath()
    context.moveTo(x, y)
    context.lineTo(x2, y2)
    context.strokeStyle = "red"
    context.stroke()
  }
}



console.log('> asd')



