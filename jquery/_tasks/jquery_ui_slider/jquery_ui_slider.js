"use strict"

$(document).ready(function() {
  console.log('window: ', window)
  console.log('$.fn.jquery: ', $.fn.jquery)
  console.log('$().jquery: ', $().jquery)
  var a = $(".asd")
  console.log('a: ', a)
  $("#accordion").accordion()

  // Пример из документации
  $("#slider-range").slider({
    range: true,
    min: 0,
    max: 500,
    values: [75, 300],
    slide: function(event, ui) {
      $("#amount").val("$" + ui.values[0] + " - $" + ui.values[1])
    }
  })
  $("#amount").val(
    "$" + $("#slider-range").slider("values", 0) +
    " - $" + $("#slider-range").slider("values", 1)
  )

  // Пара слайдеров
  var sliders_data = {
    "1": {
      slider_values: [11.1, 15, 22.2], // У слайдера 1 будут только такие значения при проскроливании.
      from: 1, // это индекс значения "от" который будет выставлен сразу после инициализации.
      to: null // это индекс значения "до" который будет выставлен сразу после инициализации.
    },
    "2": {
      slider_values: [111.01, 222.12, 333.2, 444.200, 555.90],
      from: 0, // это индекс значения "от" который будет выставлен сразу после инициализации.
      to: 2 // это индекс значения "до" который будет выставлен сразу после инициализации.
    }
  }
  $(".slider").each(function(index, dom) {
    var slider = $(dom)
    var from = slider.siblings(".from").first()
    var to = slider.siblings(".to").first()
    var slider_id = slider.data("slider_id")
    var slider_values = sliders_data[slider_id].slider_values
    var start_index_from = sliders_data[slider_id].from || 0
    var start_index_to = sliders_data[slider_id].to || slider_values.length - 1
    from.val(slider_values[start_index_from])
    to.val(slider_values[start_index_to])
    slider.slider({
      range: true,
      min: 0, // Минимальный индек значений
      max: slider_values.length - 1, // Максимальный индекс значений
      values: [start_index_from, start_index_to], // Старотовые индексы выбранных значений на слайдере
      slide: function(event, ui) {
        var from_value = slider_values[ui.values[0]]
        var to_value = slider_values[ui.values[1]]
        from.val(from_value)
        to.val(to_value)
      }
    })
  })

})
