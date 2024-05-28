$(document).ready(function() {
  activate_tree()
  activate_tree_search()
})

function tree_core_data(obj, callback) {
  var instance = this
  var id = null
  var type = null
  if (obj.id == "#") {
    id = "roots"
    type = "roots"
  } else {
    switch(obj.type) {
      case "filter_group":
      case "property_group":
        id = obj.id
        type = obj.type
      break
      case "property":
      case "filter":
        id = obj.id
        type = obj.type
      break
      case "property_value":
      case "property_strict_value":
        id = obj.id
        type = obj.type
      break
    }
  }
  var url = `/jstree/_tasks/search/data/${type}/${id}.json`
  console.log('url: ', url)
  $.ajax({
    url: `/jstree/_tasks/search/data/${type}/${id}.json`,
    type: "get",
    dataType: "json"
  }).fail(function(jqXHR, textStatus, errorThrown) {
    console.log('jqXHR, textStatus, errorThrown: ', jqXHR, textStatus, errorThrown)
  }).done(function(data, textStatus, jqXHR) {
    callback.call(this, data)
  })
}

function activate_tree() {
  $("#tree").jstree({
    core: {
      // data: function(obj, callback) {
      //   var instance = this
      //   var id = null
      //   var type = null
      //   if (obj.id == "#") {
      //     id = "roots"
      //     type = "roots"
      //   } else {
      //     switch(obj.type) {
      //       case "filter_group":
      //       case "property_group":
      //         id = obj.id
      //         type = obj.type
      //       break
      //       case "property":
      //       case "filter":
      //         id = obj.id
      //         type = obj.type
      //       break
      //       case "property_value":
      //       case "property_strict_value":
      //         id = obj.id
      //         type = obj.type
      //       break
      //     }
      //   }
      //   var url = `/jstree/_tasks/search/data/${type}/${id}.json`
      //   console.log('url: ', url)
      //   $.ajax({
      //     url: `/jstree/_tasks/search/data/${type}/${id}.json`,
      //     type: "get",
      //     dataType: "json"
      //   }).fail(function(jqXHR, textStatus, errorThrown) {
      //     console.log('jqXHR, textStatus, errorThrown: ', jqXHR, textStatus, errorThrown)
      //   }).done(function(data, textStatus, jqXHR) {
      //     callback.call(this, data)
      //   })
      // },
      data: tree_core_data,
      // А вот кто бы мог додуматься, что если появляется ошибка
      // Uncaught ReferenceError: _typeof is not defined
      // при использовании пакета jstree
      // то нужно добавить такую строчку в config/webpack/environment.js:
      // environment.loaders.delete('nodeModules')
      // либо добавить опцию в jstree: core.worker в значение false
      worker: false,
      // Отменяет фокусировку (и перемотку к последней фокусированной ноде) если
      // был выполнен клик в "пустом" месте (или по псевдоэлементу).
      // Должен ли последний активный узел быть сфокусирован, когда контейнер
      // дерева размыт и снова сфокусирован. Это помогает при работе с
      // программами чтения с экрана. По умолчанию true.
      restore_focus: false,
      // operation может принимать значения:
      // 'create_node', 'rename_node', 'delete_node', 'move_node', 'copy_node' или 'edit'
      check_callback: function (operation, node, node_parent, node_position, more) {

        return false
      }
    },
    plugins: [
      "types",
      "contextmenu",
      "state"
    ],
    state: {
      key: "tree"
    },
    cache: {
    },
    types: {
      default: {
        icon: "bi bi-folder",
        name: "папка"
      },
      filter_group: {
        icon: "bi bi-layers-fill",
        name: "группа"
      },
      value_type: {
        icon: "bi bi-folder",
        name: "тип значения"
      },
      filter: {
        icon: "bi bi-filter-circle-fill",
        name: "фильтр"
      },
      property_value: {
        icon: "bi bi-circle",
        name: "значение"
      },
      property_strict_value: {
        icon: "bi bi-circle-fill",
        name: "уточнение"
      },
      product: {
        icon: "bi bi-file-earmark",
        name: "продукт"
      }
    },
    dnd: {
      is_draggable: function(nodes, event) {
        // console.log('> IS_DRAGGABLE')
        // console.log('nodes: ', nodes)
        // console.log('event: ', event)

        return false
      }
    },
    contextmenu: {
      items: function(node) {
        var ret = {}
        var tree = this

        return ret
      }
    },
    operations: {
    }
  }).on('move_node.jstree', function(event, data) {
    var tree = data.instance

    // console.log('> MOVE_NODE.JSTREE')
    // console.log('event: ', event)
    // console.log('data: ', data)
    // console.log('tree.settings.cache.dnd_stop: ', tree.settings.cache.dnd_stop)

  }).on('copy_node.jstree', function(event, data) {
    var tree = data.instance

    // console.log('> COPY_NODE.JSTREE')
    // console.log('event: ', event)
    // console.log('data: ', data)
    // console.log('tree.settings.cache.dnd_stop: ', tree.settings.cache.dnd_stop)
  })

  $(document).on("dnd_stop.vakata", function(event, data) {
    // console.log('> DND_STOP.VAKATA')
    // console.log('event: ', event)
    // console.log('data: ', data)
  })
}

function activate_tree_search() {
  var tree_search = $(".js_tree_search")
  if (tree_search.length != 1) return null

  tree_search.on("click", "button.search", function(event) {
    var query = $(this).siblings("input").first().val()
    search(query)
  })
  tree_search.on("click", "button.reset", function(event) {
    // search("")
  })
  tree_search.on("keyup", "input", function(event) {
    if (event.which == 13) {
      var query = $(this).val()
      search(query)
    }
  })

  function search(query) {
    console.log('query: ', query)
    if (query == "") { return null }

    $.ajax({
      url: `/jstree/_tasks/search/data/search_responce.json`,
      type: "get",
      // data: {
      //   query: query
      // },
      dataType: "json"
    }).fail(function(jqXHR, textStatus, errorThrown) {
      message_modal.fail(jqXHR, textStatus, errorThrown)
    }).done(function(data, textStatus, jqXHR) {
      console.log('data: ', data)
      var tree = $("#tree").jstree(true)
      console.log('tree: ', tree)
      tree.settings.core.data = data
      tree.refresh(true, true)
      tree.settings.core.data = tree_core_data
    })

    // var tree = $("#tree").jstree(true)
    // console.log('tree: ', tree)
    // tree.load_node("#")
    // tree.load_node({id: query})
  }
}
