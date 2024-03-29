// 
// var promise = new Promise(function(resolve, reject) {
//   // resolve(результат) при успешном выполнении
//   // reject(ошибка) при ошибке
// })
// 
// promise.then(onFulfilled, onRejected)
// // onFulfilled – функция, которая будет вызвана с результатом при resolve.
// // onRejected – функция, которая будет вызвана с ошибкой при reject.
// 
// .catch()
// Для того, чтобы поставить обработчик только на ошибку, вместо .then(null, onRejected) можно написать .catch(onRejected) – это то же самое.
// 
// Синхронный throw – то же самое, что reject (Если в функции промиса происходит синхронный throw (или иная ошибка), то вызывается reject)
// 

var files = false

var save_data = new Promise(function(resolve, reject) {
  setTimeout(function() {
    resolve('save_data')
  }, 2000)
})

var save_files = new Promise(function(resolve, reject) {
  if (files) {
    setTimeout(function() {
      resolve('save_files')
    }, 1000)
  } else {
    resolve(true)
    // reject(false)
  }
})

var refresh_page = Promise.all([save_data, save_files]).then(function(resolve_data) {
  console.log('resolve_data: ', resolve_data)
}, function(reject_data) {
  console.log('reject_data: ', reject_data)
})
// 
// Promise.all(…).then(res,rej) — res выполнится тогда, когда будут выполнены все обещания,
// rej выполнится тогда, когда отклонено любое из переданных обещаний
// 
