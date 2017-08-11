a = ['a','b','a','b']
a.forEach((e,i,s)=>{
  if (e=='a') {
    s.splice(i,1)
    // Не остановится, уьерёт все
    // break
    // return false
  }
})
console.log(a)


a = ['a','b','a','b']
a[8] = 'c'
l = a.length // l = 9 !!!
console.log(l)
console.log(a)
for (var i = 0; i < l; i++) {
  if (a[i]=='c') {
    a.splice(i,1)
    // с остановкой
    break
  }
}
console.log(a)

console.log('concat')
a = ['1','2']
b = ['3',4]
c = a.concat(b)
d = c.concat(a)
console.log(a)
console.log(b)
console.log(c)
console.log(d)

// Объеденить массив в строку
// array.join(separator)


// Отфильтровать элементы массива
// возвращает новый массив
console.log('> Отфильтровать элементы массива')
var a = ['', 'asd']
var b = a.filter((element, index, array)=>{return element!=''})
console.log('a: ', a)
console.log('b: ', b)

// Преобразовать элементы массива
// возвращает новый массив
console.log('> Преобразовать элементы массива')
var a = ['', 'asd']
var b = a.map((e, i, a)=>{
  return e+='_sufix'
})
console.log('a: ', a)
console.log('b: ', b)


// Преобразовать массив чего-то в hash
var a = [
  {id:'id1', val: [1,2,3]},
  {id:'id2', val: [2,3,4]},
  {id:'id3', val: [3,4,5]},
]

var b = a.reduce(function(prev, curr){
  console.log('prev: ', prev)
  console.log('curr: ', curr)
  prev[curr.id] = curr.val[1]
  return prev
}, {})

console.log('a: ', a)
console.log('b: ', b)


// Массив содержит в себе хотя бы один элемент другого массива
console.log( [1,2,3].some(id=>[4,5,6,2].includes(id)) )
console.log( [1,2,3].some(id=>[4,5,6,2].indexOf(id)>=0) )
