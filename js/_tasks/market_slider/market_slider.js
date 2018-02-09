// $(document).ready(function() {
//   $('body').css('background-color', 'red')
// })

var next = $('.pre_slider-next')
next.on('click', function(event) {
  var button = $(this)
  var cat_products = button.parent().next('.cat_products')
  console.log('cat_products: ', cat_products)
  var first = cat_products.children('.product').first()
  var left = first.css('left')
  console.log('left: ', left)
  first.css('left', '100px')
})
