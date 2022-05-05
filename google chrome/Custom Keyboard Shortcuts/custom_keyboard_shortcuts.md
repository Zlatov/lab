## Настройки плагина Custom Keyboard Shortcuts

Можно в Настройках импортировать все сочетания клавиш сохраненные в json формате:

```json
[
  {
    "activeInInputs": true,
    "action": "javascript",
    "code": ";(function() {\n\n  \"use strict\"\n  \n  var input = document.querySelector(\"input.gLFyf\")\n  if (input == null) {\n    console.log('> Не найден поиск google.')\n    return null\n  } else {\n    console.log('> Поиск google найден.')\n  }\n\n  if (input != document.activeElement) {\n    input.focus()\n  }\n\n})();\n",
    "blacklist": "whitelist",
    "sites": "*google.ru*",
    "key": "ctrl+q",
    "sitesArray": [
      "*google.ru*"
    ],
    "label": "ctrl+q"
  },
  {
    "key": "tab",
    "label": "tab",
    "action": "javascript",
    "blacklist": "whitelist",
    "sites": "*google.ru*",
    "code": ";(function() {\n\n  \"use strict\"\n\n  console.log('> Shortkyes Tab!')\n\n  // \n  // Настройки\n  // \n  window.google_tabulation = {\n    options: {\n      // Селектор для поиска элементов списка результатов поиска (должен быть\n      // блоком, содержащим где-то в себе ссылку)\n      // result_list_item_selector: \"div.rc>div:first-child\",\n      result_list_item_selector: \"div#search div.yuRUbf\",\n    },\n    // Индекс текущего выбранного элемента из списка результатов поиска (по умолчанию: первый индекс - 0).\n    selected_element_index: 0\n  }\n\n  function scroll_to_element(element) {\n    var rect = element.getBoundingClientRect()\n    if (!(rect.top >= 0 && rect.bottom <= window.innerHeight)) {\n      window.scrollTo(0, rect.top + window.pageYOffset - (window.innerHeight / 2))\n    }\n  }\n\n  // Обработчик нажатия на клавишу Tab и вверх, вниз (точка входа в скрипт).\n  // 1. Поиск списка элементов результата поиска;\n  // 2. Поиск текущего элемента по индексу;\n  // 3. Скрол к текущему элементу;\n  // 4. Поиск ссылки в текущем элементе и фокус на ней;\n  // 5. Сохранение индекса текущего элемента.\n  function select_element(index) {\n    // 1.\n    var elements = window.document.querySelectorAll(window.google_tabulation.options.result_list_item_selector)\n    if (elements.length == 0) {\n      console.log('> google_tabulation: no elements.')\n      return null\n    }\n    if (index < 0 || index >= elements.length) {\n      console.log('> google_tabulation: this is end of the list.')\n      return null\n    }\n    var result_pointer = document.getElementById(\"result-pointer\")\n    if (result_pointer != null) {\n      result_pointer.remove()\n    }\n    // 2.\n    var element = elements[index]\n    element.innerHTML = '<div id=\"result-pointer\" style=\"position:absolute;left:-15px;\">&gt;</div>' + element.innerHTML\n    // 3.\n    scroll_to_element(element)\n    // 4.\n    // var link = element.querySelector('a')\n    // Добавили всякую хрень с дополнительными ссылками в div.r\n    // поэтому, теперь ищем непосредственно ссылку-ребёнка\n    // `querySelectorAll('.r > a')`, а не потомка `.querySelector('a')`.\n    var link = element.querySelectorAll('a')[0]\n    link.focus()\n    // 5.\n    window.google_tabulation.selected_element_index = index\n  }\n\n  document.onkeyup = function(event) {\n    if(event.keyCode == 38) {\n      console.log('> up')\n      var input = document.querySelector(\"input.gLFyf\")\n      if (input == null) {\n        console.log('> no google input.')\n        return null\n      }\n      if (input == document.activeElement) {\n        return null\n      }\n      select_element(window.google_tabulation.selected_element_index - 1)\n    }\n    if(event.keyCode==40) {\n      console.log('> down')\n      var input = document.querySelector(\"input.gLFyf\")\n      if (input == null) {\n        console.log('> no google input.')\n        return null\n      }\n      if (input == document.activeElement) {\n        return null\n      }\n      select_element(window.google_tabulation.selected_element_index + 1)\n    }\n  }\n\n  select_element(0)\n\n})();\n",
    "sitesArray": [
      "*google.ru*"
    ],
    "activeInInputs": false
  },
  {
    "key": "ctrl+q",
    "label": "context.reverso.net",
    "action": "javascript",
    "sites": "*context.reverso.net*",
    "sitesArray": [
      "*context.reverso.net*"
    ],
    "code": "$(\".example.blocked\").removeClass(\"blocked\");\n$(\"#blocked-results-banner\").remove();\n",
    "blacklist": "whitelist"
  }
]
```
