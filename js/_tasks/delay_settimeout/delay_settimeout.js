"use strict"

// $(document).ready(function() {
// })

var product = {
  options: {
    timeout_delay: 1000,
    leave_timeout_delay: 200,
    enter_timeout_delay: 500
  },
  cache: {
    enter_timeout_id: null,
    leave_timeout_id: null
  },
  ui_set_info: function(info) {
    $('.info').text(info)
  }
}

var mouseenter_handler = function(event) {
  if (window.product.cache.leave_timeout_id!=null) {
    clearTimeout(window.product.cache.leave_timeout_id)
  }
  var info = $(this).index()
  var enter_timeout_id = setTimeout(function() {
    window.product.ui_set_info(info)
  }, window.product.options.enter_timeout_delay)
  window.product.cache.enter_timeout_id = enter_timeout_id
}

var mouseleave_handler = function(event) {
  if (window.product.cache.enter_timeout_id!=null) {
    clearTimeout(window.product.cache.enter_timeout_id)
  }
  var info = 'initial'
  var leave_timeout_id = setTimeout(function() {
    window.product.ui_set_info(info)
  }, window.product.options.leave_timeout_delay)
  window.product.cache.leave_timeout_id = leave_timeout_id
}

$('body').on('mouseenter', '.item', window.mouseenter_handler)
$('body').on('mouseleave', '.item', window.mouseleave_handler)
