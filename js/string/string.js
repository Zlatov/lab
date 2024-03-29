"use strict"

// Разбить в массив
console.log('> Разбить в массив')
console.log('> по пробелу')
var a = "How are you doing today?";
var b = a.split(" ")
console.log('a: ', a)
console.log('b: ', b)
console.log('> по разделениям сделанными любыми пробельными символами')
var a = "How are you   doing	today?";
var b = a.split(/\s+/ig)
console.log('a: ', a)
console.log('b: ', b)
console.log('> по запятым, не учитывая пробелы до или после запятой')
var a = 'Гарри Трамп ,Фрэд Барни, Хелен Ригби , Билл Абель ,Крис Ханд ';
var b = a.split(/\s*,\s*/)
console.log('a: ', a)
console.log('b: ', b)
console.log('> по запятой с пробелом после')
var a = '1,2, 3, 1,4 , 1,5 ,Крис Ханд ';
var b = a.split(/\s*,\s+|\s*,(?=[^\d])/)
console.log('a: ', a)
console.log('b: ', b)
console.log('> по переносам, не учитывая пробелы до и после переноса')
var a = " asd \n zxc\nqwe ";
var b = a.split(/\s*\n\s*/)
console.log('a: ', a)
console.log('b: ', b)
// return


// Метод trim() удаляет пробельные символы с начала и конца строки.
console.log("\n")
console.log('> Метод trim() удаляет пробельные символы с начала и конца строки.')
var a = "   foo \n asd  "
var b = a.trim()
console.log('a: ', a)
console.log('b: ', b)
// return

// Заменить
console.log("\n")
console.log('> Заменить')
var a = '.A.A.a'
var b = a.replace(/A/gi, '!')
var b = a.replace('A', '!')
console.log('a: ', a)
console.log('b: ', b)
// return

console.log("\n")
console.log('> str_replce')
function str_replce(search, replace, subject) {
  if (typeof(search) === 'string' && typeof(replace) === 'string') {
    search = [search]
    replace = [replace]
  }
  if (
    Object.prototype.toString.call(search) === '[object Array]' &&
    Object.prototype.toString.call(replace) === '[object Array]' &&
    search.length == replace.length
  ) {
    var regex
    for (var i = 0; i < search.length; i++) {
      regex = new RegExp(search[i], 'g')
      subject = subject.replace(regex, replace[i])
    }
  }
  return subject
}
a = 'asd asd'
b = str_replce('a', '1', a)
b = str_replce(['s', 'd'], ['2', '3'], b)
console.log('a: ', a)
console.log('b: ', b)
// return

// slice - возвращает новую строку извлекая часть строки.
console.log("\n")
console.log("slice - возвращает новую строку извлекая часть строки.")
console.log('> slice([begin[, end]]) интервал [b,e)')
console.log('> begin - индекс с которого начинаем выбирать,')
console.log('> end - индекс с которого прекращаем выбирать (символ под индексом end не выбирается).')
var a = '0123456789'
var b = a.slice(2)
var c = a.slice(2, 5)
var d = a.slice(-6)
var e = a.slice(-6, -2)
console.log('a: ', a) // 0123456789
console.log('b: ', b) // 23456789
console.log('c: ', c) // 234
console.log('d: ', d) // 456789
console.log('e: ', e) // 4567
// return

// Всё после второй точки удалить вместе с точкой.
var a = '5.234.3'
var r = (a.split('.').length > 2) ? a.split('.').slice(0, 2).join('.') : a
console.log('r: ', r)
// return null

// Сгенерировать regex из стринги
console.log('----------------------------------------')
console.log('> Сгенерировать regex из стринги')
console.log('GODzilla'.replace(new RegExp('god', 'i'), ''))

// Фильтр пользовательского ввода для создания регулярного выражения
console.log('----------------------------------------')
console.log('> Фильтр пользовательского ввода для создания регулярного выражения')
a = 'ds\\^f[sd Ширина (м)'
b = a.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'); // $& means the whole matched string
console.log('a: ', a)
console.log('b: ', b)

console.log('----------------------------------------')
console.log('substring')
console.log('\'Цвет кармана\'.substring(0,4): ', 'Цвет кармана'.substring(0, 4))

console.log('> Вырезать с конца строки')
a = "123456"
b = a.substring(a.length - 2)
console.log('b: ', b)
// return null


console.log('----------------------------------------')
console.log('> Преобразование в int')
console.log('0: ', parseInt('0'))
console.log('+0: ', parseInt('+0'))
console.log('-0: ', parseInt('-0'))
console.log('+000: ', parseInt('+000'))
console.log('-1: ', parseInt('-1'))
console.log('00001: ', parseInt('00001'))
console.log('-00001: ', parseInt('-00001'))
console.log('+00001: ', parseInt('+00001'))
console.log('101.1: ', parseInt('101.1'))
console.log('0.1: ', parseInt('0.1'))
console.log('-0.1: ', parseInt('-0.1'))
console.log('-0000.100: ', parseInt('-0000.100'))

console.log('----------------------------------------')
console.log('> Преобразование в Number/Float')
console.log('"": ', parseFloat(''))
console.log('0: ', parseFloat('0'))
console.log('+0: ', parseFloat('+0'))
console.log('-0: ', parseFloat('-0'))
console.log('+000: ', parseFloat('+000'))
console.log('-1: ', parseFloat('-1'))
console.log('00001: ', parseFloat('00001'))
console.log('-00001: ', parseFloat('-00001'))
console.log('+00001: ', parseFloat('+00001'))
console.log('101.1: ', parseFloat('101.1'))
console.log('0.1: ', parseFloat('0.1'))
console.log('-0.1: ', parseFloat('-0.1'))
console.log('-0000.100: ', parseFloat('-0000.100'))

var a = 'asd'
var b = parseFloat(a)
var bt = typeof b
var c = (b == NaN) // неверно
var d = isNaN(b) // верно
console.log('a: ', a)
console.log('b: ', b)
console.log('bt: ', bt)
console.log('c: ', c)
console.log('d: ', d)
// return null

console.log('Number(\'-0000.100\'): ', Number('-0000.100'))

var a = '234'
var b = '0'.repeat(5-a.length) + a
console.log('a: ', a)
console.log('b: ', b)

function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1)
}
a = "ёж"
b = capitalizeFirstLetter(a)
console.log('a: ', a)
console.log('b: ', b)

console.log('> Склонение (declension())')
function declension(number, words) {
  if (typeof words === "string") {
    words = words.split(" ")
  }
  if (words[1] == null || words[1] == "") {
    words[1] = words[0]
  }
  if (words[2] == null || words[2] == "") {
    words[2] = words[1]
  }
  if (typeof number !== 'number') {
    number = 0
  }
  var modulo_100 = Math.abs(number) % 100
  if (11 <= modulo_100 && modulo_100 <= 19) {
    return words[0]
  }
  var modulo_10 = Math.abs(number) % 10
  switch(modulo_10) {
    case 1:
      return words[1]
    break
    case 2:
    case 3:
    case 4:
      return words[2]
    break
    default:
      return words[0]
    break
  }
}

var a = [...Array(45).keys()]
for (var i = 0, l = a.length; i < l; i++) {
  var number = a[i]
  var word = declension(number, "ежей ёж ежа")
  console.log('number, word: ', number, word)
}
