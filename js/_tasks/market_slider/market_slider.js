$(document).ready(function() {

  window.liner = new window.Market.Liner($('.products .liner')).activate()
  
  var button_show_all_products = $('.js_show_all_products')
  button_show_all_products.on('click', function(event) {
    var products = $('.products')
    products.toggleClass('limited')
  })

})
