window.tree = {}
window.tree.data = {}
window.tree.data.left = []
window.tree.data.right = []

window.tree.load = function(slug=null) {
  if (slug==null) {
    slug = 'data'
  }
  $.ajax({
    type: 'post',
    url: 'data/' + slug + '.json',
    cache: false,
    contentType: false,
    processData: false,
    dataType: 'json',
    success: function(data, textStatus, jqXHR){
      window.tree.data['left'] = data
      window.tree.display('left')
    },
    fail: function(){
      console.log('error')
    }
  })
}

window.tree.display = function(position) {
  var panel = $('#panel_' + position)
  panel.empty()
  panel.append('<div id="struct_'+ position +'"></div>')
  console.log('window.tree.data[position]: ', window.tree.data[position])
  var struct = $("#struct_" + position)

  var tmp = struct.jstree(true)
  if(tmp) {
    tmp.destroy()
  }

  struct.jstree({
    core: {
      data: window.tree.data[position],
      // data: function(obj, callback) {
      //   return window.tree.data[this.settings.data_custom.position]||[]
      // },
      check_callback: true
    },
    data_custom: {
      position: position
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
  // struct.jstree(true).settings.core.data = window.tree.data[position]
  struct.jstree(true).refresh()
  // struct.jstree(true).redraw(true)
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
  data.to_flat()
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

window.activate_save = function() {
  $('#save_left').on('click', function(){
    window.panel.save('left');
  })
  $('#save_right').on('click', function(){
    window.panel.save('right');
  })
}

window.activate_load = function() {
  $('.load_tree').on('click', function(event) {
    var tree_id = $(this).data('tree_id')
    window.tree.load(tree_id)
  })
}

function activate_jstree() {
  var positions = ['left', 'right']
  for(var i=0, l=positions.length; i<l; i++) {
    var position = positions[i];
    var struct = $('#struct_' + position)
    struct.jstree({
      core: {
        data: function(obj, callback) {
          var position = this.settings.data_custom.position
          console.log('window.tree.data[' + position + ']: ', window.tree.data[position])
          return window.tree.data[position]||[]
        },
        check_callback: true
      },
      data_custom: {
        position: position
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
}

$(document).ready(function(){
  // window.activate_jstree()
  window.activate_load()
  window.activate_save()
  window.tree.load('data')
})
