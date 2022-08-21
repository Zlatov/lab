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
```
