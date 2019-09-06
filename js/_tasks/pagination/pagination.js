// Построение пагинационного массива

// Входные данные
var current = 2
var total = 10

// Настройки
var central_max = 2
var side_max = 3

var pages = []

// Номера страниц рядом с первой страницей.
for (var i = 1; i <= side_max; i++) {
  if (1 <= i && i <= total) {
    pages.push(i)
  }
}

// Номера страниц рядом с текущей страницей.
for (var i = current - central_max; i <= current + central_max; i++) {
  if (1 <= i && i <= total) {
    pages.push(i)
  }
}

// Номера страниц рядом с последней страницей.
for (var i = total - side_max; i <= total; i++) {
  if (1 <= i && i <= total) {
    pages.push(i)
  }
}

// Номера уникальны.
var pages = pages.filter((element, index, array) => {return array.indexOf(element) === index})

console.log('pages: ', pages)

// Добавление разделителя.
for (var i = 0, l = pages.length; i < l; i++) {
  var item = pages[i]

  if (i > 0 && item - pages[i - 1] > 1) {
    console.log('item: ', '…')
  }
  console.log('item: ', item)
}
