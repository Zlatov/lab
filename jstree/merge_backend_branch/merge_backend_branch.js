$(document).ready(function() {
  activate_product_tree()
  activate_product_tree_reset()
})

function tree_core_data(obj, callback) {
  var tree = this
  var id = null
  var type = null
  if (obj.id == "#") {
    id = "roots"
    type = "catalog"
  } else {
    id = obj.id
    type = obj.type
  }
  $.ajax({
    url: `data/children_${type}_${id}.json`,
    type: "get",
    cache: false,
    dataType: "json",
    timeout: 3000
  }).fail(function(jqXHR, textStatus, errorThrown) {
    console.log('jqXHR, textStatus, errorThrown: ', jqXHR, textStatus, errorThrown)
  }).done(function(data, textStatus, jqXHR) {
    console.log('data: ', data)
    callback.call(this, data)
  })
}

function activate_product_tree() {
  $(".product_tree").jstree({
    core: {
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
      // Применим принцип „запрещено всё что не разрешено“.
      // Параметр operation может принимать значения:
      // 'create_node', 'rename_node', 'delete_node', 'move_node', 'copy_node' или 'edit'.
      // expand_selected_onload: true,
      check_callback: function (operation, node, node_parent, node_position, more) {
        // console.log('> CHECK_CALLBACK')
        // console.log('operation: ', operation)
        // console.log('node: ', node)
        // console.log('more: ', more)
        // console.log('node_parent: ', node_parent)
        // console.log('node_position: ', node_position)

        // Не DND операции со своими нодами
        if (more == null) {

          // 
          // Разрешаем
          // 

        }

        // DND операции в своем дереве
        if (more != null && more.origin.element == this.element) {

          // 
          // Разрешаем
          // 

        }

        // Если узел из дерева номенклатуры
        if (more != null && more.origin.element.hasClass("nomenclature_tree")) {

          // 
          // Разрешаем
          // 

        }
        return false
      }
    },
    plugins: [
      "types",
      "state",
      "contextmenu"
    ],
    types: {
      catalog: {
        icon: "fas fa-folder",
        name: "папка"
      },
      offer: {
        icon: "fas fa-layer-group",
        name: "торговое предложение"
      },
      product: {
        icon: "far fa-file",
        name: "продукт"
      }
    },
    state: {
      "key" : "product_tree"
    },
    cache: {
    },
    contextmenu: {
      items: function(node, _callback) {
        var tree = this
        var items = {}

        if (node.type == "product") {
          items.ShowOrigin = {
            label: "Показать оригинал",
            icon: "fas fa-file",
            action: function(obj) {
              var node = tree.get_selected(true)[0]
              // node.url = `data/product_origin_${node.id}.json`
              // tree.load_node(node)
              tree.settings.operations.product_origin.call(tree, node.id)
            }
          }
        }

        return items
      }
    },
    operations: {
      product_origin: function(product_id) {
        var tree = this
        $.ajax({
          type: "get",
          url: `data/product_origin_${product_id}.json`,
          cache: false,
          timeout: 3000
        }).fail(function(jqXHR, textStatus, errorThrown) {
          console.log('jqXHR, textStatus, errorThrown: ', jqXHR, textStatus, errorThrown)
        }).done(function(data, textStatus, jqXHR) {
          console.log('tree: ', tree)
          console.log('data: ', data)

          // tree.deselect_all(true)
          // tree.select_node(data.id)

          var nested = tree.get_json("#", {
            no_state: false,
            no_id: false,
            no_children: false,
            no_data: false,
            no_li_attr: false,
            no_a_attr: false,
            flat: false
          })
          console.log('nested: ', nested)
          var flat = []
          var flat_ids = []

          var cache = []
          var parent = []
          var index = []
          var level = 0
          cache[level] = nested.slice(0)
          parent[level] = null
          index[level] = 0
          while (level >= 0) {
            var node = cache[level][index[level]]
            if (node != null) {

              var node_to_flat = Object.assign({}, node)
              delete node_to_flat.children
              delete node_to_flat.state.loaded
              node_to_flat.parent = parent[level] == null ? "#" : parent[level].id
              flat.push(node_to_flat)
              flat_ids.push(node.id)

              if (Object.prototype.toString.call(node["children"]) === "[object Array]" && node["children"].length > 0) {
                level ++
                index[level] = 0
                parent[level] = Object.assign({}, node)
                cache[level] = node["children"].slice(0)
              } else {
                index[level] ++
              }
            } else {
              parent[level] = null
              level --
              index[level] ++
            }
          }


          console.log('flat: ', flat)

          // Хэш новых узлов
          var baranch = data.nodes
          var hash_baranch = {}
          baranch.forEach(function(node) {
            hash_baranch[node.id] = node
          })
          // Хэш старых узлов
          var hash_flat = {}
          flat.forEach(function(node) {
            hash_flat[node.id] = node
          })

          // Собираем в res
          var res = []
          // Все старые узлы помещаем в res, модифицируя данными из новых.
          flat.forEach(function(flat_node) {
            var baranch_node = hash_baranch[flat_node.id]
            // Если передан узел среди новых
            if (baranch_node != null) {
              if (baranch_node.state?.opened == true) {
                flat_node.state.opened = true
              }
              if (baranch_node.state?.selected == true) {
                flat_node.state.selected = true
              }
            }
            res.push(flat_node)
          })
          // Новые узлы которых нет в старых
          baranch.forEach(function(baranch_node) {
            var flat_node = hash_flat[baranch_node.id]
            if (flat_node == null) {
              res.push(baranch_node)
            }
          })

          console.log('res: ', res)

          tree.settings.core.data = res
          tree.refresh(true, true)
          tree.settings.core.data = tree_core_data
          console.log('> Done!')
        })
      }
    }
  }).on('rename_node.jstree', function(event, data) {
  }).on('move_node.jstree', function(event, data) {
    var tree = data.instance
  }).on("loaded.jstree refresh.jstree open_node.jstree rename_node.jstree", function(event, data) {
    // jstree_column(data)
  }).on("rename_node.jstree", function(event, data) {
    var tree = data.instance
    tree.element.removeClass("jstree-column-hidden")
  }).on("loaded.jstree", function(event, data) {
    var tree = data.instance
  }).on('copy_node.jstree', function(event, data) {
    // console.log('> COPY_NODE.JSTREE')
    // console.log('event: ', event)
    // console.log('data: ', data)
  })
}

function activate_product_tree_reset() {
  $(".product_tree_reset").on("click", function(event) {
    var button = $(this)
    var tree = $(".product_tree").jstree(true)
    tree.refresh(false, true)
  })

  setTimeout(function() {
    var tree = $(".product_tree").jstree(true)
    tree.settings.operations.product_origin.call(tree, "p_1")
  }, 1000)
}
