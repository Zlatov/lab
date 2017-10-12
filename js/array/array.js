// Переборы
document.log('> Переборы'.green())
// Перебор forEach - ничего не возвращает просто выполняет функцию .length раз (над каждым элементом)
document.log('> forEach(function(elem, index, array) {}[, thisArg])'.blue())
document.log('ничего не возвращает, выполняет callback над каждым не null элементом, не останавливается на break, elem - не является ссылкой на элемнт массива.')
var a = ['a','b','a','b', , null, undefined, {a:'a'}]
a[9] = 9
document.log(a)
document.log('if e=="a" e="change"')
var b = a.forEach((e,i,a)=>{
  if (e=='a') {
    e = 'change'
    a[i] = 'change'
    // a.splice(i,1)
    // Не остановится, уьерёт все
    // break
    // return false
  }
})
document.log('a: ', a)
document.log('b: ', b)

document.log('> for (var i = 0, l=a.length; i < l; i++) {a[i]}'.blue())
var a = ['a','b','a','b']
a[8] = 'c'
l = a.length // l = 9 !!!
document.log('a: ', a)
document.log('l: ', l)
for(var i = 0, l=a.length; i < l; i++) {
  document.log('a[i]: ', a[i])
  // if (a[i]=='c') {
  //   // a.splice(i,1)
  //   // с остановкой
  //   break
  // }
}


document.log('========================='.green())
document.log('concat')
a = ['1','2']
b = ['3',4]
c = a.concat(b)
d = c.concat(a)
document.log(a)
document.log(b)
document.log(c)
document.log(d)

// Объеденить массив в строку
// array.join(separator)


// Отфильтровать элементы массива
// возвращает новый массив
document.log('> Отфильтровать элементы массива')
var a = ['', 'asd']
var b = a.filter((element, index, array)=>{return element!=''})
document.log('a: ', a)
document.log('b: ', b)

// Преобразовать элементы массива
// возвращает новый массив
document.log('> Преобразовать элементы массива')
var a = ['', 'asd']
var b = a.map((element, index, array)=>{
  return element+='_sufix'
})
document.log('a: ', a)
document.log('b: ', b)


// Преобразовать массив чего-то в hash
document.log('> Преобразовать массив чего-то в hash')
var a = [
  {id:'id1', val: [1,2,3]},
  {id:'id2', val: [2,3,4]},
  {id:'id3', val: [3,4,5]},
]

// initialValue (второй параметр ф-ии reduce) - то, с каким значением переменной previousValue начинаем перебор,
// если не задан второй параметр, то перебор начинается со второго элемента, а previousValue = первому элементу
var initialValue = {}
var b = a.reduce(function(previousValue, curr, index, array){
  document.log('previousValue: ', previousValue) // на первом элементе previousValue = {}
  document.log('curr: ', curr)
  // previousValue[curr.id] = curr.val[1] // второй элемент массива
  previousValue[curr.id] = curr.val.slice(0) // весь массив
  return previousValue
}, initialValue)

document.log('a: ', a)
document.log('b: ', b)

// Часть массива
document.log('> Часть массива')

// slice (кусочек)
a = [1,2,3,4]
b = a.slice(1)
a[1] = 100
document.log('a: ', a)
document.log('b: ', b)

// Массив содержит в себе хотя бы один элемент другого массива
document.log('> Массив содержит в себе хотя бы один элемент другого массива')
document.log( [1,2,3].some(id=>[4,5,6,2].includes(id)) )
document.log( [1,2,3].some(id=>[4,5,6,2].indexOf(id)>=0) )
