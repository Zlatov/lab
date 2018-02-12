$(document).ready(function() {

  window.liner = new window.Market.Liner($('.products .cat_products .line'))
  console.log('window.liner: ', window.liner)
  window.liner.activate_scroll()

  /*
  var next = $('.pre_slider-next')
  next.on('click', function(event) {
    var button = $(this)
    var cat_products = button.parent().next('.cat_products')
    console.log('cat_products: ', cat_products)
    var line = cat_products.children('.line')
    var left = parseInt(line.css('left'))
    console.log('left: ', left)
    line.css('left', (left - 214) + 'px')
  })
  */

  var button_show_all_products = $('.js_show_all_products')
  button_show_all_products.on('click', function(event) {
    var products = $('.products')
    products.toggleClass('limited')
  })

})
