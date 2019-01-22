;(function($) {
  "use strict"

  $.fn.autocompletei = function(options = null) {
    var data = this.data('autocompletei')
    if (!data) {
      var instance = $.fn.autocompletei.initialize.bind(this)(options)
      instance.data('autocompletei', {
        instance: instance
      })
    } else {
      instance = data.instance
    }
    return instance
  }

  $.fn.autocompletei.options = {
    a: 'asd',
    b: 1
  }

  $.fn.autocompletei.initialize = function(o) {
    // this.foo = function() {
    //   console.log('> instance method')
    //   console.log('$.fn.autocompletei.options: ', $.fn.autocompletei.options)
    //   console.log('this.options: ', this.options)
    // }
    this.options = $.extend($.fn.autocompletei.options, o || {})
    console.log('this.options: ', this.options)
    var instance = this
    this.on('keyup', {instance: instance}, function(event) {
      event.stopPropagation()
      var instance = event.data.instance
      console.log('event: ', event)
      console.log('this: ', this)
      console.log('instance: ', instance)
    })
    this.input = this.find('input').first()
    // debugger
    // console.log('this: ', this)
    this.input.after('<ul class="autocompletei-ul"><li>1</li><li>2</li></ul>')
    this.list = this.find('ul.autocompletei-ul').first
    var opt = $.extend($.fn.autocompletei.options, o); // temp variable, not a field of instance
    this.each(function(index, dom) {
    });
    return this
  }

})(jQuery);
