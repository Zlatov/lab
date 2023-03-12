console.log('> Синтаксис')
var a = true
var b = () => a ? 'yes' : 'no'
var c = param => param ? 'yes' : 'no'
var d = (param) => param ? 'yes' : 'no'
var e = (param, param2) => param && param2 ? 'yes' : 'no'
var f = () => {
  return a ? 'yes' : 'no'
}
var g = param => {
  return param ? 'yes' : 'no'
}
var h = (param) => {
  return param ? 'yes' : 'no'
}
var i = (param, param2) => {
  return param && param2 ? 'yes' : 'no'
}
console.log('b(): ', b())
console.log('c(true): ', c(true))
console.log('d(true): ', d(true))
console.log('e(true, true): ', e(true, true))
console.log('f(): ', f())
console.log('g(true): ', g(true))
console.log('h(true): ', h(true))
console.log('i(true, true): ', i(true, true))
