"use strict"

// 
// .shift() — удаляет первый элемент из массива и возвращает его значение. Этот метод изменяет длину массива.
// 

console.log('> Массив.')
var a = ['a', 1, true, , null, undefined, { a: 'a' }]
a[7] = 9
console.log('a: ', a)

var b = new Array(10);
console.log('b: ', b)

var c = [...new Array(10).keys()]
var c = [...Array(10).keys()]
console.log('c: ', c)
// return null

console.log("\n")
console.log('> Последний элемент.')
a = [1, 2, 3, 4]
b = a.slice(-1)[0]
console.log('a: ', a)
console.log('b: ', b)
// return

console.log("\n")
console.log('> splice().')
// 
// array.splice(start, delete, [item1, [item2, [...]]])
// start
//  Индекс, по которому начинать изменять массив.
// deleteCount
//  Целое число, показывающее количество удаляемых элементов.
// itemN
//  Необязательные параметры. Добавляемые к массиву элементы.

console.log('> Очистить массив. ~.clear empty?')
console.log('работает всегда:')
var a = [1, 2]
console.log('a: ', a)
a.splice(0,a.length)
console.log('a: ', a)
console.log('работает не всегда:')
var a = [1, 2]
console.log('a: ', a)
a.length = 0
console.log('a: ', a)
// return null

console.log('> splice(0) удалит всё.')
a = [1,2,3]
b = a.splice(0)
console.log('a: ', a)
console.log('b: ', b)
console.log('> splice(0, 1) удалит 1.')
a = [1,2,3]
b = a.splice(0, 1)
console.log('a: ', a)
console.log('b: ', b)
a = [1,2,3]
b = a.splice(0, 0)
console.log('> splice(0, 0) удалит 0 (ниечего не сделает).')
console.log('a: ', a)
console.log('b: ', b)
// return

console.log("\n")
console.log('> Перебор forEach().')
var a = ['a', 2, true, , null, undefined, { a: 'a' }]
console.log('a: ', a)
var b = a.forEach(function(element, index, array) {
  if (element == 'a') {
    array[index] = 'change'
    array.splice(index + 1, 1) // С индекса, Удалить столько элементов, Добавить эти элементы.
    return false // Не остановится на элементе 'a', а переберёт все запустив переданную функцию.
  }
  element = 'change'
})
console.log('a: ', a)
console.log('b: ', b)
// return

console.log('> for (var i = 0, l=a.length; i < l; i++) {a[i]}')
// var a = ['a','b','a','b']
// a[8] = 'c'
l = a.length // l = 9 !!!
console.log('a: ', a)
console.log('l: ', l)
for (var i = 0, l = a.length; i < l; i++) {
  console.log('i, a[i]: ', i, ', ', a[i])
  // if (a[i]=='c') {
  //   // a.splice(i,1)
  //   // с остановкой
  //   break
  // }
}



console.log('> concat')
var a = ['1', '2']
var b = ['3', 4]
var c = a.concat(b)
var d = c.concat(a)
console.log(a)
console.log(b)
console.log(c)
console.log(d)
// return null


console.log('> Объеденить массив в строку')
console.log('join')
a = [1,2,3,4]
b = a.join()
c = a.join('-')
console.log(a)
console.log(b)
console.log(c)



console.log('> Отфильтровать элементы массива')
console.log('возвращает новый массив')
var a = ['', 'asd']
var b = a.filter((element, index, array) => { return element != '' })
console.log('a: ', a)
console.log('b: ', b)


console.log('> Пересечение массивов')
var a = [1,2,3,2]
var b = [2,3,2,0]
var c = a.filter((e) => b.includes(e))
console.log('c: ', c)


console.log('> привести к уникальным значениям примерно как в _.uniq()')
console.log('возвращает новый массив')
var a = ['2', 1, 'asd', 2, 1, 'asd', '1', 2, null, '', , 0, null]
var b = a.filter((element, index, array) => { return array.indexOf(element) === index })
console.log('a: ', a)
console.log('b: ', b)
// return

console.log('> Преобразовать элементы массива')
console.log('возвращает новый массив')
var a = ['', 'asd', , 3, undefined]
var b = a.map(function(element, index, array) {
  if (element=='asd') {
    return element += '_sufix'
  }
}).filter(e=>!!e) // Отфильтровать null значения
console.log('a: ', a)
console.log('b: ', b)

console.log('> Развернуть (поднять) массив на уровень вверх')
var a = [1, 2, [3, 4], , undefined, null, 0]
var b = a.flat()
console.log('b: ', b)
// return

console.log('> Удалить элементы массива по значению в переборе')
console.log('> индексы ведь меняются после удаления, map накосячит:')
var a = [{id:0},{id:1},{id:2},{id:3},{id:4},{id:5}]
a.map((element, index, array) => {
  if (element.id == 4 || element.id == 5) {
    console.log('index: ', index)
    array.splice(index, 1)
  }
})
console.log('a: ', a)
console.log('> for вместе с i-- :')
var a = [{id:0},{id:1},{id:2},{id:3},{id:4},{id:5}]
// 
// Важно вычислять длинну на каждой итерации: `i < a.length`
// Важно уменьшать текущий индекс при удалении: `i--`
// 
for(var i = 0; i < a.length; i++) {
  if (a[i].id == 4 || a[i].id == 5) {
    console.log('i: ', i)
    a.splice(i, 1)
    i--
  }
}
console.log('a: ', a)


