;(function() {
  "use strict"

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

  // console.log('doc_headers_nested: ', doc_headers_nested)

  var doc_scroll_if_hash_is_text_in = function(node, parents, level) {
    if (window.location.hash == '#' + encodeURIComponent(node.header)) {
      var header = $('[data-doc_id="' + node.id + '"]')
      window.scrollTo(window.pageXOffset, header.offset().top)
    }
  }

  var doc_set_url_for_header = function(data, textStatus, jqXHR) {
    // console.log('> url!')
    var header = this.data_custom.header
    var node = this.data_custom.node
    var url = this.url
    var not_text = header.children().detach()
    header.wrapInner('<a href="' + url + '"></a>')
    header.append('&nbsp;').append(not_text)
    header.addClass('js_doc_linked')
    this.data_custom.ajax_zakonchen_resolve()
  }

  var doc_header_no_url_handler = function(jqXHR, textStatus, errorThrown) {
    // console.log('> no url')
    // Даже если ошибка - это означает успех (у заголовка нет соответствующей страницы)
    // this.data_custom.ajax_zakonchen_reject()
    this.data_custom.ajax_zakonchen_resolve()
  }

  var doc_process_nodedata = function(node, parents, level) {
    var header_selector = 'h' + (level+2) + '[data-doc_id="' + node.id + '"]'
    var header = $(header_selector)
    var path = ''
    path+= window.location.pathname.split('.')[0] + '/'
    for (var i = 1, l = parents.length; i < l; i++) {
      var parent = parents[i]
      if (parent == null) {
        break
      }
      path+= parent.header + '/'
    }
    var url = path + node.header + '.html'
    var obeschayu_zakonchit_ajax_ot_headera = new Promise(function(ajax_zakonchen_resolve, ajax_zakonchen_reject) {
      $.ajax(url, {
        data_custom: {
          header: header,
          node: node,
          ajax_zakonchen_resolve: ajax_zakonchen_resolve,
          ajax_zakonchen_reject: ajax_zakonchen_reject,
        },
        success: doc_set_url_for_header,
        error: doc_header_no_url_handler,
      })
        // .done(doc_set_url_for_header)
        // .fail(doc_header_no_url_handler)
    })
    if (window.location.hash) {
      doc_scroll_if_hash_is_text_in(node, parents, level)
    }
    return obeschayu_zakonchit_ajax_ot_headera
  }

  var level = 0
  var cache = []
  cache[level] = doc_headers_nested.slice(0)
  var parent = []
  parent[level] = null
  var index = []
  index[level] = 0

  var vse_headeri_obeschayut = []

  while (level>=0) {
    var node = cache[level][index[level]]
    if (node != null) {


      vse_headeri_obeschayut.push(
        doc_process_nodedata(Object.assign({}, node), parent.slice(0), level)
      )
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



  Promise.all(vse_headeri_obeschayut).then(function(resolve_data) {
    console.log('> Vse zagolovki obrabotani')
    doc_set_url_for_links()
  }, function(reject_data) {
    console.log('> Odin iz zagolovkov ne obrabotan')
  }).catch(e => {
    console.log(e);
  });

  var doc_set_url_for_links = function() {
    var doc_links = $('a.doc').each(function(i, d) {
      var link = $(d)
      var link_parents = link.parentsUntil('body')
      var body_child_node = link_parents[link_parents.length-1]
      // debugger
      var prev_header = (
        $(body_child_node).prevUntil('.js_doc_linked').length ?
        $(body_child_node).prevUntil('.js_doc_linked').last() :
        $(body_child_node)
      ).prev()
      var prev_header_url = prev_header.find('a').attr('href')
      var link_url = prev_header_url + '#' + encodeURIComponent(link.text())
      link.attr('href', link_url)
    })
  }


});

})();
