function Users() {
}

Users.get_list = function(query, process, asyncProcess) {
  $.ajax({
    url: '/packs/json/users.json',
    type: 'get',
    dataType: 'json',
    cache: false,
    async: true,
    dataType: 'json',
    timeout: 3000
  }).done(function(data) {
    console.log('data.options: ', data.options)
    asyncProcess(data.options)
  })
}

Users.get_labaled_list = function(query, process, asyncProcess) {
  $.ajax({
    url: '/packs/json/labeled_users.json',
    type: 'get',
    dataType: 'json',
    cache: false,
    async: true,
    dataType: 'json',
    timeout: 3000
  }).done(function(data) {
    console.log('data.options: ', data.options)
    asyncProcess(data.options)
  })
}

export default Users
