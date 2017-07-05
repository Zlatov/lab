console.log('"asdf".match(/s/gim): ', "asdf".match(/s/gim))
console.log('/s/gim.test("asd"): ', /s/gim.test("asd"))
console.log('/f/gim.test("asd"): ', /f/gim.test("asd"))
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
