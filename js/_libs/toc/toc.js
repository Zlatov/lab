$(document).ready(function() {
  $("#toc").append('<p id="toc_header">Оглавление</p><ul></ul>')

  for (var h = 2; h <= 6; h++) {
    var header_selectror = 'h' + h
    $(header_selectror).each(function(index, dom) {
      var header = $(this)
      if (h>2) {
        var prev_header_id = null
        var prev_header_selector = 'h' + (h - 1)
        var prev_header = header.prevAll(prev_header_selector).first()
        if (prev_header.length) {
          prev_header_id = prev_header.attr('id')
        }
        if (prev_header_id != null) {
          header.attr('id', header_selectror + index)
          var link_index = prev_header_id.substring(2)
          var ul = $('#toc_link_' + prev_header_selector + link_index).next("ul")
        }
      } else {
        header.attr('id', header_selectror + index)
        var ul = $('#toc').children('ul')
      }
      if (h>2 && prev_header_id !=null || h==2) {
        ul.append(
          '<li>' +
            '<a id="toc_link_' + header_selectror + index + '" href="#' + header_selectror + index + '" title="' + (header.attr('title')||'') + '">' +
              header.text() +
            '</a>' +
            '<ul></ul>' +
          '</li>'
        )
        header.append(' <a href="#toc_link_' + header_selectror + index + '">↑</a>')
      }
    })
  }

});
