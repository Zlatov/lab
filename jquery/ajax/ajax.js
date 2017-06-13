$.ajax({
  type: 'GET',
  url: 'https://sign-forum.ru/api/v1/api.php?action=getLastPosts',
  async: true,
  dataType: 'json',
  cache: false,
  beforeSend: function() {
  },
  error: function(jqXHR, textStatus, errorThrown) {
  },
  success: function(data){
    console.log(data)
  }
})
