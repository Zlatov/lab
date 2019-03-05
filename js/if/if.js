// console.log('this: ', this)

console.log('> Полный синтаксис')
// a = false
// b = false
// if (a) {
//   console.log('if')
// } else if (b) {
//   console.log('else if')
// } else {
//   console.log('else')
// }

console.log('> Сокращённый синтаксис')
if (true) console.log('a')
// this.a = function(argument) {
//   if (argument) {
//     console.log('this: ', this)
//     return 'true'
//   }
//   if (argument===false) return 'false'
//   return null
// }
function a(argument) {
  if (argument) {
    return 'true'
  }
  if (argument===false) return 'false'
  return null
}

// console.log(this.a(true))
// console.log(this.a(false))
// console.log(this.a(null))

console.log(a(true))
console.log(a(false))
console.log(a(null))

console.log('> Тернарный оператор')
a = true
b = a ? 'a' : '!a'
console.log('a: ', a)
console.log('b: ', b)

console.log('> Вложенный тернарный оператор')
a = false
b = true
c = a == true ? 'a=t' : b == true ? 'b=t' : 'b=f'
d = a == true ? b == true ? 'b=t' : 'b=f' : 'a=f'
console.log('c: ', c)
console.log('d: ', d)
