;(function() {
  "use strict"

  window.Market = {}

  // Типа слайдер,
  // прокручиваем линейку не важно с чем (не со слайдами), на фиксированное расстояние.
  window.Market.Liner = function(place, options=null) {
    if (!(place instanceof window.jQuery) || !place.length) {
      throw new window.Error('place is not jQuery object.')
    }
    this.place = place
    this.options = Object.assign(window.Market.Liner.options, options||{})
    this.position = 0
    this.count = this.place.children(this.options.division_selector).length
  }
  window.Market.Liner.prototype.activate_scroll = function() {
    var listener = $(this.options.listener_selector)
    listener.on('click', this.options.button_next_selector, {instance: this}, this.next_handler)
    listener.on('click', this.options.button_prev_selector, {instance: this}, this.prev_handler)
  }
  window.Market.Liner.prototype.next_handler = function(event) {
    var instance = event.data.instance
    var new_position = instance.calc_position(1)
    instance.set_position(new_position)
  }
  window.Market.Liner.prototype.prev_handler = function(event) {
    var instance = event.data.instance
    var new_position = instance.calc_position(-1)
    instance.set_position(new_position)
  }
  window.Market.Liner.prototype.calc_left = function() {
    return this.position * -this.options.division_width
  }
  window.Market.Liner.prototype.calc_position = function(direction=1) {
    var new_position = this.position + direction * this.options.division_step
    if (new_position + 1 > this.count - this.options.window_division) {
      new_position = this.count - this.options.window_division
    }
    if (new_position < 0) {
      new_position = 0
    }
    return new_position
  }
  window.Market.Liner.prototype.set_position = function(position) {
    this.position = position
    this.ui_apply_position()
  }
  window.Market.Liner.prototype.ui_apply_position = function() {
    var left = this.calc_left()
    this.place.css('left', left + 'px')
  }
  window.Market.Liner.options = {
    place_selector: '.cat_products',
    listener_selector: 'body',
    button_next_selector: '.products .pre_slider-next',
    button_prev_selector: '.products .pre_slider-prev',
    division_selector: '.product',
    division_width: 218,
    window_division: 4,
    division_step: 2
  }

})();
