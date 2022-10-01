# Typeahead

```sh
yarn
rm -rf public/packs
npm run dev-open
```


```js
// app/javascript/packs/application.js
import "typeahead.js"
```

```sh
yarn add typeahead.js
rails assets:clobber
./bin/webpack-dev-server
rails s
```

```js
$(document).on("turbolinks:load", function() {
  var $users_typeahead = $(".users_typeahead")
  $users_typeahead.typeahead({
    minLength: 1,
    hint: true,
    highlight: true
  },
  {
    name: "my-dataset",
    limit: 10,
    display: "label",
    source: users_search,
    // updater: function(item) {
    //   $("hiddenInputElement").val(map[item].option);
    //   return item
    // }
  }).on("typeahead:selected", function(event, selection) {
    // console.log("event: ", event)
    // console.log("selection: ", selection)
    // console.log("this: ", this)
    window.location.href = selection.path
    // Очищаем после действий с выбранным значением
    $(this).typeahead("val", "")
  })

  if ($users_typeahead.length) {
    $("body").on("keydown", function(event) {
      var ctrl_q = Keyboard.shortcut_pressed(17, 81)
      if (ctrl_q) {
        $users_typeahead.focus()
      }
    })
  }
})
```
