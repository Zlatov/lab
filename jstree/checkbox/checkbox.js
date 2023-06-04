$(document).ready(function() {
  $(".tree").jstree({
    core: {
      data: function(obj, callback) {
        var id = obj.id === "#" ? "root" : obj.data.id
        $.ajax({
          type: "get",
          // url: `/admin/labels/tree_descendants/${id}`,
          url: "/jstree/checkbox/checkbox.json",
          cache: false,
          dataType: "json"
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
          console.log('jqXHR, textStatus, errorThrown: ', jqXHR, textStatus, errorThrown)
        })
        .done(function(data) {
          callback.call(this, data)
        })
      }
    },
    plugins: [
      // "state",
      "checkbox"
    ],
    checkbox: {
      // visible: false,
      // whole_node: false,
      // keep_selected_style: false,
      // tie_selection: false
    }
  }).on("check_node.jstree uncheck_node.jstree", function(event, data) {
    console.log('data: ', data)
    console.log('data.node: ', data.node)
    console.log('data.node.state.checked: ', data.node.state.checked)
  })

  $(".tree_tie").jstree({
    core: {
      data: function(obj, callback) {
        var id = obj.id === "#" ? "root" : obj.data.id
        $.ajax({
          type: "get",
          // url: `/admin/labels/tree_descendants/${id}`,
          url: "/jstree/checkbox/checkbox_tie.json",
          cache: false,
          dataType: "json"
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
          console.log('jqXHR, textStatus, errorThrown: ', jqXHR, textStatus, errorThrown)
        })
        .done(function(data) {
          callback.call(this, data)
        })
      }
    },
    plugins: [
      // "state",
      "checkbox"
    ],
    checkbox: {
      // visible: false,
      whole_node: false,
      // keep_selected_style: false,
      tie_selection: false
    }
  }).on("check_node.jstree uncheck_node.jstree", function(event, data) {
    console.log('data: ', data)
    console.log('data.node: ', data.node)
    console.log('data.node.state.checked: ', data.node.state.checked)
  })
})
