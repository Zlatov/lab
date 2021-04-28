Number.prototype.declension = function(words) {
  var number = this
  if (typeof words === "string") {
    words = words.split(/\s*,\s*/)
  }
  if (words[1] == null || words[1] == "") {
    words[1] = words[0]
  }
  if (words[2] == null || words[2] == "") {
    words[2] = words[1]
  }
  if (!Number.isInteger(number.valueOf())) {
    return words[2]
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
var a = 3.3
var b = a.declension('ежей,ёж,ежа')
console.log('a: ', a)
console.log('b: ', b)
var c = [...Array(30).keys()]
for (var i = 0, l = c.length; i < l; i++) {
  var item = c[i]
  console.log('item + " " + item.declension("ежей,ёж,ежа"): ', item + " " + item.declension("ежей,ёж,ежа"))
}
// return null

console.log('> Остаток от деления (mod в других языках)')
a = 10.5
b = 3
c = a % b
console.log('a: ', a)
console.log('b: ', b)
console.log('c: ', c)
console.log('2 % 2: ', 2 % 2)
// return null

console.log('> Целая часть частного (div в других языках)')
a = 10.5
b = 3
c = Math.floor(a / b)
console.log('a: ', a)
console.log('b: ', b)
console.log('c: ', c)
console.log('Math.floor(4.1 / 2): ', Math.floor(4.1 / 2))
// return null

console.log('> Math.floor')
var a = 10.99
var b = Math.floor(a)
console.log('a: ', a)
console.log('b: ', b)
// return null

console.log()
console.log('> Math.ceil')
var a = 10.01
var b = Math.ceil(a)
console.log('a: ', a)
console.log('b: ', b)
// return null

console.log()
console.log('Math.trunc() - тупо целая часть')
var a = -1.1
var b = Math.trunc(a)
console.log('a: ', a)
console.log('b: ', b)
// return null

console.log()
console.log('.split(".")[1] - дробная часть, как строка, могут быть ведущие нули.')
var a = -2.001
var b = a % 1
console.log('a: ', a)
console.log('b: ', b)
var a = -2.001
var b = String(a).split(".")[1] || ""
console.log('a: ', a)
console.log('b: ', b)
console.log('.toFixed(precision) округляет до точности precision, возвращает строку.')
var a = -2.006
var b = a.toFixed(2).split(".")[1] || ""
console.log('a: ', a)
console.log('b: ', b)
// return null

console.log()
console.log('> Округление')
// Таблица округления
//        Math.floor  Math.ceil Math.round  Math.trunc
//  3.1       3           4         3           3
//  3.6       3           4         4           3
// -1.1      -2          -1        -1          -1
// -1.6      -2          -1        -2          -1
console.log('> Округление с помощью функции .toFixed(precision) округляет до точности precision, возвращает строку.')
var a = 1
var b = a.toFixed(2)
var c = a.toFixed(0)
console.log('a: ', a)
console.log('b: ', b)
console.log('c: ', c)
console.log('> Округление с помощью выражения Math.round(...*100)/100')
console.log('Math.round(1.00003 * 100) / 100: ', Math.round(1.00003 * 100) / 100)
console.log('Math.round(1.554 * 100) / 100: ', Math.round(1.554 * 100) / 100)
console.log('Math.round(1.555 * 100) / 100: ', Math.round(1.555 * 100) / 100)
return null

console.log()
console.log('> numberWithSpaces()')
function numberWithSpaces(x) {
  var parts = x.toString().split(".");
  parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, " ");
  return parts.join(".");
}
var a = 10000000000.1
var b = numberWithSpaces(a.toFixed(2))
var c = numberWithSpaces(a.toFixed(0))
console.log('a: ', a)
console.log('b: ', b)
console.log('c: ', c)
// return null

var a = "1111111"
var b = a.replace(/\B(?=(\d{3})+(?!\d))/, "s")
//                 граница между символами одного типа
//                   после которой есть
//                      одна или более групп из трёх цифр
//                              после которой/которых нет цифр
console.log('a: ', a)
console.log('b: ', b)
// return null

console.log()
console.log('> .toString()')
a = [0, 0.00001, 0.09, 1.00009]
for (var i = 0, l = a.length; i < l; i++) {
  var item = a[i]
  console.log('item: ', item, item.toString())
}
