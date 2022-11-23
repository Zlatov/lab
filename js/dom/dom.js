// Работа с DOM на чистом javascript

window.addEventListener("load", (event) => {
  console.log('> Получить DOM по идентификатору')
  var a = window.dom_id
  console.log('a: ', a)
  console.log('> или')
  var a = window.document.getElementById("dom_id")
  console.log('a: ', a)

  console.log('> Получить DOM по имени тега. Возвращает массив HTMLCollection.')
  var a = window.document.getElementsByTagName('div')
  console.log('a: ', a)

  console.log('> Потомки DOM. Возвращает массив HTMLCollection.')
  var a = window.dom_id
  var b = a.getElementsByTagName('*')
  console.log('a: ', a)
  console.log('b: ', b)

  console.log('> Получить DOM по значению атрибута `name`. Возвращает «живой» массив NodeList.')
  var a = window.document.getElementsByName("fio")
  console.log('a: ', a)

  console.log('> Получить DOM по классу. Возвращает массив HTMLCollection.')
  var a = window.document.getElementsByClassName("wide")
  console.log('a: ', a)
  console.log('> или от DOM')
  var a = window.dom_id
  var b = a.getElementsByClassName("wide")
  console.log('a: ', a)
  console.log('b: ', b)

  console.log('> Получить DOM по селектору. `querySelectorAll` - массив, `querySelector` - возвращает первого.')
  var a = window.dom_id
  var b = a.querySelectorAll(".wide")
  console.log('a: ', a)
  console.log('b: ', b)
  console.log('> querySelector')
  var a = window.dom_id
  var b = a.querySelector(".wide")
  console.log('a: ', a)
  console.log('b: ', b)

  console.log('> Проверка DOM на соответствие селектору')
  var a = window.document.getElementsByTagName("ul")[0]
  var b = a.matches(".wide")
  console.log('a: ', a)
  console.log('b: ', b)

  console.log('> Поиск предка по селектору. Возвращает ближайший родительский элемент (или сам элемент), который соответствует заданному CSS-селектору или null')
  var a = window.document.getElementsByTagName("li")[0]
  var b = a.closest(".wide")
  console.log('a: ', a)
  console.log('b: ', b)

  console.log('> Получить список классов DOM элемента, и проверить наличие класса')
  var a = window.document.getElementsByTagName("ul")[0]
  var b = a.classList
  var c = b.contains("wide")
  console.log('a: ', a)
  console.log('b: ', b)
  console.log('c: ', c)
})
