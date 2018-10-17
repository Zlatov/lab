"use strict"

console.log('> Массив.')
var a = ['a', 1, true, , null, undefined, { a: 'a' }]
a[7] = 9
console.log('a: ', a)
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

console.log('> for (var i = 0, l=a.length; i < l; i++) {a[i]}'.blue())
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



console.log('> concat'.green())
var a = ['1', '2']
var b = ['3', 4]
var c = a.concat(b)
var d = c.concat(a)
console.log(a)
console.log(b)
console.log(c)
console.log(d)


console.log('> Объеденить массив в строку'.green())
console.log('join'.blue())
a = [1,2,3,4]
b = a.join()
c = a.join('-')
console.log(a)
console.log(b)
console.log(c)



console.log('> Отфильтровать элементы массива'.green())
console.log('возвращает новый массив'.blue())
var a = ['', 'asd']
var b = a.filter((element, index, array) => { return element != '' })
console.log('a: ', a)
console.log('b: ', b)


console.log('> Пересечение массивов'.green())
var a = [1,2,3,2]
var b = [2,3,2,0]
var c = a.filter((e) => b.includes(e))
console.log('c: ', c)


console.log('> привести к уникальным значениям примерно как в _.uniq()'.green())
console.log('возвращает новый массив'.blue())
var a = ['2', 1, 'asd', 2, 1, 'asd', '1', 2, '', , 0]
var b = a.filter((element, index, array) => { return array.indexOf(element) === index })
console.log('a: ', a)
console.log('b: ', b)


console.log('> Преобразовать элементы массива'.green())
console.log('возвращает новый массив'.blue())
var a = ['', 'asd', , 3, undefined]
var b = a.map(function(element, index, array) {
  if (element=='asd') {
    return element += '_sufix'
  }
}).filter(e=>!!e) // Отфильтровать null значения
console.log('a: ', a)
console.log('b: ', b)


console.log('> Удалить элементы массива по значению в переборе'.green())
console.log('> индексы ведь меняются после удаления, map накосячит:'.blue())
var a = [{id:0},{id:1},{id:2},{id:3},{id:4},{id:5}]
a.map((element, index, array) => {
  if (element.id == 4 || element.id == 5) {
    console.log('index: ', index)
    array.splice(index, 1)
  }
})
console.log('a: ', a)
console.log('> for вместе с i-- :'.blue())
var a = [{id:0},{id:1},{id:2},{id:3},{id:4},{id:5}]
for(var i=0; i<a.length; i++) {
  if (a[i].id == 4 || a[i].id == 5) {
    console.log('i: ', i)
    a.splice(i, 1)
    i--
  }
}
console.log('a: ', a)


console.log('> Преобразовать массив чего-то в hash'.green())
var a = [
  { id: 'id1', val: [1, 2, 3] },
  { id: 'id2', val: [2, 3, 4] },
  { id: 'id3', val: [3, 4, 5] },
]

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


console.log('> Часть массива'.green())

console.log('> slice([begin[, end]]) (кусочек) возврящает новый массив.'.blue())
a = [1, 2, 3, 4]
b = a.slice(1)
a[1] = 100
console.log('a: ', a)
console.log('b: ', b)

console.log('> без последнего элемента.'.blue())
a = [1, 2, 3, 4]
b = a.slice(0, -1)
console.log('a: ', a)
console.log('b: ', b)


console.log('> Массив содержит в себе хотя бы один элемент другого массива'.green())
console.log([1, 2, 3].some(id => [4, 5, 6, 2].includes(id)))
console.log([1, 2, 3].some(id => [4, 5, 6, 2].indexOf(id) >= 0))


console.log('> Перебор nested массива'.green())
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

console.log('a: ', a)

var level = 0
var cache = []
cache[level] = a.clone()
cache[level].reset()
var parent = []
parent[level] = null

while (level>=0) {
  var node = cache[level].next()
  if (node != null) {

    console.log('node.id: ', node.id)
    console.log('parent: ', parent)

    if (
      node['children'] != null &&
      Object.prototype.toString.call(node['children']) === '[object Array]' &&
      node['children'].length
    ) {
      level++
      parent[level] = Object.assign({}, node)
      delete parent[level]['children']
      cache[level] = node['children'].clone()
      cache[level].reset()
    }
  } else {
    parent[level] = null
    level--
  }
}

console.log('Перебор nested массива без next/reset'.blue())
console.log('a: ', a)
var level = 0
var cache = []; cache[level] = a.slice(0)
var parent = []; parent[level] = null
var index = []; index[level] = 0
while (level>=0) {
  var node = cache[level][index[level]]
  if (node != null) {

    console.log('node.id: ', node.id)
    console.log('parent: ', parent)

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


console.log('> Сортировка'.green())
console.log('> Строки, запятые'.green())
var a = ['0,41', '100', '1,24', '1,22', '0,92', '1,23', '0,375', '1', '1,52', '0,61', '1,27']
console.log('a: ', a)
var b = a.sort()
console.log('a: ', a)
console.log('b: ', b)
console.log('> Строки, точки'.green())
var a = ['0.41', '100', '1.24', '1.22', '0.92', '1.23', '0.375', '1', '1.52', '0.61', '1.27']
console.log('a: ', a)
var b = a.sort()
console.log('a: ', a)
console.log('b: ', b)
console.log('> float'.green())
var a = [1.8, 10, 100, 14.7, 17, 18.92, 299, 5, 516, 7]
console.log('a: ', a)
var b = a.sort()
console.log('a: ', a)
console.log('b: ', b)
console.log('> float'.green())
var a = [1.8, 10, 100, 14.7, 17, 18.92, 299, 5, 516, 7]
console.log('a: ', a)
var b = a.sort((a,b)=>{return a-b})
console.log('a: ', a)
console.log('b: ', b)

console.log('> filter short syntax'.green())
var a = [1,2,3]
var b = a.filter(e=>e != 2)
console.log('a: ', a)
console.log('b: ', b)
var a = [1,2,3]
var b = a.filter(function(e){return e != 2})
console.log('a: ', a)
console.log('b: ', b)
