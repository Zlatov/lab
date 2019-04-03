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
    this.name = this.place.attr(this.options.attributes.name)
    this.values = filter_values
    this.selected_values = selected_values // Ссылка на внешний источник данных, для влияния на коллекцию фильтров

    // Удаляет дом фильтра со страницы
    this.remove = function() {
      this.place.remove()
    }

    /**
     * Должна сделать переданные значения доступными для клика/выбора
     * @param  {Array} values (["10.65"])
     * @return {void}
     */
    this.anable_values = function(values) {
      throw new Error("> not implemented, now: Filter.prototype.anable_values")
    }

    /**
     * Должна сделать переданные значения не доступными для клика/выбора
     * @param  {[type]} values (["10.65"])
     * @return {void}
     */
    this.disable_values = function(values) {
      throw new Error("> not implemented, now: Filter.prototype.disable_values")
    }

    /**
     * Применяет данные к месту, делает активным…
     * @return {void}
     */
    this.activate = function() {
      throw new Error("> not implemented, now: Filter.prototype.activate")
    }
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
  function FilterCheckbox(place, filter_values, selected_values) {
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
        FilterCheckbox.change_handler
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
          // input.prop('disabled', false)
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
          // input.prop('disabled', false)
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
          // input.prop('disabled', true)
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
          // input.prop('disabled', true)
        }
      }
    }
  }
  FilterCheckbox.options = {
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
  FilterCheckbox.change_handler = function(event) {
    var instance = event.data.instance
    var input = $(this)
    var label = input.parents('label').first()
    var disabled = label.hasClass('disabled')
    var value = input.val().trim()
    if (this.checked) {
      if (disabled) {
        input.prop('checked', false)
        return null
      }
      instance.selected_values_push(value)
    } else {
      instance.selected_values_pull(value)
    }
    window.ProductFilters.get_instance().apply_filters()
  }
  // Флажок - потомок базового класса
  FilterCheckbox.prototype = Object.create(window.Filter.prototype)
  FilterCheckbox.prototype.constructor = FilterCheckbox
  // Регистрируем флажок в фабрике
  window.FilterFactory.register(FilterCheckbox)

  /**
   * Фильтр типа Интервал
   * Инпуты должны использоваться только в том случае, если все значения фильтра числовые, TODO подумать как конфигурировать / определять этот факт.
   * @param {#jQuery} place   
   * @param {Object} filter_values
   * @param {Object} selected_values
   */
  function FilterInterval(place, filter_values, selected_values) {
    window.Filter.apply(this, [...arguments])
    this.type = 'interval'
    this.activate = function() {
      this.activate_slider()
      this.activate_fromto()
    }
    this.anable_values = function(values) {
    }
    this.disable_values = function(values) {
    }
    this.from = $(this.options.selectors.from)
    this.to = $(this.options.selectors.to)
    this.slider = $(this.options.selectors.slider)
    this.enabled_values = this.values.slice(0)

    /**
     * Активирует слайдер:
     * * слайдер должен влиять на инпуты
     * * должен вызывать функцию update_selected_values(from_value, to_value)
     * @return {void}
     */
    this.activate_slider = function() {
      var instance = this
      // Индекс с которого начинаем слайдер зависит от разрешенных значений
      var from_index = (this.enabled_values.length > 0) ? this.values.indexOf(this.enabled_values[0]) : 0
      // Индекс которым заканчиваем слайдер зависит от разрешенных значений
      var to_index = (this.enabled_values.length > 0) ? this.values.lastIndexOf(this.enabled_values[this.enabled_values.length - 1]) : this.values.length - 1
      this.slider.slider({
        range: true,
        min: 0,
        max: this.values.length - 1,
        values: [from_index, to_index],
        slide: function(event, ui) {
          // Что происходит при слайдинге:
          var slider = $(this)
          // запомним выставленные пользователем значения, вдруг через секунду он передумает.
          var from_value = instance.values[ui.values[0]]
          var to_value = instance.values[ui.values[1]]
          // покажем пользователю что он выбрал,
          instance.from.val(from_value)
          instance.to.val(to_value)
          // Через секунду:
          setTimeout(function() {
            // проверим, изменились ли значения.
            var new_indexes = slider.slider('option', 'values')
            var new_values = [instance.values[new_indexes[0]], instance.values[new_indexes[1]]]
            if (
              from_value !== new_values[0] ||
              to_value !== new_values[1]
            ) {
              // Изменились - ничего не делаем.
              return null
            }
            instance.update_selected_values(from_value, to_value)
          }, 1000)
        }
      })
    }

    /**
     * Метод необходим для влияния UI на данные, слайдер и инпуты должны вызывать его при изменениях.
     * @param  {String} from_value - теперь От этого значения (так говорит пользователь)
     * @param  {String} to_value - теперь До этого значения (так говорит пользователь)
     * @return {void}
     */
    this.update_selected_values = function(from_value, to_value) {
      this.selected_values.length = 0
      var from_index = this.values.indexOf(from_value)
      var to_index = this.values.indexOf(to_value)
      if (typeof(from_index) !== "number" || typeof(to_index) !== "number") {
        throw new window.Error("Не определён индекс выбранного значения.")
      }
      this.selected_values.push(...this.values.slice(from_index, to_index + 1))
      window.ProductFilters.get_instance().apply_filters()
    }

    /**
     * Активируем инпуты:
     * * должны влиять на слайдер
     * * должны вызывать update_selected_values(from_value, to_value)
     * @return {void}
     */
    this.activate_fromto = function() {
      this.from.on('keyup', {instance: this}, this.keyup_handler)
      this.to.on('keyup', {instance: this}, this.keyup_handler)
    }
    this.from_keyup_timeout_id = null
    this.to_keyup_timeout_id = null
    /**
     * Обработчик нажатия клавиши на инпутах с двумя стадиями фильтрации событий:
     * 1. Если через секунду значение инпута успело измениться, тогда прекращаем обработку события
     * 2. Выполним обработку данных только в том случае, если определённое время не приходило событий.
     * @param  {[type]} event [description]
     * @return {[type]}       [description]
     */
    this.keyup_handler = function(event) {
      var instance = event.data.instance
      var slider = instance.slider
      var it = $(this) // from или to
      var it_name = it.hasClass('from') ? 'from' : it.hasClass('to') ? 'to' : null
      if (it_name == null) {
        throw new Error("Не удалось определить тип input")
      }
      // Запомним текущее значение указанное пользователем, проверим через секунду, вдруг передумает
      var value = it.val()
      // Первый этап - проверяем значение.
      setTimeout(function() {
        if (value !== it.val()) {
          return null
        }
        // Второй этап - ожидаем тишины событий.
        clearTimeout(instance[it_name + '_keyup_timeout_id'])
        instance[it_name + '_keyup_timeout_id'] = setTimeout(function() {
          // Чистим данные пользователя
          var from_user_value = String(instance.from.val()).replace(/[^0-9.,]/gi, '').replace(/,/g, '.')
          if (from_user_value == '') {
            from_user_value = instance.values[0].replace(',', '.')
          }
          var to_user_value = String(instance.to.val()).replace(/[^0-9.,]/gi, '').replace(/,/g, '.')
          if (to_user_value == '') {
            to_user_value = instance.values[instance.values.length - 1].replace(',', '.')
          }
          // Влияние на себя
          instance.from.val(from_user_value)
          instance.to.val(to_user_value)
          // Пройдём значения с начала, чтобы найти первое удовлетворяющее пользователя как ОТ
          var from_index = null
          for (var i = 0, l = instance.values.length; i < l; i++) {
            if (
              Number(instance.values[i].replace(',', '.')) >=
              Number(from_user_value)
            ) {
              from_index = i
              break
            }
          }
          // Пройдём значения с конца, чтобы найти первое удовлетворяющее пользователя как ДО
          var to_index = null
          for (var i = instance.values.length - 1; i >= 0; i--) {
            if (
              Number(instance.values[i].replace(',', '.')) <=
              Number(to_user_value)
            ) {
              to_index = i
              break
            }
          }
          // Не найдены все индексы или не найден один:
          if (from_index == null && to_index == null) {
            from_index = 0
            to_index = instance.values.length - 1
          } else if (from_index == null || to_index == null) {
            from_index = from_index == null ? to_index : from_index
            to_index = to_index == null ? from_index : to_index
          }
          // Влияние на слайдер
          slider.slider({values: [from_index, to_index]})
          // Вызываем update_selected_values(from_value, to_value)
          instance.update_selected_values(instance.values[from_index], instance.values[to_index])
        }, 1000)
      }, 1000)
    }
  }
  // Интервал - потомок базового класса
  FilterInterval.prototype = Object.create(window.Filter.prototype)
  FilterInterval.prototype.constructor = FilterInterval
  // Регистрируем интервал в фабрике
  window.FilterFactory.register(FilterInterval)
  FilterInterval.options = {
    selectors: {
      from: '.from',
      to: '.to',
      slider: '.slider',
    },
  }

})(jQuery);
