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
