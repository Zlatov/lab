console.log('Доступ к данным')
console.log('a = {a:1}: ', a = {a:1})
console.log('a.a: ', a.a)
console.log('a["a"]: ', a["a"])
console.log('a.z: ', a.z)
console.log('a["z"]: ', a["z"])

console.log('Слияние')
console.log('a = {a:1}: ', a = {a:1})
console.log('b = {b:2}: ', b = {b:2})
console.log('c = {}: ', c = {})
console.log('Object.assign({},a,b): ', Object.assign({},a,b))
console.log('a: ', a)
console.log('Object.assign({},a,b,c): ', Object.assign({},a,b,c))

console.log('Клонирование (то же что слияние с {})')
console.log('a = {a:1}: ', a = {a:1})
console.log('b = Object.assign({},a): ', b = Object.assign({},a))
console.log('a.a=2: ', a.a=2)
console.log('a.a: ', a.a)
console.log('b.a: ', b.a)

console.log('Перебор')
console.log('for (var key in b) {...')
for (var key in b) {
  console.log('key: ', key)
  console.log('b[key]: ', b[key])
}

console.log('Удаление свойства')
console.log('a = {a:1}: ', a = {a:1})
console.log('delete a.a: ', delete a.a)
console.log('a: ', a)
