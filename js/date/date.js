console.log('> Текущая')
var a = new Date() // Объект даты
var b = a.valueOf() // Значене Объекта даты в милисекундах
var c = a.getTime() // Значене Объекта даты в милисекундах
var d = Date.now() // Значене Объекта даты в милисекундах
console.log('a: ', a)
console.log('b: ', b)
console.log('c: ', c)
console.log('d: ', d)

console.log('> Установленная')
var a = new Date(Date.now() + 100*1000)
var b = new Date("2021-05-22")
var c = new Date("2021-05-22T10:10:10")
var d = Date.parse("2021-05-22T10:10:10")
console.log('a: ', a)
console.log('b: ', b)
console.log('c: ', c)
console.log('d: ', d)

console.log('> Разница')
var a = new Date("2021-05-22T10:10:10")
var b = new Date("2021-03-21T09:09:09")
var c = a.getTime() - b.getTime()
var days = Math.floor(c / (1000 * 60 * 60 * 24))
var hours = Math.floor((c % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60))
var minutes = Math.floor((c % (1000 * 60 * 60)) / (1000 * 60))
var seconds = Math.floor((c % (1000 * 60)) / 1000)
console.log('c: ', c)
console.log('days: ', days)
console.log('hours: ', hours)
console.log('minutes: ', minutes)
console.log('seconds: ', seconds)
