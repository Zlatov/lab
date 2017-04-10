$(document).ready(function(){

  $("#some").on('click', function(event) {
    console.log($(this).data())
  })

  var data = $("#some").data()
  console.log(data)

  data['zx'] = true
  console.log(data)


  var list = ['1','2']
  console.log(list)
  list.forEach(function(l,i) {
    console.log(l)
  })

  var li = $('li').toArray()
  console.log(li)
  li.forEach(function(l,i) {
    console.log(l)
  })

})
