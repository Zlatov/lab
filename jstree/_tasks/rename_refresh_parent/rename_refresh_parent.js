$('#tree').jstree({
  core: {
    data: function(node, callback) {
      var instance = this
      $.ajax({
        url: "rename_refresh_parent.json",
        type: "get",
        dataType: "json"
      }).fail(function(jqXHR, textStatus, errorThrown) {
        console.log('jqXHR, textStatus, errorThrown: ', jqXHR, textStatus, errorThrown)
      }).done(function(data) {
        // Если обновляем (load_node) корень (это даже не узел, а указатель
        // аналогичный null), то требуются потомки, то есть все узлы.
        if (node.id === "#") {
          callback.call(this, data)
        // Если же обновляем узел, то, аналогично предыдущему, требуются
        // потомки. Код ниже был бы не нужен, если бы бэкэнд отдавал только
        // список потомков. Такая реализаци приемлема (отдвать сразу все узлы)
        // только при небольшом дереве.
        } else {
          // Глючный, старый вариант:
          // callback.call(this, data.filter(function(e) { return e.parent === node.id }))

          // var children = data.filter(e => e.parent === node.id)
          // var children_ids = children.map(e => e.id)
          // var subchildren = data.filter(e => children_ids.includes(e.parent))
          // var descendants = children.concat(subchildren)
          // callback.call(this, descendants)

          // ИЛИ через temp_tree

          var instance = this
          $("#temp").jstree("destroy")
          $("#temp").jstree({
            core: { data: data }
          }).on("loaded.jstree", function (event, temp_data) {
            var temp_node = temp_data.instance.get_node(node.id)
            var descendants = data.filter(e => temp_node.children_d.includes(e.id))
            callback.call(instance, descendants)
          })
        }
      })
    },
    worker: false,
    check_callback: true,
    restore_focus: false
  },
  plugins: [
    "state"
  ]
}).on("rename_node.jstree", function(event, data) {
  console.log('event, data: ', event, data)
  var tree = data.instance
  var node = data.node
  setTimeout(function() {
    tree.load_node(node.parent, function() {
      // tree.select_node(node_id)
      // tree.get_node(node_id, true).children(".jstree-anchor").focus()
    })
  }, 1000)
})

// $(document).ready(function() {
//   $('#temp').jstree({
//     core: {
//       data: [
//         { "id": "111", "text": "111", "parent": "#", "state": { "opened": true } },
//         { "id": "222", "text": "222", "parent": "#" },
//         { "id": "111-1", "text": "111-1", "parent": "111" },
//         { "id": "111-2", "text": "111-2", "parent": "111" },
//         { "id": "111-2-1", "text": "111-2-1", "parent": "111-2" },
//         { "id": "111-3", "text": "111-3", "parent": "111" },
//         { "id": "111-4", "text": "111-4 rename", "parent": "111", "state": { "selected": true } }
//       ]
//     }
//   }).on("loaded.jstree", function (event, data) {
//     // console.log('event, data: ', event, data)
//     var tree = data.instance
//     var temp_node = tree.get_node("111")
//     console.log('temp_node: ', temp_node)
//   })

//   var temp_tree = $('#temp').jstree(true)
//   console.log('temp_tree: ', temp_tree)
//   var temp_node = $('#temp').jstree(true).get_node("111")
//   console.log('temp_node: ', temp_node)
// })


