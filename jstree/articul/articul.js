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
              "text": "Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1 Широкоформатный УФ принтер 1",
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
              }
            }
          ]
        }
      ]
    }
  ]

  var static_jstree = $(".static_jstree")
  static_jstree.jstree({
    core: {
      data: data
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
  })

  var articul_jstree = $(".articul_jstree")
  articul_jstree.jstree({
    core: {
      data: function(obj, callback) {
        var url = obj.id == "#" ? "/jstree/articul/data/articul_root.json" : "/jstree/articul/data/articul_children_" + obj.id + ".json"
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
      }
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
  }).on("select_node.jstree", function(e, data) {
    console.log('e: ', e)
    console.log('data: ', data)
    // var href = data.node.a_attr.href;
    // window.location.href = href;
  }).on("click", ".jstree-node", function(event) {
    event.stopPropagation()
    event.stopImmediatePropagation()
    // console.log('event: ', event)
    // console.log('event.offsetX: ', event.offsetX)
    // console.log('event.target.offsetWidth: ', event.target.offsetWidth)
    if (event.offsetX > event.target.offsetWidth) {
      console.log('> Клик по псевдо-элементу')
    } else {
      console.log('> Клик по элементу')
    }
  })

})
