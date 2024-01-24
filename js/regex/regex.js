// 
// Синтаксис
// 
// /pattern/flags
// или
// new RegExp(pattern[, flags])
// 
// 
// Параметры
// 
// pattern — текст регулярного выражения.
// flags — если определён, может принимать любую комбинацию нижеследующих значений:
//   g — глобальное сопоставление
//   i — игнорирование регистра при сопоставлении
//   m — сопоставление по нескольким строкам; 
//       символы начала и конца (^ и $) начинают работать по нескольким строкам.
// 

console.log('"asdf".match(/s/gim): ', "asdf".match(/s/gim))
console.log('/s/gim.test("asd"): ', /s/gim.test("asd"))
console.log('/f/gim.test("asd"): ', /f/gim.test("asd"))
console.log('12-34-56'.replace("-", ":"))
console.log('12-34-56'.replace(/-/, ":"))
console.log('12-34-56'.replace(/-/g, ":"))
console.log('01234567,8a.sd90.,q('.replace(/[^0-9.,]/gi, ''))
console.log('01234567,8a.sd90.,q('.replace(/,/g, '.'))
// return null

console.log('> Регулярка проверки артикула')
var regexp = /\d{9}/
console.log('regexp.test("123456789"): ', regexp.test("123456789"))
console.log('regexp.test("12345678"): ', regexp.test("12345678"))

console.log('> Регулярка проверки НОВОГО артикула')
var regexp = /^[\d-]{8,12}$/
var a = regexp.test("111222333")
var b = regexp.test("11111111111111111")
console.log('a: ', a)
console.log('b: ', b)
// return null

var versions = [
  '.',
  'a',
  '0',
  '1',
  '103',
  '..',
  'a.',
  '0.',
  '1.',
  '103.',
  '.a',
  '.0',
  '.1',
  '.103',
  'a.a',
  '0.0',
  '1.1',
  'a.a.a',

  '0.0.0',
  '1.1.1',
  '103.103.103',
]
for(var i=0, l=versions.length; i<l; i++) {
  console.log(versions[i], /^[0-9]+\.[0-9]+\.[0-9]+$/gi.test(versions[i]))
}
