  // Копирование Skype в буфер
  $('.profile-contact').on('click', 'a[data-skype]', function(event) {
    var a = $(this)
    var skype = a.data('skype')
    if (!skype) {
      return
    }
    console.log(skype)
    var temp_id = 'hiddenCopyToClipboard'
    var temp = document.getElementById(temp_id)
    if (temp == null) {
      var temp = document.createElement("textarea")
      temp.style.position = "absolute"
      temp.style.left = "-9999px"
      temp.style.top = "0"
      temp.id = temp_id
      document.body.appendChild(temp)
    }
    temp.textContent = skype
    var x = window.scrollX,
      y = window.scrollY
    temp.focus()
    window.scrollTo(x, y)
    temp.setSelectionRange(0, temp.value.length)
    var done
    try {
      done = document.execCommand("copy")
    } catch(e) {
      done = false
    }
    if (done) {
      alert('Идентификатор Skype скопирован в буфер обмена.')
    }
  })