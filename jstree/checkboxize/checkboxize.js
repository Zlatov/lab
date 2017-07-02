window.struct = null


window.get_struct = function(struct_id) {
  if (window.struct) {
    return window.struct
  }
  var struct = $('#'+struct_id)
  if (!struct.length) {
    throw new Error('HTML повреждён.')
  }
  struct.display_tree = function(data) {
    this.jstree({
      core: {
        data: data,
        check_callback: true
      },
      types: {
        default: {
          icon: 'yellow folder icon'
        },
        file: {
          icon: 'file outline icon'
        },
        filter: {
          icon: 'filter icon'
        },
        group: {
          icon: 'copy icon'
        },
        property: {
          icon: 'tag icon'
        },
        value: {
          icon: 'hashtag icon'
        }
      },
      plugins: [
        'search',
        'types',
        'dnd'
      ]
    })
  }
  window.struct = struct
  return window.struct
}


window.prepare_data = function(data, options=null) {
  var item_article = "000096586"

  var nested = data.to_nested(false)

  var cache_chechboxizable = null
  var cache_group_chechboxizable = null
  var check_group_chechboxizable = function(node) {
    if (
      node.type === 'property' ||
      node.type === 'filter'
    ) {
      cache_group_chechboxizable = node
    }
  }
  var check_chechboxizable = function(node) {
    if (
      node.type === 'value'
    ) {
      cache_chechboxizable = node
      cache_chechboxizable.a_attr = Object.assign({class: 'checkboxized'}, cache_chechboxizable.a_attr)
      cache_chechboxizable.li_attr = Object.assign({class: 'checkboxized'}, cache_chechboxizable.li_attr)
      if (cache_group_chechboxizable) {
        cache_group_chechboxizable.a_attr = Object.assign({class: 'group-checkboxized'}, cache_group_chechboxizable.a_attr)
        cache_group_chechboxizable.li_attr = Object.assign({class: 'group-checkboxized'}, cache_group_chechboxizable.li_attr)
        cache_group_chechboxizable.state = Object.assign({opened: true}, cache_group_chechboxizable.state)
      }
    }
  }
  var chechboxize_if_reason = function(node) {
    if (
      node.data &&
      node.data.article === item_article
    ) {
      if (cache_chechboxizable) {
        cache_chechboxizable.a_attr = Object.assign({'data-checked': 'true'}, cache_chechboxizable.a_attr)
        cache_chechboxizable.li_attr = Object.assign({'data-checked': 'true'}, cache_chechboxizable.li_attr)
      }
      if (cache_group_chechboxizable) {
        cache_group_chechboxizable.a_attr = Object.assign({'data-has_checked': 'true'}, cache_group_chechboxizable.a_attr)
        cache_group_chechboxizable.li_attr = Object.assign({'data-has_checked': 'true'}, cache_group_chechboxizable.li_attr)
      }
    }
  }

  var o = {
    root_id: '#',
    id: 'id',
    pid: 'parent',
    childrens: 'children'
  }
  var level = 0
  var cache = []
  cache[level] = nested.clone()
  cache[level].reset()
  while (level>=0) {
    var node = cache[level].next()
    if (node != null) {

      check_group_chechboxizable(node)
      check_chechboxizable(node)
      chechboxize_if_reason(node)

      if (
        node[o.childrens]!=null &&
        Object.prototype.toString.call(node[o.childrens]) === '[object Array]' &&
        node.children.length
      ) {
        level = level + 1
        cache[level] = node[o.childrens]
        cache[level].reset()
      }
    } else {
      level = level - 1
    }
  }
  var flat = nested.to_flat(false)
  return flat
}


$.ajax({
  type: 'POST',
  url: 'data/attributes.json',
  data: null,
  cache: false,
  async: true,
  contentType: false,
  processData: false,
  dataType: 'json',
  beforeSend: function(jqXHR, settings){
  },
  success: function(data, textStatus, jqXHR){
    var data = window.prepare_data(data)
    console.log('data: ', data)
    var struct = window.get_struct('struct')
    struct.display_tree(data)
  },
  fail: function(){
    console.log('error')
  }
})
