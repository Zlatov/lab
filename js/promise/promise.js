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
