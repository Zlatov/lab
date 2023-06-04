"use strict"

console.log('> Перебор .keys(a).forEach')
var a = {
  "asd": 1,
  "zxc": 2
}
Object.keys(a).forEach(key => {
  let value = a[key]
  console.log('key: ', key)
  console.log('value: ', value)
})
// exit

console.log('> Перебор for in')
var a = {
  "asd": 1,
  "zxc": 2
}
for (let key in a) {
  let value = a[key]
  console.log('key: ', key)
  console.log('value: ', value)
}
// exit

console.log('> Перебор for of Object.entries')
var a = {
  "asd": 1,
  "zxc": 2
}
let k, v; for ([k, v] of Object.entries(a)) {
  console.log('k: ', k)
  console.log('v: ', v)
}
