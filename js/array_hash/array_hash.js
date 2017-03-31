a = {a:1,b:2,c:3}
b = {a:1,b:3,d:4}
d = {}
ab = Object.assign({},a,b)
ad = Object.assign({},a,d)
da = Object.assign({},d,a)

console.log('ab: ', ab)
console.log('ad: ', ad)
console.log('da: ', da)

