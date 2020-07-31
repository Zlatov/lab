// В хроме работает и так и так, а вот в FF не срабатывает.
function logout() {
  $.ajax({
    type: "GET",
    url: "/",
    async: false,
    username: "logmeout",
    password: "123456",
    headers: { "Authorization": "Basic xxx" }
    // beforeSend: function (jqXHR, settings) {
    //   jqXHR.setRequestHeader("Authorization", "Basic " + btoa("logmeout:123456"))
    // }
  })
  .done(function(data) {
    console.log('data: ', data)
  })
  .fail(function(error) {
    console.log('error: ', error)
    window.location = "/"
  });
  return false
}
