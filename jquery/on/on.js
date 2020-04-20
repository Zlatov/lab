// 
// blur, focus, focusin, focusout,
// load, resize, scroll, unload, click, dblclick,
// mousedown, mouseup, mousemove, mouseover, mouseout, mouseenter, mouseleave,
// change, select, submit, keydown, keypress, keyup, error
// 


// 2 способа передачи this в обработчик:

// 1. `.bind(this)`

$("div").on('click', '.children', this.handler.bind(this))

// 2. `event.data`

var Filters = {}

Filters.init = function() {
  $("div").on('click', '.children', {instance: this}, this.handler)
}

Filters.handler = function(event) {
  var changer = $(this)
  var instance = event.data.instance
  instance.calc(changer.data("id"))
}

Filters.calc = function() {
}
