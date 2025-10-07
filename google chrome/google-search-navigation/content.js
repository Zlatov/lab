console.log("Расширение 'Навигация по поисковой выдаче Google' загружено!");

function initNavigation() {
  console.log("Инициализация навигации...")

  window.google_search_navigation = {
    current_element_index: 0
  }

  document.addEventListener('keyup', function(event) {
    // Проверяем, что мы не в текстовом поле
    if (event.target.tagName == 'INPUT' || event.target.tagName == 'TEXTAREA') {
      return null
    }

    // К предыдущему элементу поисковой выдачи
    if (event.keyCode == 38) {
      event.preventDefault()
      console.log("Нажата клавиша ↑")
      select_element(window.google_search_navigation.current_element_index - 1)
    }

    // К следующему элементу поисковой выдачи
    if (event.keyCode == 40) {
      event.preventDefault()
      console.log("Нажата клавиша ↓")
      select_element(window.google_search_navigation.current_element_index + 1)
    }

    // Переходим к вводу поисковых запросов
    if (event.keyCode == 81) {
      event.preventDefault()
      console.log("Нажата клавиша q")
      var input = document.querySelector("textarea.gLFyf")
      if (input == null) {
        console.log('> Не найден поиск Google.')
        return null
      }
      if (input != document.activeElement) {
        input.focus()
      }
    }
  })
}

// Запускаем нашу функцию когда DOM полностью готов
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initNavigation)
} else {
  initNavigation()
}

// Перемещаем указатель на элемент с индексом
function select_element(index) {
  // Поиск всех элементов поисковой выдачи
  var elements = window.document.querySelectorAll("div#search div.yuRUbf")
  if (elements.length == 0) {
    console.log('Нет элементов поисковой выдачи')
    return null
  }

  // Выход за рамки поисковой выдачи
  if (index < 0 || index >= elements.length) {
    console.log('Выход за рамки поисковой выдачи')
    return null
  }

  // Перемещаем указатель на текущий элемент поисковой выдачи
  var result_pointer = document.getElementById("result-pointer")
  if (result_pointer != null) {
    result_pointer.remove()
  }
  var element = elements[index]
  element.innerHTML = `
    <div id="result-pointer">➡️</div>
  ` + element.innerHTML

  // Скролим к элементу
  var rect = element.getBoundingClientRect()
  if (!(rect.top >= 0 && rect.bottom <= window.innerHeight)) {
    window.scrollTo(0, rect.top + window.pageYOffset - (window.innerHeight / 2))
  }

  // Фокус ставим на ссылку в текущем элементне поисковой выдачи
  var link = element.querySelectorAll('a')[0]
  link.focus()

  // Запоминаем на каком мы элементе
  window.google_search_navigation.current_element_index = index
}

// // Также переинициализируем при навигации по истории (вперед/назад) и при смене страниц в выдаче (если это SPA)
// // Это может быть полезно для Google, который часто использует AJAX-навигацию
// let lastUrl = location.href;
// new MutationObserver(() => {
//   const url = location.href;
//   if (url !== lastUrl) {
//     lastUrl = url;
//     // Даем странице немного времени на обновление DOM после смены URL
//     setTimeout(initNavigation, 500);
//   }
// }).observe(document, { subtree: true, childList: true });
