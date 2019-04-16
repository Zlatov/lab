;(function($, _) {

  "use strict"

  var instance

  /**
   * Конструктор синглтона.
   * @param {Object} options
   */
  function GroupFilters(value_matches, options=null) {
    this.options = Object.assign(this.constructor.default_options, options || {})
    if (value_matches == null) {
      throw new Error("Данные некорректны.")
    }
    this.place = $(this.options.selectors.place)
    if (this.place.length != 1) {
      throw new Error("Место некорректно.")
    }
    this.value_matches = Object.assign({}, value_matches)
    this.activate = function() {
      // this.generate_collection()
      this.activate_handlers()
      return this
    }
    this.generate_collection = function(argument) {
      this.place.find(this.options.selectors.groups).each(function(index, dom) {
        var group = $(dom)
        var group_id = group.attr(this.options.attributes.group_id)
        console.log('group_id: ', group_id)
        // var filters = group.find(this.options.selectors)
      }.bind(this))
    }
    this.activate_handlers = function() {
      // var groups = $(this.options.selectors.groups)
      // console.log('groups.length: ', groups.length)
      $(this.options.selectors.groups).on("change", this.options.selectors.values, this.a_handler)
    }
    this.a_handler = function(event) {
      // console.log('this: ', this)
      // console.log('event: ', event)
      // console.log('event.target: ', event.target)
      // console.log('event.currentTarget: ', event.currentTarget)
      // event.stopPropagation()
      event.stopImmediatePropagation()
      var field = $(event.target)
      var group = field.parents(this.options.selectors.groups).first()
      var group_id = group.attr(this.options.attributes.group_id)
      var value_matches = []
      for (var filter_name in this.value_matches[group_id]) {
        var filter_place = group.find(this.options.selectors.filters + "[" + this.options.attributes.filter_name + "=\"" + filter_name + "\"]")
        console.log('filter_place: ', filter_place)
        var filter_value = this.get_value(filter_place)
        console.log('filter_value: ', filter_value)
        var matches = this.value_matches[group_id][filter_name][filter_value]
        console.log('matches: ', matches)
        value_matches.push(matches)
      }
      console.log('value_matches: ', value_matches)
      if (value_matches.length == 1) {
        var articul = value_matches[0][0]
      } else {
        var articul = _.intersection(...value_matches)
      }
      console.log('articul: ', articul)
    }.bind(this)
    this.get_value = function(filter_place) {
      return filter_place.find("input:checked").first().val()
    }
  }
  /**
   * Опции по умолчанию для создания синглтона хранятся в классе.
   * @type {Object}
   */
  GroupFilters.default_options = {
    selectors: {
      place: ".js_group_filters_place",
      groups: ".js_group",
      filters: ".js_filter",
      values: ".js_value",
    },
    attributes: {
      group_id: "data-id",
      filter_name: "data-filter",
    },
  }
  /**
   * Метод класса, для удобства, получить синглтон (с опциями, если нужно) и активировать его.
   * @param  {Object} value_matches - обязательные параметры при генерации коллекции.
   * @param  {Object} options
   * @return {GroupFilters {}}
   */
  GroupFilters.activate = function(value_matches=null, options=null) {
    return this.get_instance(value_matches, options).activate()
  }
  /**
   * Основной метод класса возвращающий синглтон.
   * @param  {Object} value_matches - обязательные параметры при генерации коллекции.
   * @param  {Object} options
   * @return {GroupFilters {}}
   */
  GroupFilters.get_instance = function(value_matches=null, options=null) {
    if (instance == null) {
      instance = new this(value_matches, options)
    }
    return instance
  }

  /**
   * Экспортируем класс управления
   * @type {GroupFilters}
   */
  window.GroupFilters = GroupFilters

})(jQuery, _);
