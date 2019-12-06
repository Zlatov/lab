window.order_activate_market_model_order_pickup = function() {
  var market_model_order_pickup_input = $("#market_model_order_pickup")
  if (market_model_order_pickup_input.length != 1) {
    return null
  }
  var switch_pickup = function(pickup) {
    if (pickup) {
      $('#by_order_delivery_address').slideUp()
      $('#by_order_pickup_affiliate').slideDown()
    } else {
      $('#by_order_delivery_address').slideDown()
      $('#by_order_pickup_affiliate').slideUp()
    }
  }
  market_model_order_pickup_input.on("change", function(event) {
    switch_pickup($(this).is(':checked'))
  })
  switch_pickup(market_model_order_pickup_input.is(':checked'))
}
