;(function($){
"use strict"

    $.widget("iadfeshchm.shiftable", {
      options: {
        shiftOnly: null,
        afterClickCallback: function(event) {},
        beforeClickCallback: function(event) {}
      },

      _create: function() {
        this._bindEvents();
        console.log('> create')
        console.log(this)
        this.element.addClass('shiftable')
      },

      _setOptions: function(options) {
        // Вызывается при установке одной или набора опций
        // var widget = $('.class').data('vendor-widgetName');
        // widget.option('someOption', 'value');
        
        console.log('_setOptions');
        this._super(options);
      },

      _setOption: function(key, value) {
        // Вызывается для каждой переданной опции
        console.log('_setOption');
        this._super(key, value);
      },

      _bindEvents: function() {
        var self = this;

        this.element.on('click.shiftable', '.shiftable-b', function(event) {
          var th = $(event.target).parents('.shiftable-c').first();
          if (th.length===0) {
            console.log('Не найдена колонка при клике на "В начало".');
            return null;
          }
          if (self.options.shiftOnly && !th.hasClass(self.options.shiftOnly)) {
            return null;
          }
          var position = th.index();
          if (self.options.shiftOnly) {
            var begin = th.prevAll('.' + self.options.shiftOnly).last();
          } else {
            var begin = th.prevAll().last();
          }
          // debugger;
          if (begin.length && begin.index()!=position) {
            var position_begin = begin.index()
            th.insertBefore(begin);
            var tds = self.element.find('tbody tr td:nth-child(' + (position + 1) + ')');
            tds.each(function(index,dom){
              $(dom).insertBefore($(dom).parent().children(':nth-child(' + (position_begin + 1) + ')'));
            });
          }
          // Бросает событие для callback ф-ции переданной в опциях
          self._trigger('afterClickCallback', event, ['additionalData']);

          // Бросает событие для DOM элемента виджета
          // self.element.trigger('afterClick', [slug, 2, 3]);
        }).on('click.shiftable', '.shiftable-l', function(event) {
          var th = $(event.target).parents('.shiftable-c').first();
          if (th.length===0) {
            console.log('Не найдена колонка при клике на "В лево".');
            return null;
          }
          if (self.options.shiftOnly && !th.hasClass(self.options.shiftOnly)) {
            return null;
          }
          var position = th.index();
          if (self.options.shiftOnly) {
            var prev = th.prev('.' + self.options.shiftOnly);
          } else {
            var prev = th.prev();
          }
          if (prev.length) {
            th.insertBefore(prev);
            var tds = self.element.find('tbody tr td:nth-child(' + (position + 1) + ')');
            tds.each(function(index,dom){
              $(dom).insertBefore($(dom).prev());
            });
          }
          // Бросает событие для callback ф-ции переданной в опциях
          self._trigger('afterClickCallback', event, ['additionalData']);

          // Бросает событие для DOM элемента виджета
          // self.element.trigger('afterClick', [slug, 2, 3]);
        }).on('click.shiftable', '.shiftable-r', function(event) {
          var th = $(event.target).parents('.shiftable-c').first();
          if (th.length===0) {
            console.log('Не найдена колонка при клике на "В право".');
            return null;
          }
          if (self.options.shiftOnly && !th.hasClass(self.options.shiftOnly)) {
            return null;
          }
          var position = th.index();
          if (self.options.shiftOnly) {
            var next = th.next('.' + self.options.shiftOnly);
          } else {
            var next = th.next();
          }
          if (next.length) {
            th.insertAfter(next);
            var tds = self.element.find('tbody tr td:nth-child(' + (position + 1) + ')');
            tds.each(function(index,dom){
              $(dom).insertAfter($(dom).next());
            });
          }

          // Бросает событие для callback ф-ции переданной в опциях
          self._trigger('afterClickCallback', event, ['additionalData']);

          // Бросает событие для DOM элемента виджета
          // self.element.trigger('afterClick', [slug, 2, 3]);
        }).on('click.shiftable', '.shiftable-e', function(event) {
          var th = $(event.target).parents('.shiftable-c').first();
          if (th.length===0) {
            console.log('Не найдена колонка при клике на "В конец".');
            return null;
          }
          if (self.options.shiftOnly && !th.hasClass(self.options.shiftOnly)) {
            return null;
          }
          var position = th.index();
          if (self.options.shiftOnly) {
            var end = th.nextAll('.' + self.options.shiftOnly).last();
          } else {
            var end = th.nextAll().last();
          }
          if (end.length && end.index()!=position) {
            var position_end = end.index()
            th.insertAfter(end);
            var tds = self.element.find('tbody tr td:nth-child(' + (position + 1) + ')');
            tds.each(function(index,dom){
              $(dom).insertAfter($(dom).parent().children(':nth-child(' + (position_end + 1) + ')'));
            });
          }

          // Бросает событие для callback ф-ции переданной в опциях
          self._trigger('afterClickCallback', event, ['additionalData']);

          // Бросает событие для DOM элемента виджета
          // self.element.trigger('afterClick', [slug, 2, 3]);
        });

        return this;
      },

      _destroy: function() {
        this.element.off('click.shiftable');
      }
    });

})(jQuery);
