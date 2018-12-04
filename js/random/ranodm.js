// 
// Функция `Math.random()` возвращает число в интервале [0,1)
// 

console.log('> Вернуть целое число в интервале мин макс включительно')
var rand, min, max
min = 10
max = 11
// 
// Функция Math.floor() - округляет в меньшую сторону 1.9 в 1, -1.9 в -2
// 
rand = min + Math.floor((max - min + 1) * Math.random());
console.log('rand: ', rand)
// return null

console.log('> Вернуть случайный текст.')
var a = ["lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit", "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore", "magna", "aliqua", "ut", "enim", "ad", "minim", "veniam", "quis", "nostrud", "exercitation", "ullamco", "laboris", "nisi", "ut", "aliquip", "ex", "ea", "commodo", "consequat", "duis", "aute", "irure", "dolor", "in", "reprehenderit", "in", "voluptate", "velit", "esse", "cillum", "dolore", "eu", "fugiat", "nulla", "pariatur", "excepteur", "sint", "occaecat", "cupidatat", "non", "proident", "sunt", "in", "culpa", "qui", "officia", "deserunt", "mollit", "anim", "id", "est", "laborum"]
var b = [".", ".", "!", "?"]
var c = 100
var t = ""
var word
var capitalize = true
function random(min, max) {
  return min + Math.floor((max - min + 1) * Math.random())
}
function capitalizeFirstLetter(string) {
  return string.charAt(0).toUpperCase() + string.slice(1)
}
function probability(p) {
  return p != 0 && Math.random() <= p
}
for (var i = 0, l = c; i < l; i++) {
  if (i != 0) {
    if (probability(0.2)) {
      t+= ","
    } else if (probability(0.25)) {
      capitalize = true
      t+= b[random(0, b.length - 1)]
    }
    t+= " "
  }
  w = a[random(0, a.length - 1)]
  if (capitalize) {
    w = capitalizeFirstLetter(w)
    capitalize = false
  }
  t+= w
}
t+= b[random(0, b.length - 1)]

console.log('t: ', t)
