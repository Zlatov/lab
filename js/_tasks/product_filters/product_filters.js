;(function($, _) {
  "use strict"

  /**
   * Синглтон класс отвечающий за коллекцию фильтров, хранение их данных и
   * фильтрацию продуктов.
   */
  window.ProductFilters = (function() {
    var instance

    /**
     * Возаращает экземпляр (синглтон) отвечающий за коллекцию фильтров и их влияние на продукты.
     * @return {Object}
     */
    var create_instance = function() {
      var options = Object.assign({}, window.ProductFilters.options)
      var filters_place = $(window.ProductFilters.options.selectors.filters_place)
      var products_place = $(window.ProductFilters.options.selectors.products_place)
      var filter_values = ((window.uncached || {}).product_filters || {}).filter_values || {}
      var selected_values = ((window.uncached || {}).product_filters || {}).selected_values || {}
      var value_matches = ((window.uncached || {}).product_filters || {}).value_matches || {}
      var filters = {}
      var products = $()
      instance = new Object({
        options: options,
        // Общий статус отвечающий за возможность активации, на основе некоторых данных
        activity_status: check_activity(filters_place, products_place),

        // jQ объекты мест коллекций
        filters_place: filters_place,
        products_place: products_place,

        // Данные для фильтров
        filter_values: Object.assign({}, filter_values),
        selected_values: Object.assign({}, selected_values),
        value_matches: Object.assign({}, value_matches),

        // Коллекции
        filters: filters,
        products: products,

        // Функционал коллекции
        activate: activate,
        generate_filters: generate_filters,
        activate_filters: activate_filters,
        generate_products: generate_products,
        apply_filters: apply_filters,
        anable_values: anable_values,
        disable_values: disable_values,
        hide_products: hide_products,
        show_products: show_products,
        calc_intersection_ids: calc_intersection_ids,
        calc_disabled_values: calc_disabled_values,
        calc_empty_matches: calc_empty_matches,
        calc_selected_values_count: calc_selected_values_count,
        calc_selected_filters: calc_selected_filters,
      })
      return instance
    }

    function activate() {
      if (!this.activity_status) {
        return this
      }
      this.generate_products()
      this.generate_filters()
      this.activate_filters()
      this.apply_filters()
      return this
    }

    /**
     * Применяет данные к фильтрам и продуктам (данные влияют на отображение, это метод применения данных к UI)
     * @return {void}
     */
    function apply_filters() {
      // В любом случае разрешим все значения, затем:
      this.anable_values()
      this.disable_values(this.calc_empty_matches()) // запретим с пустыми соответствиями
      this.disable_values(this.calc_disabled_values()) // запретим по расчёту

      // Товары:
      if (this.calc_selected_values_count() == 0) {
        this.show_products() // откроем все, если не выбран ни один фильтр
      } else {
        this.hide_products()
        this.show_products(this.calc_intersection_ids()) // откроем по расчёту
      }
    }

    /**
     * Заставляет фильтры сделать значения доступными для клика/выбора
     * @param  {Object} filter_values ({Цвет:["синий", "красный"]})
     * @return {void}
     */
    function anable_values(filter_values=null) {
      if (filter_values == null) {
        for (var filter_name in this.filters) {
          var filter = this.filters[filter_name]
          if (filter == null) {
            continue
          }
          filter.anable_values()
        }
        return null
      } else {
        for (var filter_name in filter_values) {
          var filter = this.filters[filter_name]
          if (filter == null) {
            continue
          }
          var values = filter_values[filter_name]
          filter.anable_values(values)
        }
      }
    }

    /**
     * Заставляет фильтры сделать значения не доступными для клика/выбора
     * @param  {Object} filter_values ({Цвет:["синий", "красный"]})
     * @return {void}
     */
    function disable_values(filter_values=null) {
      if (filter_values == null) {
        for (var filter_name in this.filters) {
          var filter = this.filters[filter_name]
          if (filter == null) {
            continue
          }
          filter.disable_values()
        }
        return null
      } else {
        for (var filter_name in filter_values) {
          var filter = this.filters[filter_name]
          if (filter == null) {
            continue
          }
          var values = filter_values[filter_name]
          filter.disable_values(values)
        }
      }
    }

    /**
     * Подсчитывает количество выбранных значений
     * @return {Number}
     */
    function calc_selected_values_count() {
      var length = 0
      for (var filter_name in this.selected_values) {
        var values = this.selected_values[filter_name]
        length += values.length
      }
      return length
    }

    /**
     * Возвращает массив имён выбранных фильтров
     * @param  {String} exclude_filter_name - кроме указанного имени фильтра.
     * @return {Array}
     */
    function calc_selected_filters(exclude_filter_name=null) {
      var selected_filters = []
      for (var filter_name in this.selected_values) {
        if (exclude_filter_name == filter_name) {
          continue
        }
        var values = this.selected_values[filter_name]
        if (values.length > 0) {
          selected_filters.push(filter_name)
        }
      }
      return selected_filters
    }

    /**
     * Прячет все продукты
     * @return {void}
     */
    function hide_products() {
      this.products_place.find(this.options.selectors.product).hide()
    }

    /**
     * Показывает все продукты или указанные
     * @param  {Array} ids ([1, 2, 17])
     * @return {void}
     */
    function show_products(ids=null) {
      if (ids == null) {
        this.products.show()
        return null
      }
      ids.forEach(function(element, index, array) {
        array[index] = element.toString()
      })
      var instance = this
      this.products.each(function(index, dom) {
        var product = $(dom)
        var product_id = product.attr(instance.options.attributes.product_id)
        if (ids.includes(product_id)) {
          product.show()
        }
      })
    }

    /**
     * Расчитывает пересечение объединений - объединяет соответствия внутри каждого фильтра,
     * соответсвия выбираются только если они напиканы.
     * Затем ищет пересечение между получившимися массивами. Например:
     * Напикано: Ширина 10; Ширина 15; Длинна 10
     * Соответствия: Ширина 10: [1, 2]
     *               Ширина 15: [3, 4]
     *               Длинна 10: [2, 3]
     * Объединения: Ширина: [1, 2, 3, 4]
     *              Длинна: [2, 3]
     * Пересечение: [2, 3] - показываются товары с ID 2 и 3.
     * @param  {String} exclude_filter_name - за исключением фильтра (используется для расчёт засеривания фильтров).
     * @return {Array}
     */
    function calc_intersection_ids(exclude_filter_name=null) {
      var union_ids = {} // Массивы объединений по фильтрам
      var intersection_ids = []
      // Перебрать напиканное для того что бы
      for (var filter_name in this.selected_values) {
        if (exclude_filter_name == filter_name) {
          continue
        }
        for (var i = 0, l = this.selected_values[filter_name].length; i < l; i++) {
          var value = this.selected_values[filter_name][i]
          var ids = (this.value_matches[filter_name] || {})[value] || []
          union_ids[filter_name] = union_ids[filter_name] || []
          union_ids[filter_name] = union_ids[filter_name].concat(ids)
        }
      }
      intersection_ids = _.uniq(_.intersection(...Object.values(union_ids)))
      return intersection_ids
    }

    /**
     * Определяет список значения для "засеривания"
     * @return {Object} ({Цвет:["синий", "красный"]})
     */
    function calc_disabled_values() {
      var disabled_values = {}
      for (var filter_name in this.value_matches) {
        var selected_filters = this.calc_selected_filters(filter_name)
        if (selected_filters.length == 0) {
          continue
        }
        for (var value in this.value_matches[filter_name]) {
          var matches = this.value_matches[filter_name][value]
          var intersection_selected = this.calc_intersection_ids(filter_name)
          var intersection = _.intersection(intersection_selected, matches)
          if (intersection.length == 0) {
            disabled_values[filter_name] = disabled_values[filter_name] || []
            disabled_values[filter_name].push(value)
          }
        }
      }
      return disabled_values
    }

    /**
     * Для определения значений изначально без соответствий для "засеривания".
     * @return {Object} ({Цвет:["синий", "красный"]})
     */
    function calc_empty_matches() {
      var empty_matches = {}
      for (var filter_name in this.value_matches) {
        var filter_matches = this.value_matches[filter_name]
        for (var value in filter_matches) {
          var matches = filter_matches[value]
          if (matches.length == 0) {
            empty_matches[filter_name] = empty_matches[filter_name] || []
            empty_matches[filter_name].push(value)
          }
        }
      }
      return empty_matches
    }

    /**
     * Генерирует хэш фильтров (по идентификационному имени) с экземплярами фильтровых классов
     * на основе DOM и js данных
     * @return {void}
     */
    function generate_filters() {
      var instance = this
      this.filters_place.find(this.options.selectors.filter).each(function(index, dom) {
        var filter = $(dom)
        var filter_name = filter.data(instance.options.data_attributes.filter_name)
        if (instance.filter_values[filter_name] == null) {
          instance.filter_values[filter_name] = []
        }
        var filter_values = instance.filter_values[filter_name]
        if (instance.selected_values[filter_name] == null) {
          instance.selected_values[filter_name] = []
        }
        var selected_values = instance.selected_values[filter_name]
        if (filter_values.length > 1) {
          var filter = window.FilterFactory.new(filter, filter_values, selected_values)
          instance.filters[filter_name] = filter
        }
      })
    }

    function generate_products() {
      this.products = $(this.options.selectors.product)
    }

    function activate_filters() {
      for (var filter_name in this.filters) {
        this.filters[filter_name].activate()
      }
    }

    /**
     * 
     * @param  {[type]} filters_place  [description]
     * @param  {[type]} products_place [description]
     * @return {[type]}                [description]
     */
    function check_activity(filters_place, products_place) {
      if (typeof(filters_place) !== 'object' || typeof(products_place) !== 'object') {
        return false
      }
      if (filters_place.length != 1 || products_place.length != 1) {
        return false
      }
      return true
    }

    return {
      options: {
        selectors: {
          filters_place: "#filters",
          products_place: "#products",
          filter: "div[data-filter][data-filter_type]",
          product: "div.product",
        },
        attributes: {
          product_id: "data-id",
        },
        data_attributes: {
          filter_name: "filter",
        },
      },
      get_instance: function() {
        if (instance == null) {
          instance = create_instance()
        }
        return instance
      },
      activate: function() {
        return this.get_instance().activate()
      }
    }
  })()

})(jQuery, _);
