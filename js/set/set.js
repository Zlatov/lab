"use strict"

// Множество

console.log('')
console.log('> Задать')
var a = new Set()
console.log('a: ', a)
var b = Object.prototype.toString.call(a) === "[object Set]"
console.log('b: ', b)
var c = new Set([1,2,2,3,3,"3",4])
console.log('c: ', c)
// return

console.log('')
console.log('> Задать из строки')
var a = new Set('hello')
console.log('a:', a)
// return

console.log('')
console.log('> Из другого Set (клонирование)')
var original = new Set([1, 2, 3])
var clone = new Set(original)
console.log('clone:', clone)
// return

console.log('')
console.log('> Добавить, .add(), возвращает [object Set]')
var a = new Set()
console.log('a: ', a)
var b = a.add('some')
console.log('a: ', a)
console.log('b: ', b)
var c = a.add('some')
console.log('a: ', a)
console.log('c: ', c)
// return

console.log('')
console.log('> Проверить, .has(), возвращает [object Boolean]')
var a = new Set(["asd"])
var b = a.has("asd")
console.log('b: ', b)
// return

console.log('')
console.log('> Размер, .size, свойство (не метод)')
var a = new Set()
var b = a.size
console.log('b: ', b)
// return

console.log('')
console.log('> В массив')
var a = new Set([1,2,3])
var b = [...a]
console.log('a: ', a)
console.log('b: ', b)
// return

console.log('')
console.log('> .delete() - удалить элемент (возвращает boolean)')
var a = new Set([1, 2, 3, 4, 5])
var b = a.delete(3)
var c = a.delete(3)
console.log('b: ', b)
console.log('c: ', c)
// return

console.log('')
console.log('> .clear() - очистить весь набор (возвращает undefined)')
var a = new Set([1, 2, 3, 4, 5])
console.log('a: ', a)
var b = a.clear()
var c = a.clear()
console.log('a: ', a)
console.log('b: ', b)
console.log('c: ', c)
// return

console.log('')
console.log('> .forEach() - итерация')
var fruits = new Set(['apple', 'banana', 'orange'])
fruits.forEach((value, valueAgain, set) => {
  if (value == "banana") {
    set.delete(value)
  }
  console.log('value, valueAgain, set: ', value, valueAgain, set)
})
// return

console.log('')
console.log('> Операции с Set')
const setA = new Set([1, 2, 3])
const setB = new Set([3, 4, 5])
console.log('')
console.log('> Объединение')
const union = new Set([...setA, ...setB])
console.log('union:', union) // Set(5) {1, 2, 3, 4, 5}
console.log('')
console.log('> Пересечение')
const intersection = new Set([...setA].filter(x => setB.has(x)))
console.log('intersection:', intersection) // Set(1) {3}
console.log('')
console.log('> Разность (A - B)')
const difference = new Set([...setA].filter(x => !setB.has(x)))
console.log('difference A-B:', difference) // Set(2) {1, 2}
// return
