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
      var filter_values = window.uncached.product_filters.filter_values
      var selected_values = window.uncached.product_filters.selected_values
      var value_matches = window.uncached.product_filters.value_matches
      var filters = {}
      var products = $()
      instance = new Object({
        options: options,
        // Общий статус отвечающий за возможность активации
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
        hide_products: hide_products,
        show_products: show_products,
        calc_intersection_ids: calc_intersection_ids,
        calc_union_ids: calc_union_ids,
        calc_disabled_values: calc_disabled_values,
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

    function apply_filters() {
      // this.anable_all_pickers()
      // Если не выбрано не одного значения, то
      if (this.calc_selected_values_count() == 0) {
        // показать все товары
        this.show_products()
      // иначе,
      } else {
        // показывать по расчёту пересечения фильтров
        this.hide_products()
        var intersection_ids = this.calc_intersection_ids()
        this.show_products(intersection_ids)
        // и засерить значения
        var disabled_values = this.calc_disabled_values()
        console.log('disabled_values: ', disabled_values)
        // this.disable_values(disabled_values)
      }

    }

    function calc_selected_values_count() {
      var length = 0
      for (var filter_name in this.selected_values) {
        var values = this.selected_values[filter_name]
        length += values.length
      }
      return length
    }

    function calc_selected_filters() {
      var selected_filters = []
      for (var filter_name in this.selected_values) {
        var values = this.selected_values[filter_name]
        if (values.length > 0) {
          selected_filters.push(filter_name)
        }
      }
      return selected_filters
    }

    function hide_products() {
      this.products_place.find(this.options.selectors.product).hide()
    }

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

    function calc_intersection_ids() {
      var union_ids = {} // Массивы объединений по фильтрам
      var intersection_ids = []
      // Перебрать напиканное для того что бы
      for (var filter_name in this.selected_values) {
        var values = this.selected_values[filter_name]
        for (var i = 0, l = values.length; i < l; i++) {
          var value = values[i]
          // выбрать массивы идентификаторов товаров из соответствий
          var ids = this.value_matches[filter_name + " " + value]
          // и наполнить массивы объеденений (уникализировав) по имени фильтра
          union_ids[filter_name] = _.uniq((union_ids[filter_name] || []).concat(ids))
        }
      }
      // Сформировать массив масиивов
      for (var filter_name in union_ids) {
        intersection_ids.push(union_ids[filter_name])
      }
      // Если количество массивов 1 (выбран один фильтр), то вместо пересечения выбираем первый массив
      if (intersection_ids.length === 1) {
        intersection_ids = intersection_ids[0]
      // Если количество выбранных фильтров больше одного, то показываем товары на пересечении фильтров
      } else if (intersection_ids.length > 1) {
        intersection_ids = _.intersection.apply(_, intersection_ids)
      }
      return intersection_ids
    }


    function calc_union_ids() {
      var union_ids = []
      // Перебрать напиканное для того что бы
      for (var filter_name in this.selected_values) {
        var values = this.selected_values[filter_name]
        for (var i = 0, l = values.length; i < l; i++) {
          var value = values[i]
          // выбрать массивы идентификаторов товаров из соответствий
          var ids = this.value_matches[filter_name + " " + value]
          // и наполнить массив объеденения
          union_ids = _.uniq(union_ids.concat(ids))
        }
      }
      return union_ids
    }

    function calc_disabled_values() {
      var disabled_values = []
      var union_ids = this.calc_union_ids()
      var intersection_ids = this.calc_intersection_ids()
      // Если количество выбранных фильтров равно единице, то
      var selected_filters = this.calc_selected_filters()
      console.log()
      console.log('selected_filters.length: ', selected_filters.length)
      if (selected_filters.length == 1) {
        var filter_name = selected_filters[0]
        // ищем пересечение каждого нового соответствия с Объеденением исключая текущий фильтр,
        for (var name_value in this.value_matches) {
          if (name_value.substring(0, filter_name.length - 1) == filter_name) {
            continue
          }
          var matches = this.value_matches[name_value]
          var intersection = _.intersection(union_ids, matches)
          if (!intersection.length) {
            disabled_values.push(name_value)
          }
        }
      // иначе
      } else {
        // ищем пересечение каждого нового соответствия с Пересечением
        for (var name_value in this.value_matches) {
          var matches = this.value_matches[name_value]
          var intersection = _.intersection(intersection_ids, matches)
          if (!intersection.length) {
            disabled_values.push(name_value)
          }
        }
      }
      console.log('union_ids: ', union_ids)
      console.log('intersection_ids: ', intersection_ids)
      return disabled_values
    }

    function generate_filters() {
      var instance = this
      this.filters_place.find(this.options.selectors.filter).each(function(index, dom) {
        var filter = $(dom)
        var filter_name = filter.data(instance.options.data_attributes.filter_name)
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

    function check_activity(filters_place, products_place) {
      if (typeof(filters_place) === 'object' && typeof(products_place) === 'object') {
        if (filters_place.length == 1 && products_place) {
          return true
        }
      }
      return false
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
