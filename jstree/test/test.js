window.config = {}
window.config.tree = {
  node_types: {
    default: {
      icon: 'yellow folder icon', // icon: 'jstree-file'
      name: 'папка'
    },
    file: {
      icon: 'file outline icon' // icon: 'jstree-file'
    },
    filter: {
      icon: 'filter icon'
    },
    group: {
      icon: 'copy icon',
      name: 'группа товаров'
    },
    other: {
      icon: 'file icon'
    },
    pantone: {
      icon: 'black folder icon'
    },
    ral: {
      icon: 'orange folder icon'
    },
    zcolor: {
      icon: 'circle thin icon',
      name: 'цвет фильтров'
    },
    some_with_url: {
      icon: 'folder icon',
      name: 'что-то со ссылкой'
    },
    property: {
      icon: 'tag icon',
      name: 'свойство'
    },
    brand: {
      icon: 'copyright icon',
      name: 'брэнд'
    },
    value: {
      icon: 'hashtag icon',
      name: 'значение'
    }
  }
}


$.ajax({
  type: 'POST',
  url: 'data/rds_attributes.json',
  data: null,
  cache: false,
  async: true,
  contentType: false,
  processData: false,
  dataType: 'json',
  beforeSend: function(jqXHR, settings){
  },
  success: function(data, textStatus, jqXHR){
    var struct_left = $('#struct_left')
    var struct_right = $('#struct_right')
    struct_left.jstree({
        core: {
          data: data,
          check_callback: true
        },
        types: window.config.tree.node_types,
        plugins: [
          'search',
          'types',
          'dnd'
        ]
      })
    struct_right.jstree({
        core: {
          data: data,
          check_callback: true
        },
        types: window.config.tree.node_types,
        plugins: [
          'search',
          'types',
          'dnd'
        ]
      })
  },
  fail: function(){
    console.log('error')
  }
})
