$(document).ready(function() {

  var doc_headers_nested = []
  var doc_headers_cache = {}

  // Собираем дерево заголовков, doc_headers_cache просто для быстрого доступа
  for (var h = 2; h <= 6; h++) {
    var header_selectror = 'h' + h
    $(header_selectror).each(function(index, dom) {
      var $header = $(this)
      var header_id = h.toString() + index.toString()
      $header.attr('data-doc_id', header_id)
      var header = {
        id: header_id,
        header: $header.text(),
        childrens: []
      }
      doc_headers_cache[header_id] = header
      if (h==2) {
        doc_headers_nested.push(header)
      } else {
        var prev_header_selector = 'h' + (h - 1)
        var prev_header = $header.prevAll(prev_header_selector).first()
        if (prev_header.length) {
          var prev_header_id = prev_header.data('doc_id')
          doc_headers_cache[prev_header_id]['childrens'].push(header)
        }
      }
    })
  }

  console.log('doc_headers_nested: ', doc_headers_nested)

  var doc_process_nodedata = function(node, parents, level) {
    var header_selector = 'h' + (level+2) + '[data-doc_id="' + node.id + '"]'
    var $header = $(header_selector)
    var path = ''
    for(var i=1, l=parents.length; i<l; i++) {
      var parent = parents[i]
      if (parent == null) {
        break
      }
      path+= parent.header + '/'
    }
    var url = path + node.header + '.html'
    $header.empty().append('<a href="' + url + '">' + node.header + '</a>')
    console.log('url: ', url)
  }

  var level = 0
  var cache = []
  cache[level] = doc_headers_nested.slice(0)
  var parent = []
  parent[level] = null
  var index = []
  index[level] = 0

  while (level>=0) {
    var node = cache[level][index[level]]
    if (node != null) {

      doc_process_nodedata(Object.assign({}, node), parent.slice(0), level)
      // console.log('node.id: ', node.id)
      // console.log('parent: ', parent.slice(0))

      if (
        node['childrens'] != null &&
        Object.prototype.toString.call(node['childrens']) === '[object Array]' &&
        node['childrens'].length
      ) {
        level++
        index[level] = 0
        parent[level] = Object.assign({}, node)
        delete parent[level]['childrens']
        cache[level] = node['childrens'].slice(0)
      } else {
        index[level]++
      }
    } else {
      parent[level] = null
      level--
      index[level]++
    }
  }



  var doc_links = $('a.doc').each(function(i,d) {
    var link = $(d)
    console.log('link: ', link)
    var parent_header = link.parent().parent().prevUntil('h6, h5, h4, h3, h2')
    console.log('parent_header: ', parent_header)
    console.log('parent_header.text(): ', parent_header.text())
    for (var h = 2; h <= 6; h++) {
      var header_selectror = 'h' + h
    }
  })

});
