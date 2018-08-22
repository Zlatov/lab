// 
// try..catch работает только в синхронном коде
// try..catch подразумевает, что код синтаксически верен
// 

try {
  // throw new Error("Данные некорректны");
  var a = 1/0;
  console.log('ыыы: ', a)
} catch(e) {
  console.log('e: ', e)
  // throw e; // пробрасываем
}

try {
  b
} catch(e) {
  // console.log('e: ', e)
  console.log('e.name: ', e.name)
  console.log('e.message: ', e.message)
  // console.log('e.stack: ', e.stack)
}

console.log('> Ошибка словлена.')
