;(function($) {


"use strict"

window.OfferFilters = {
  data: null
}

window.OfferFilters.init = function(data) {
  this.data = data
  $('#offers .offer .filter[data-type="select"]').on("change", "select", {instance: this}, this.change)
  $('#offers .offer .filter[data-type="radio"]').on("change", "input", {instance: this}, this.change)
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
  var selected = instance.calc_selected(id)
  // Разрешим выбирать все значения.
  instance.anable_all_values(id)
  // Запретим выбирать те значения, выбор которых будет приводить к пустому пересечению.
  instance.disable_values(id, instance.calc_empty_match_values(id, selected))
  // Первое в пересечении = решению.
  var code = instance.calc_intersection(id, selected, null)[0]
  console.log('code: ', code)
}

window.OfferFilters.calc_selected = function(id) {
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
      var checked_input = filter.find("input:checked")
      if (checked_input.length != 1) {
        var inputs = filter.find("input")
        if (inputs.length > 0) {
          var input = $(inputs[0])
          input.prop("checked", true)
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

window.OfferFilters.anable_all_values = function(id) {
  var filters = $('#offers .offer[data-id="' + id + '"] .filter')
  filters.each(function(index, dom) {
    var filter = $(dom)
    var type = filter.data("type")
    var slug = filter.data("slug")
    if (type == "select") {
      var options = filter.find("select option").each(function(index, dom) {
        $(dom).prop("disabled", false)
      })
    }
    if (type == "radio") {
      var inputs = filter.find("input").each(function(index, dom) {
        $(dom).prop("disabled", true)
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
            option.prop("disabled", true)
          }
        })
      })
    }
    if (type == "radio") {
      var inputs = filter.find("input").each(function(index, dom) {
        var input = $(dom)
        value = input.val()
        if (values[slug] != null && values[slug].includes(value)) {
          input.prop("disabled", true)
        }
      })
    }
  })
}

window.OfferFilters.calc_empty_match_values = function(id, selected) {
  var code, slug, filters, value
  var imatches_value = {}
  for (code in this.data[id]) {
    filters = this.data[id][code]
    for (slug in filters) {
      value = filters[slug]
      if (imatches_value[slug] == null) {
        imatches_value[slug] = {}
      }
      if (imatches_value[slug][value] == null) {
        imatches_value[slug][value] = []
      }
      imatches_value[slug][value].push(code)
    }
  }
  var disabled_values = {}
  for (code in this.data[id]) {
    filters = this.data[id][code]
    for (slug in filters) {
      value = filters[slug]
      var value_match = imatches_value[slug][value] || []
      var intersection_without_value = this.calc_intersection(id, selected, slug)
      console.log('intersection_without_value: ', intersection_without_value)
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
  console.log('disabled_values: ', disabled_values)
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
  var intersection = _.uniq(_.intersection(...Object.values(unions)))
  return intersection
}


})(jQuery);
