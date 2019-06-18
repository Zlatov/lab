;(function($, _) {

  "use strict"

  var instance

  var handlers = {
    dropdown_menu: {
      click: function(event) {
        event.stopPropagation()
        var instance = event.data.instance
        var dropdown_menu = $(this)
        if (event.target == this) {
          dropdown_menu.toggleClass("dropdowned")
        }
      },
      click_body: function(event) {
        var instance = event.data.instance
        var dropdown_menus = $(instance.options.selectors.dropdown_menu)
        dropdown_menus.removeClass("dropdowned")
      }
    }
  }

  function SassFramework(options=null) {
    this.options = Object.assign(this.constructor.default_options, options || {})
  }

  SassFramework.prototype.activate = function() {
    this.activate_dropdown_menu()
    return this
  }

  SassFramework.prototype.activate_dropdown_menu = function() {
    var dropdown_menus = $(this.options.selectors.dropdown_menu)
    dropdown_menus.on("click", {instance: this}, handlers.dropdown_menu.click)
    $("body").on("click", {instance: this}, handlers.dropdown_menu.click_body)
  }

  SassFramework.default_options = {
    selectors: {
      dropdown_menu: ".dropdown_menu:not(.hoverable)"
    }
  }

  SassFramework.activate = function(options=null) {
    return this.get_instance(options).activate()
  }
  SassFramework.get_instance = function(options=null) {
    if (instance == null) {
      instance = new this(options)
    }
    return instance
  }

  window.SassFramework = SassFramework

})(jQuery, _);
