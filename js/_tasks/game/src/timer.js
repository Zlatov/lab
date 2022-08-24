import { Field } from "./field"

var Timer = {
  id: null,
  interval: 35,
  prev_timestamp: 0,
  $button: null,
  $fps: null,
  $diff: null
}

Timer.init = function() {
  this.$button = $("#timer_button")
  this.$fps = $("#timer_fps")
  this.$diff = $("#timer_diff")
  this.$button.on("click", function(event) {
    // Timer.start()
    Timer.begin()
  })
}

Timer.callback = function() {
  Field.instance.clear()
  Field.instance.draw()
  Field.instance.enemies.forEach(function(enemy, i, a) {
    enemy.run()
    enemy.draw()
  })
}

// Timer.start = function() {
//   if (this.id == null) {
//     this.id = setInterval(this.callback, this.interval)
//   } else {
//     clearInterval(this.id)
//     this.id = null
//   }
// }

function step(timestamp) {
  Timer.id = requestAnimationFrame(step)
  var diff = timestamp - Timer.prev_timestamp
  var fps = 1000 / diff
  Timer.$diff.text(diff)
  Timer.$fps.text(fps)
  Timer.prev_timestamp = timestamp
  Timer.callback()
}

Timer.begin = function() {
  if (this.id == null) {
    this.id = requestAnimationFrame(step)
  } else {
    cancelAnimationFrame(this.id)
    this.id = null
  }
  if (Timer.id == null) {
    this.$button.text("Play")
  } else {
    this.$button.text("Stop")
  }
}

export { Timer }
