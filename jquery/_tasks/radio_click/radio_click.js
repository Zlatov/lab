window.order_activate_market_model_order_pickup = function() {
  var market_model_order_pickup_input = $("input[name=market_model_order\\[pickup\\]]")
  if (market_model_order_pickup_input.length == 0) {
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
    switch_pickup($(this).val() == "true")
  })
  switch_pickup($("input[name=market_model_order\\[pickup\\]]:checked").val() == "true")
}
