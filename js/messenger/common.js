Informer.get_instance('place')

setTimeout(()=>{
  Informer.get_instance('place').print('Message 0')
},150)
setTimeout(()=>{
  Informer.get_instance('place').print('Message 1', 'success')
},300)
setTimeout(()=>{
  Informer.get_instance('place').print('Message 2', {show_time:null})
},450)

setTimeout(()=>{
  Informer.get_instance('place').print('My message.')
},600)
setTimeout(()=>{
  Informer.get_instance('place').print('No value.', 'warning')
},750)
setTimeout(()=>{
  Informer.get_instance('place').print('Error!', {type:'danger', show_time: null})
},900)

setTimeout(()=>{
  Informer.get_instance('place2', {print: ['fly left'],show_time: null}).print('No type.')
},600)
setTimeout(()=>{
  Informer.get_instance('place2').print('info','info')
},750)
setTimeout(()=>{
  Informer.get_instance('place2').print('success', 'success')
},900)
setTimeout(()=>{
  Informer.get_instance('place2').print('warning', {type:'warning', })
},1050)
setTimeout(()=>{
  Informer.get_instance('place2').print('danger', {type:'danger', })
},1200)

setTimeout(()=>{
  Informer.get_instance('place-no-stack', {stack:false,print:null,show_time:0}).print('No type.')
},600)
setTimeout(()=>{
  Informer.get_instance('place-no-stack').print('info','info')
},750)
setTimeout(()=>{
  Informer.get_instance('place-no-stack').print('success', 'success')
},900)
setTimeout(()=>{
  Informer.get_instance('place-no-stack').print('warning', {type:'warning'})
},1050)
setTimeout(()=>{
  Informer.get_instance('place-no-stack').print('danger', {type:'danger'})
},1200)
