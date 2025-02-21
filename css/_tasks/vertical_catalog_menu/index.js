"use strict"

$(document).ready(function() {
  $(".vertical_catalog_menu").on("click", "span", function(event) {
    var li = $(this).parent()
    li.toggleClass("open")
  })
  $(".vertical_catalog_menu.autoopen a.current").parents("li").each(function(index, dom) {
    if (index != 0) {
      var li = $(this)
      li.addClass("open")
    }
  })
})
