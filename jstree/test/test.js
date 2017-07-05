window.tree = {}

window.tree.display = function(data, position) {
  var struct = $('#struct_' + position)
  struct.jstree({
    core: {
      data: data,
      check_callback: true
    },
    types: window.config.tree.node_types,
    contextmenu: {
      items: function(node_data) {
        var tree = struct.jstree(true)
        return window.tree.contextmenu(node_data, tree)
      }
    },
    plugins: [
      'search',
      'types',
      'contextmenu',
      'dnd'
    ]
  })
}

window.tree.load = function() {
  $.ajax({
    type: 'POST',
    url: 'data/data.json',
    data: null,
    cache: false,
    async: true,
    contentType: false,
    processData: false,
    dataType: 'json',
    beforeSend: function(jqXHR, settings){
    },
    success: function(data, textStatus, jqXHR){
      tree.display(data, 'left')
      tree.display(data, 'right')
    },
    fail: function(){
      console.log('error')
    }
  })
}

window.tree.get_data = function(position) {
  var data = $('#struct_' + position).jstree(true).get_json(
    '#',
    {
      no_state:true,
      no_id:false,
      no_children:false,
      no_data: false,
      no_li_attr:true,
      no_a_attr:true,
      flat: false
    }
  )
  // data = data.to_flat(false)
  return data
}

window.tree.contextmenu = function(full_node_data, tree) {
  var contextmenu = {}
  for (var key in window.config.tree.contextmenu_options) {
    if ( window.config.tree.contextmenu_options[key] ) {
      if (window.config.tree.contextmenu_items[key] != null) {
        contextmenu[key] = window.config.tree.contextmenu_items[key](full_node_data, tree)
      }
    }
  }
  return contextmenu
}


window.panel = {}
window.panel.save = function(position) {
  var data = window.tree.get_data(position)
  $.ajax({
    type: 'POST',
    url: 'test.php',
    data: {
      data: JSON.stringify(data)
    },
    async: true,
    // dataType: 'json',
    cache: false,
    // processData: false,
    // contentType: false,
    error: function(jqXHR, textStatus, errorThrown) {
      console.log('jqXHR: ', jqXHR)
      console.log('textStatus: ', textStatus)
      console.log('errorThrown: ', errorThrown)
    },
    success: function(data){
      console.log(data)
    }
  })
}

window.tree.activate_save = function() {
  $('#save_left').on('click', function(){
    window.panel.save('left');
  })
  $('#save_right').on('click', function(){
    window.panel.save('right');
  })
}


$(document).ready(function(){
  window.tree.load()
  window.tree.activate_save()
})
