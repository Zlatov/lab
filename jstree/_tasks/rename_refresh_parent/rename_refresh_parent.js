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

          var children = data.filter(e => e.parent === node.id)
          var children_ids = children.map(e => e.id)
          var subchildren = data.filter(e => children_ids.includes(e.parent))
          var descendants = children.concat(subchildren)
          callback.call(this, descendants)
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
