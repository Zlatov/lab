;(function() {

  "use strict"

  console.log('> Shortkyes Tab!')

  // 
  // Настройки
  // 
  window.google_tabulation = {
    options: {
      // Селектор для поиска элементов списка результатов поиска (должен быть
      // блоком, содержащим где-то в себе ссылку)
      // result_list_item_selector: "div.rc>div:first-child",
      result_list_item_selector: "div#search div.yuRUbf",
    },
    // Индекс текущего выбранного элемента из списка результатов поиска (по умолчанию: первый индекс - 0).
    selected_element_index: 0
  }

  function scroll_to_element(element) {
    var rect = element.getBoundingClientRect()
    if (!(rect.top >= 0 && rect.bottom <= window.innerHeight)) {
      window.scrollTo(0, rect.top + window.pageYOffset - (window.innerHeight / 2))
    }
  }

  // Обработчик нажатия на клавишу Tab и вверх, вниз (точка входа в скрипт).
  // 1. Поиск списка элементов результата поиска;
  // 2. Поиск текущего элемента по индексу;
  // 3. Скрол к текущему элементу;
  // 4. Поиск ссылки в текущем элементе и фокус на ней;
  // 5. Сохранение индекса текущего элемента.
  function select_element(index) {
    // 1.
    var elements = window.document.querySelectorAll(window.google_tabulation.options.result_list_item_selector)
    if (elements.length == 0) {
      console.log('> google_tabulation: no elements.')
      return null
    }
    if (index < 0 || index >= elements.length) {
      console.log('> google_tabulation: this is end of the list.')
      return null
    }
    var result_pointer = document.getElementById("result-pointer")
    if (result_pointer != null) {
      result_pointer.remove()
    }
    // 2.
    var element = elements[index]
    // element.innerHTML = '<div id="result-pointer" style="position:absolute;left:-15px;">&gt;</div>' + element.innerHTML
    element.innerHTML = '<div id="result-pointer" style="position:absolute;left:0px;color:green;z-index:1000;">&gt;</div>' + element.innerHTML
    // 3.
    scroll_to_element(element)
    // 4.
    // var link = element.querySelector('a')
    // Добавили всякую хрень с дополнительными ссылками в div.r
    // поэтому, теперь ищем непосредственно ссылку-ребёнка
    // `querySelectorAll('.r > a')`, а не потомка `.querySelector('a')`.
    var link = element.querySelectorAll('a')[0]
    link.focus()
    // 5.
    window.google_tabulation.selected_element_index = index
  }

  document.onkeyup = function(event) {
    if(event.keyCode == 38) {
      console.log('> up')
      var input = document.querySelector("textarea.gLFyf")
      if (input == null) {
        console.log('> no google input.')
        return null
      }
      if (input == document.activeElement) {
        return null
      }
      select_element(window.google_tabulation.selected_element_index - 1)
    }
    if(event.keyCode == 40) {
      console.log('> down')
      var input = document.querySelector("textarea.gLFyf")
      if (input == null) {
        console.log('> no google input.')
        return null
      }
      if (input == document.activeElement) {
        return null
      }
      select_element(window.google_tabulation.selected_element_index + 1)
    }
  }

  select_element(0)

})();
