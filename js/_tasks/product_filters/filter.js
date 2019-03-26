;(function($) {
  "use strict"

  /**
   * Фабрика фильтров,
   * инстансы фабрики не создаем, храним только функции класса.
   */
  window.FilterFactory = function() {
  }

  /**
   * Метод класса FilterFactory для регистрации конструкторов фабрики
   * конструкторы хранятся в классе
   * @param  {Function} constructor_function
   * @return {void}
   */
  window.FilterFactory.register = function(constructor_function) {
    if (!(constructor_function instanceof Function)) {
      throw new window.Error('constructor_function is not function.')
    }
    this[constructor_function.name] = constructor_function
  }

  /**
   * Метод класса FilterFactory возвращает инстанс фильтра, тип фильтра (соответственно и конструктор) определяетяся на основании входящих данных.
   * @param  {#jQuery} filter
   * @param  {Object} filter_values
   * @param  {Object} selected_values
   * @return {#FilterType}
   */
  window.FilterFactory.new = function(filter, filter_values, selected_values) {
    var type = filter.attr(window.FilterFactory.options.attributes.type)
    if (typeof(type) != "string" || type == "") {
      throw new window.Error("Тип фильтра не определён по DOM.")
    }
    var constructor_class_name = 'Filter' + type.charAt(0).toUpperCase() + type.slice(1)
    var constructor_function = this[constructor_class_name]
    if (!(constructor_function instanceof Function)) {
      throw new window.Error('Конструктор "' + constructor_class_name + '" не найден.')
    }
    return new constructor_function(...arguments)
  }
  window.FilterFactory.options = {
    attributes: {
      type: 'data-filter_type',
    },
  }

  /**
   * Базовый класс для фильтров
   * @param {jQ} place
   * @param {Array} filter_values
   * @param {Array} selected_values
   */
  window.Filter = function(place, filter_values, selected_values) {
    this.options = Object.assign(window.Filter.options, this.constructor.options || {})
    this.place = place
    if (filter_values == null) {
      debugger
    }
    // this.values = filter_values.slice(0)
    // this.selected_values = selected_values.slice(0)
    this.values = filter_values
    this.selected_values = selected_values

    // Получает имя фильтра по DOM
    this.get_name = function() {
      return this.place.attr(this.options.attributes.name)
    }

    // Удаляет дом фильтра со страницы
    this.remove = function() {
      this.place.remove()
    }

    // // Должна добавлять переданные значения к выбранным и применять к интерфейсу
    // this.checkize_values = function(values) {console.log('> not implemented, now: Filter.prototype.checkize_values')}
    // // Должна применять только переданные значения, остальные убирать
    // this.apply_values = function(values) {console.log('> not implemented, now: Filter.prototype.apply_values')}
    // // Должна все значения фильтра делать невыбранными
    // this.reset_values = function(values) {console.log('> not implemented, now: Filter.prototype.reset_values')}
    // // Должна давать кликабельный доступ ко всем значениям фильтра
    // this.anable_all_pickers = function() {console.log('> not implemented, now: Filter.prototype.anable_all_pickers')}
    // // Убирает кликабельный доступ к определённому значению фильтра
    // this.disable_picker = function(picker_value) {console.log('> not implemented, now: Filter.prototype.disable_picker')}
    // this.activate = function() {console.log('> not implemented, now: Filter.prototype.activate_filter')}
  }
  window.Filter.options = {
    attributes: {
      name: 'data-filter'
    }
  }

  /**
   * Фильтр типа Флажок
   * @param {#jQuery} place   
   * @param {Object} filter_values
   * @param {Object} selected_values
   */
  window.FilterCheckbox = function FilterCheckbox(place, filter_values, selected_values) {
    window.Filter.apply(this, [...arguments])
    this.type = 'checkbox'
    this.labels = {}
    this.inputs = {}
    this.activate = function() {
      this.fill_parts()
      this.activate_change()
      this.apply_data_to_ui()
    }
    this.apply_data_to_ui = function() {
      for (var i = 0, l = this.selected_values.length; i < l; i++) {
        var value = this.selected_values[i].toString()
        var input = this.place.find(this.options.selectors.inputs + '[value="' + value + '"]')
        input[0].checked = true
      }
    }
    this.activate_change = function() {
      this.place.on(
        this.options.events.change,
        this.options.selectors.inputs,
        {instance: this},
        window.FilterCheckbox.change_handler
      )
    }
    this.fill_parts = function() {
      var instance = this
      this.place.find(this.options.selectors.labels).each(function(index, dom) {
        var label = $(dom)
        var input = label.find(instance.options.selectors.inputs)
        var value = input.val()
        instance.labels[value] = label
        instance.inputs[value] = input
      })
    }
    this.selected_values_push = function(value) {
      if (!this.selected_values.includes(value)) {
        this.selected_values.push(value)
      }
    }
    this.selected_values_pull = function(value) {
      for (var i = this.selected_values.length - 1; i >= 0; i--) {
        if (this.selected_values[i] == value) {
          this.selected_values.splice(i, 1)
        }
      }
    }
    this.anable_values = function(values) {
      if (values == null) {
        for (var value in this.labels) {
          var label = this.labels[value]
          var input = this.inputs[value]
          // label.css({"color": "inherit"})
          label.removeClass('disabled')
          input.prop('disabled', false)
        }
      } else {
        for (var i = 0, l = values.length; i < l; i++) {
          var value = values[i]
          var label = this.labels[value]
          var input = this.inputs[value]
          if (label == null) {
            continue
          }
          if (input == null) {
            continue
          }
          // label.css({"color": "inherit"})
          label.removeClass('disabled')
          input.prop('disabled', false)
        }
      }
    }
    this.disable_values = function(values) {
      if (values == null) {
        for (var value in this.labels) {
          var label = this.labels[value]
          var input = this.inputs[value]
          // label.css({"color": "gray"})
          label.addClass('disabled')
          input.prop('disabled', true)
        }
      } else {
        for (var i = 0, l = values.length; i < l; i++) {
          var value = values[i]
          var label = this.labels[value]
          var input = this.inputs[value]
          if (label == null) {
            continue
          }
          if (input == null) {
            continue
          }
          // label.css({"color": "gray"})
          label.addClass('disabled')
          input.prop('disabled', true)
        }
      }
    }
  }
  window.FilterCheckbox.options = {
    selectors: {
      inputs: 'input[type="checkbox"]',
      labels: 'label',
    },
    events: {
      change: "change",
    },
  }

  /**
   * Обрабатывает событие нажатия на флажок
   * @param  {Event} event
   * @return {void}
   */
  window.FilterCheckbox.change_handler = function function_name(event) {
    var instance = event.data.instance
    var input = $(this)
    var value = input.val().trim()
    if (this.checked) {
      instance.selected_values_push(value)
    } else {
      instance.selected_values_pull(value)
    }
    window.ProductFilters.get_instance().apply_filters()
  }
  // Флажок - потомок базового класса
  window.FilterCheckbox.prototype = Object.create(window.Filter.prototype)
  window.FilterCheckbox.prototype.constructor = window.FilterCheckbox
  // Регистрируем флажок в фабрике
  window.FilterFactory.register(window.FilterCheckbox)


  // // Фильтр типа Интервал
  // window.FilterInterval = function FilterInterval(name, pickers) {
  //   window.Filter.apply(this, arguments);
  //   this.type = 'interval'
  // }
  // // Флажок - потомок базового класса
  // window.FilterInterval.prototype = Object.create(window.Filter.prototype)
  // window.FilterInterval.prototype.constructor = window.FilterInterval
  // // Регистрируем флажок в фабрике
  // window.FilterFactory.register(window.FilterInterval)

})(jQuery);
