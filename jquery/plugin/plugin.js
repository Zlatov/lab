;(function($) {
  "use strict"

  $.fn.plugin = function(o = null) {
    var data = this.data('plugin')
    if (!data) {
      var instance = $.fn.plugin.initialize.bind(this)(o)
      instance.data('plugin', {
        instance: instance
      })
    } else {
      instance = data.instance
    }
    return instance
  }

  $.fn.plugin.options = {
    a: 'asd',
    b: 1
  }

  $.fn.plugin.initialize = function(o) {
    this.foo = function() {
      console.log('> instance method')
      console.log('$.fn.plugin.options: ', $.fn.plugin.options)
      console.log('this.options: ', this.options)
    }
    this.options = $.extend($.fn.plugin.options, o || {});
    var opt = $.extend($.fn.plugin.options, o); // temp variable, not a field of instance
    this.each(function(index, dom) {
    });
    return this
  }

})(jQuery);