console.log('> Преобразовать массив чего-то в hash')
var a = [
  { id: 'id1', val: [1, 2, 3] },
  { id: 'id2', val: [2, 3, 4] },
  { id: 'id3', val: [3, 4, 5] },
]

console.log('> Клонирование массива ~ .clone')
var temp = {a:1}
var a = [temp, 1]
var b = a.slice(0)
b[1] = 2 // Скалярные данные передаются как значение.
b[0].a = 2 // Структруированные данные передаются по ссылке.
console.log('a: ', a) // a:  [ { a: 2 }, 1 ]
// return null

// initialValue (второй параметр ф-ии reduce) - то, с каким значением переменной previousValue начинаем перебор,
// если не задан второй параметр, то перебор начинается со второго элемента, а previousValue = первому элементу
var initialValue = {}
var b = a.reduce(function(previousValue, curr, index, array) {
  console.log('previousValue: ', previousValue) // на первом элементе previousValue = {}
  console.log('curr: ', curr)
  // previousValue[curr.id] = curr.val[1] // второй элемент массива
  previousValue[curr.id] = curr.val.slice(0) // весь массив
  return previousValue
}, initialValue)
console.log('a: ', a)
console.log('b: ', b)

console.log()
console.log('> Часть массива')
console.log('> slice([begin[, end]]) (кусочек) возврящает новый массив.')
console.log('> begin - индекс с которого извлекаются элементы.')
console.log('> end - индекс до которого извлекаются элементы, не включая указанный.')
a = [1, 2, 3, 4]
b = a.slice(1) // [2, 3, 4]
c = a.slice(1,3) // [2, 3]
d = a.slice(1,100) // [2, 3, 4]
console.log('a: ', a)
console.log('b: ', b)
console.log('c: ', c)
console.log('d: ', d)
// return null

console.log('> без последнего элемента.')
a = [1, 2, 3, 4]
b = a.slice(0, -1)
console.log('a: ', a)
console.log('b: ', b)


console.log('> Массив содержит в себе хотя бы один элемент другого массива')
console.log([1, 2, 3].some(id => [4, 5, 6, 2].includes(id)))
console.log([1, 2, 3].some(id => [4, 5, 6, 2].indexOf(id) >= 0))


console.log('> Перебор nested массива')
a = [
  {id: '1'},
  {id: '2', children:
    [
      {id: '3'},
      {id: '4'}
    ]
  },
  {
    id: '5', children:
    [
      {id: '6', children:
        [
          {id: '7'}
        ]
      }
    ]
  },
  {
    id: '8', children:
    [
      {id: '9'}
    ]
  }
]

// console.log('a: ', a)

// var level = 0
// var cache = []
// cache[level] = a.clone()
// cache[level].reset()
// var parent = []
// parent[level] = null

// while (level>=0) {
//   var node = cache[level].next()
//   if (node != null) {

//     console.log('node.id: ', node.id)
//     console.log('parent: ', parent)

//     if (
//       node['children'] != null &&
//       Object.prototype.toString.call(node['children']) === '[object Array]' &&
//       node['children'].length
//     ) {
//       level++
//       parent[level] = Object.assign({}, node)
//       delete parent[level]['children']
//       cache[level] = node['children'].clone()
//       cache[level].reset()
//     }
//   } else {
//     parent[level] = null
//     level--
//   }
// }

console.log('Перебор nested массива без next/reset')
console.log('a: ', a)
var level = 0
var cache = []; cache[level] = a.slice(0)
var parent = []; parent[level] = null
var index = []; index[level] = 0
while (level >= 0) {
  var node = cache[level][index[level]]
  if (node != null) {

    console.log('node.id: ', node.id)
    console.log('parent: ', parent)
    console.log('level: ', level)

    if (
      node['children'] != null &&
      Object.prototype.toString.call(node['children']) === '[object Array]' &&
      node['children'].length
    ) {
      level++
      index[level] = 0
      parent[level] = Object.assign({}, node)
      delete parent[level]['children']
      cache[level] = node['children'].slice(0)
    } else {
      index[level]++
    }
  } else {
    parent[level] = null
    level--
    index[level]++
  }
}
// return

console.log('> Сортировка')
console.log('> Строки, запятые')
var a = ['0,41', '100', '1,24', '1,22', '0,92', '1,23', '0,375', '1', '1,52', '0,61', '1,27']
console.log('a: ', a)
var b = a.sort()
console.log('a: ', a)
console.log('b: ', b)
console.log('> Строки, точки')
var a = ['0.41', '100', '1.24', '1.22', '0.92', '1.23', '0.375', '1', '1.52', '0.61', '1.27']
console.log('a: ', a)
var b = a.sort()
console.log('a: ', a)
console.log('b: ', b)
console.log('> float')
var a = [1.8, 10, 100, 14.7, 17, 18.92, 299, 5, 516, 7]
console.log('a: ', a)
var b = a.sort()
console.log('a: ', a)
console.log('b: ', b)
console.log('> float')
var a = [1.8, 10, 100, 14.7, 17, 18.92, 299, 5, 516, 7]
console.log('a: ', a)
var b = a.sort((a,b)=>{return a-b})
console.log('a: ', a)
console.log('b: ', b)

console.log('> filter short syntax')
var a = [1,2,3]
var b = a.filter(e=>e != 2)
console.log('a: ', a)
console.log('b: ', b)
var a = [1,2,3]
var b = a.filter(function(e){return e != 2})
console.log('a: ', a)
console.log('b: ', b)
