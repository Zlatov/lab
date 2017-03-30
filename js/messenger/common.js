Informer.get_instance('place')

setTimeout(()=>{
  Informer.get_instance('place').print('Message 0')
},1500)
setTimeout(()=>{
  Informer.get_instance('place').print('Message 1', 'success')
},3000)
setTimeout(()=>{
  Informer.get_instance('place').print('Message 2', {show_time:null})
},4500)

setTimeout(()=>{
  Informer.get_instance('place').print('My message.')
},6000)
setTimeout(()=>{
  Informer.get_instance('place').print('No value.', 'warning')
},7500)
setTimeout(()=>{
  Informer.get_instance('place').print('Error!', {type:'danger', show_time: null})
},9000)
