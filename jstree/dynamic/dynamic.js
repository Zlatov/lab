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
            "text": "000011942",
            "data": {
              "article": "000011942"
            },
            "type": "file",
            "children": []
          },
          {
            "id": "j9_29",
            "text": "000098070",
            "data": {
              "article": "000098070"
            },
            "type": "file",
            "children": []
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


  var dynamic_jstree = $(".dynamic_jstree")
  dynamic_jstree.jstree({
    core: {
      data: function(obj, callback) {
        var url = obj.id == "#" ? "/jstree/dynamic/dynamic_root.json" : "/jstree/dynamic/dynamic_children.json"
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
  })


  var dynamic_jstree_alternative = $(".dynamic_jstree_alternative")
  dynamic_jstree_alternative.jstree({
    core: {
      data: function(obj, callback) {
        var url = obj.id == "#" ? "/jstree/dynamic/dynamic_root_alternative.json" : "/jstree/dynamic/dynamic_children_alternative.json"
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
  })




})
