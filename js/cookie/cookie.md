```sh
yarn add js-cookie
```

```js
import Cookies from 'js-cookie'
window.Cookies = Cookies
```

```js
var string_opened_node_ids = JSON.stringify(opened_node_ids)
var byte_size = new Blob([string_opened_node_ids]).size
// Сколько можно записать в куки
if (byte_size > 4096) {
  return null
}

// js-cookie
Cookies.set("admin_catalogs_opened_node_ids", string_opened_node_ids, { expires: 2 })
Cookies.get("admin_catalogs_opened_node_ids")

// jquery
$.cookie('phil')



  $(".catalog_tree").jstree({
    // …
    save_opened: function(event, data) {
      var tree = data.instance
      // var node = data.node
      var tree_data = tree.get_json("#", {
        no_state: false,
        no_id: false,
        no_children: false,
        no_data: true,
        no_li_attr: true,
        no_a_attr: true,
        flat: true
      })
      var opened_node_ids = []
      for (var i = 0, l = tree_data.length; i < l; i++) {
        var node = tree_data[i]
        if (node.state.opened) {
          opened_node_ids.push(node.id)
        }
      }
      var string_opened_node_ids = JSON.stringify(opened_node_ids)
      var byte_size = new Blob([string_opened_node_ids]).size
      if (byte_size > 4096) {
        return null
      }
      Cookies.set("admin_catalogs_opened_node_ids", string_opened_node_ids, { expires: 2 })
      // var arr = JSON.parse(json_str);
    },
    restore_opened: function(data) {
      var string_opened_node_ids = Cookies.get("admin_catalogs_opened_node_ids")
      if (!string_opened_node_ids) {
        return null
      }
      var opened_node_ids = JSON.parse(string_opened_node_ids)
      for (var i = 0, l = data.length; i < l; i++) {
        var node = data[i]
        if (opened_node_ids.includes(node.id)) {
          node.state = Object.assign(node.state || {}, { opened: true })
        }
      }
    }
    // …
  }).on("open_node.jstree", function(event, data) {
    $(this).jstree(true).settings.save_opened(event, data)
  }).on("close_node.jstree", function(event, data) {
    $(this).jstree(true).settings.save_opened(event, data)
  })
```
