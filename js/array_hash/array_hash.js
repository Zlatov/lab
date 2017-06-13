a = {a:1,b:2,c:3}
b = {a:1,b:3,d:4}
console.log('a.a: ', a.a)
console.log('a["a"]: ', a["a"])
console.log('a.z: ', a.z)
console.log('a["z"]: ', a["z"])
d = {}
ab = Object.assign({},a,b)
ad = Object.assign({},a,d)
da = Object.assign({},d,a)

console.log('ab: ', ab)
console.log('ad: ', ad)
console.log('da: ', da)

for (var key in b) {
  console.log(b[key])
}