$(document).ready(function() {

  var data = [
    {
      "id": "1",
      "text": "Принтеры для рекламных производств, запчасти и аксессуары",
      "data": {},
      "type": "default",
      "state": {
        "opened": true
      },
      "a_attr": {
        "data-column": "<a href=\"/\">asd</a>",
        "data-icons-1": "fa-brands fa-squarespace"
      },
      "children": [
        {
          "id": "2",
          "text": "Широкоформатные УФ принтеры",
          "data": {},
          "type": "default",
          "state": {
            "opened": true
          },
          "children": [
            {
              "id": "j9_76",
              "text": "Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1<span class=\"articul\">321654987</span>",
              "data": {
                "article": "000011942"
              },
              "type": "file",
              "li_attr": {
                "data-articul": "000011942"
              }
            },
            {
              "id": "j9_29",
              "text": "Широкоформатный УФ принтер 2",
              "data": {
                "article": "000098070"
              },
              "type": "file",
              "li_attr": {
                "data-articul": "000098070"
              },
              "a_attr": {
                "data-column": "asd asd"
              }
            }
          ]
        }
      ]
    }
  ]

  function jstree_column(data) {
    $(data.instance.element).find(".jstree-anchor[data-column]").each(function(index, dom) {
      var anchor = $(dom)
      if (anchor.next(".jstree-column").length == 0) {
        anchor.after('<div class="jstree-column">' + anchor.data("column") + '</div>')
      }
    })
  }

  function jstree_icons(data) {
    $(data.instance.element).find(".jstree-anchor[data-icons-1]").each(function(index, dom) {
      var anchor = $(dom)
      if (anchor.children(".jstree-icons-1").length == 0) {
        anchor.children(".jstree-icon")
          .after('<span class="jstree-icons jstree-icons-1"><i class="' + anchor.data("icons-1") + '"></i></span>')
      }
    })
    $(data.instance.element).find(".jstree-anchor[data-icons-2]").each(function(index, dom) {
      var anchor = $(dom)
      if (anchor.children(".jstree-icons-2").length == 0) {
        anchor.children(".jstree-icon")
          .after('<span class="jstree-icons jstree-icons-2"><i class="' + anchor.data("icons-2") + '"></i></span>')
      }
    })
    $(data.instance.element).find(".jstree-anchor[data-icons-3]").each(function(index, dom) {
      var anchor = $(dom)
      if (anchor.children(".jstree-icons-3").length == 0) {
        anchor.children(".jstree-icon")
          .after('<span class="jstree-icons jstree-icons-3"><i class="' + anchor.data("icons-3") + '"></i></span>')
      }
    })
  }

  var static_jstree = $(".static_jstree")
  static_jstree.jstree({
    core: {
      data: data,
      restore_focus: false,
      check_callback : true
    },
    plugins: [
      "types"
    ],
    types: {
      default: {
        icon: "jstree-folder",
        name: "папка"
      },
      file: {
        icon: "jstree-file",
        name: "товар"
      }
    }
  }).on("loaded.jstree open_node.jstree rename_node.jstree", function(event, data) {
    jstree_column(data)
    jstree_icons(data)
  })

  var articul_jstree = $(".articul_jstree")
  articul_jstree.jstree({
    core: {
      data: function(obj, callback) {
        var url = obj.id == "#" ? "/jstree/articul2/data/articul_root.json" : "/jstree/articul2/data/articul_children_" + obj.id + ".json"
        $.ajax({
          type: "get",
          async: true,
          url: url,
          cache: false,
          dataType: "json",
          timeout: 3000,
          error: function(jqXHR, textStatus, errorThrown) {
            console.log('jqXHR.responseJSON: ', jqXHR.responseJSON)
            console.log('jqXHR.responseText: ', jqXHR.responseText)
          },
          success: function(data, textStatus, jqXHR) {
            callback.call(this, data)
          }
        })
      },
      // Отменяет фокусировку (и перемотку к последней фокусированной ноде) если
      // был выполнен клик в "пустом" месте (или по псевдоэлементу).
      restore_focus: false
    },
    plugins: [
      "types"
    ],
    types: {
      default: {
        icon: "jstree-folder",
        name: "папка"
      },
      file: {
        icon: "jstree-file",
        name: "товар"
      }
    }
  }).on("loaded.jstree", function(event, data) {
    // console.log('loaded.jstree data: ', data)
    // $(data.instance.element).find(".jstree-anchor").after('<div class="jstree-column"></div>')
    // debugger
  }).on("ready.jstree", function(event, data) {
    // console.log('ready.jstree data: ', data)
    // $(data.instance.element).find(".jstree-anchor").after('<div class="jstree-column"></div>')
    // debugger
  }).on("refresh.jstree", function(event, data) {
    // console.log('refresh.jstree data: ', data)
    // $(data.instance.element).find(".jstree-anchor").after('<div class="jstree-column"></div>')
    // debugger
  }).on("load_node.jstree", function(event, data) {
    // console.log('load_node.jstree data: ', data)
    // $(data.instance.element).find(".jstree-anchor").after('<div class="jstree-column"></div>')
    // debugger
  }).on("show_node.jstree", function(event, data) {
    // console.log('show_node.jstree data: ', data)
    // $(data.instance.element).find(".jstree-anchor").after('<div class="jstree-column"></div>')
    // debugger
  }).on("refresh.jstree", function(event, data) {
    // console.log('refresh.jstree data: ', data)
    // $(data.instance.element).find(".jstree-anchor").after('<div class="jstree-column"></div>')
    // debugger
  }).on("loaded.jstree open_node.jstree", function(event, data) {
    jstree_column(data)
    jstree_icons(data)
  })

})
