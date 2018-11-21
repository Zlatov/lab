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
var a = -2.006
console.log('.toFixed(precision) округляет до точности precision, возвращает строку.')
var b = a.toFixed(2).split(".")[1] || ""
console.log('a: ', a)
console.log('b: ', b)
return null

console.log()
console.log('> toFixed()')
var a = 1
var b = a.toFixed(2)
var c = a.toFixed(0)
console.log('a: ', a)
console.log('b: ', b)
console.log('c: ', c)
// return null

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
