;(function($) {


"use strict"

window.OfferFilters = {
  // Данные о группах, например, группа "1", состоящая из двух товаров, со
  // свойствами:
  // 1: {
  //   "010000001": {
  //     "cvet": "красный",
  //     "dlina": "1.5",
  //   },
  //   "010000002": {
  //     "cvet": "зелёный",
  //     "dlina": "2",
  //   },
  // }
  data: null,
  // Соответствия значений. Расчитывается автоматически из входных данных. Пример расчитанных соответствий:
  // 1: {
  //   "cvet": {
  //     "красный": ["010000001"]
  //     "зелёный": ["010000002"]
  //   }
  //   "dlina": {
  //     "1.5": ["010000001"]
  //     "2": ["010000002"]
  //   }
  // }
  value_matches: null
}

window.OfferFilters.init = function(data, callback) {
  this.data = data
  this.calc_value_matches()
  $('#offers .offer .filter[data-type="select"]').on("change", "select", {instance: this, callback: callback}, this.change)
  $('#offers .offer .filter[data-type="radio"]').on("change", "input", {instance: this, callback: callback}, this.change)
}

window.OfferFilters.change = function(event) {
  var instance = event.data.instance
  var changer = $(this)
  var filter = changer.parents("#offers .filter")
  var offer = changer.parents("#offers .offer")
  var id = offer.data("id")
  var slug = filter.data("slug")
  var value = changer.val()

  // Определяем какие значения выбраны в Предложении.
  var selected = instance.find_selected(id)
  console.log('selected: ', selected)

  // Первое в пересечении = решению.
  var code = instance.calc_intersection(id, selected)[0]
  // Если нет решения при выборе значения - находми решение по данным и тому на что кликнули.
  if (code == undefined) {
    selected = instance.calc_selected(id, slug, value)
    instance.set_selected(id, selected)
    code = instance.calc_intersection(id, selected)[0]
  }

  // Разрешим выбирать все значения.
  instance.anable_all_values(id)
  // Запретим выбирать те значения, выбор которых будет приводить к пустому пересечению.
  var disabled = instance.calc_empty_match_values(id, selected)
  instance.disable_values(id, disabled)

  event.data.callback(id, code)
}

window.OfferFilters.find_selected = function(id) {
  var selected = {}
  var filters = $('#offers .offer[data-id="' + id + '"] .filter')
  filters.each(function(index, dom) {
    var filter = $(dom)
    var type = filter.data("type")
    var value = null
    var slug = filter.data("slug")
    if (type == "select") {
      var select = filter.find("select")
      if (select.length == 1) {
        value = select.val()
      }
    }
    if (type == "radio") {
      var checked_input = filter.find("input:checked").first()
      if (checked_input.length != 1) {
        var input = filter.find("input").first()
        input.prop("checked", true)
        if (input.length == 1) {
          checked_input = input
        }
      }
      if (checked_input.length == 1) {
        value = checked_input.val()
      }
    }
    if (value != null) {
      selected[slug] = value
    }
  })
  return selected
}

window.OfferFilters.calc_selected = function(id, slug, value) {
  var selected = {}
  if (
    this.value_matches[id] != null &&
    this.value_matches[id][slug] != null &&
    this.value_matches[id][slug][value] != null &&
    this.value_matches[id][slug][value][0] != null &&
    this.data[id] != null &&
    this.data[id][this.value_matches[id][slug][value][0]] != null
  ) {
    selected = Object.assign(selected, this.data[id][this.value_matches[id][slug][value][0]])
  }
  return selected
}

window.OfferFilters.set_selected = function(id, selected) {
  $('#offers .offer[data-id="' + id + '"] .filter').each(function(index, dom) {
    var filter = $(dom)
    var type = filter.data("type")
    var slug = filter.data("slug")
    var value = null
    if (type == "select") {
      if (selected[slug] != null) {
        var select = filter.find("select").first()
        select.val(selected[slug])
      }
    }
    if (type == "radio") {
      if (selected[slug] != null) {
        var input = filter.find("input[value=\"" + selected[slug] + "\"]").first()
        input.prop("checked", true)
      }
    }
  })
}

window.OfferFilters.anable_all_values = function(id) {
  var filters = $('#offers .offer[data-id="' + id + '"] .filter')
  filters.each(function(index, dom) {
    var filter = $(dom)
    var type = filter.data("type")
    var slug = filter.data("slug")
    if (type == "select") {
      var options = filter.find("select option").each(function(index, dom) {
        var option = $(dom)
        option.removeClass("disabled")
      })
    }
    if (type == "radio") {
      var inputs = filter.find("input").each(function(index, dom) {
        var input = $(dom)
        var label = input.parents("label").first()
        label.removeClass("disabled")
      })
    }
  })
}

window.OfferFilters.disable_values = function(id, values) {
  var filters = $('#offers .offer[data-id="' + id + '"] .filter')
  filters.each(function(index, dom) {
    var filter = $(dom)
    var type = filter.data("type")
    var slug = filter.data("slug")
    var value = null
    if (type == "select") {
      var select = filter.find("select").each(function(index, dom) {
        var options = $(dom).find("option").each(function(index, dom) {
          var option = $(dom)
          value = option.attr("value")
          if (values[slug] != null && values[slug].includes(value)) {
            option.addClass("disabled")
          }
        })
      })
    }
    if (type == "radio") {
      var inputs = filter.find("input").each(function(index, dom) {
        var input = $(dom)
        value = input.val()
        if (values[slug] != null && values[slug].includes(value)) {
          var label = input.parents("label").first()
          label.addClass("disabled")
        }
      })
    }
  })
}

window.OfferFilters.calc_value_matches = function() {
  var id, offer, code, filters, slug, value
  this.value_matches = {}
  for (id in this.data) {
    offer = this.data[id]
    for (code in offer) {
      filters = offer[code]
      for (slug in filters) {
        value = filters[slug]
        this.value_matches[id] = this.value_matches[id] || {}
        this.value_matches[id][slug] = this.value_matches[id][slug] || {}
        this.value_matches[id][slug][value] = this.value_matches[id][slug][value] || []
        this.value_matches[id][slug][value].push(code)
      }
    }
  }
  console.log('this.value_matches: ', this.value_matches)
}

window.OfferFilters.calc_empty_match_values = function(id, selected) {
  var code, slug, filters, value
  var disabled_values = {}
  for (code in this.data[id]) {
    filters = this.data[id][code]
    if (Object.keys(filters).length < 2) {
      continue
    }
    for (slug in filters) {
      value = filters[slug]
      var value_match = []
      if (this.value_matches[id] != null && this.value_matches[id][slug] != null && this.value_matches[id][slug][value] != null) {
        value_match = this.value_matches[id][slug][value]
      }
      var intersection_without_value = this.calc_intersection(id, selected, slug)
      var intersection = _.intersection(intersection_without_value, value_match)
      if (intersection.length == 0) {
        disabled_values[slug] = disabled_values[slug] || []
        disabled_values[slug].push(value)
      }
    }
  }
  // Только уникальные
  for (var slug in disabled_values) {
    var values = disabled_values[slug]
    disabled_values[slug] = _.uniq(values)
  }
  return disabled_values
}

window.OfferFilters.calc_intersection = function(id, selected, exclude_slug) {
  var code, filters, slug, value
  var unions = {}
  for (code in this.data[id]) {
    filters = this.data[id][code]
    for (slug in selected) {
      if (slug == exclude_slug) {
        continue
      }
      value = selected[slug]
      if (typeof(filters[slug]) !== 'undefined' && filters[slug] === value) {
        if (unions[slug] == null) {
          unions[slug] = []
        }
        unions[slug].push(code)
      }
    }
  }
  console.log('unions: ', unions)
  var intersection = _.uniq(_.intersection(...Object.values(unions)))
  console.log('intersection: ', intersection)
  return intersection
}


})(jQuery);
