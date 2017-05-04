$(document).ready(function(){

  $(".copyToClipboard").after(' <span class="btn btn-default btn-xs copyToClipboardBtn"><i class="fa fa-clipboard" aria-hidden="true"></i></span>')

  $('body').on('click', ".copyToClipboardBtn", function(event){
    var wrapper = $(this).prev().eq(0)
    if (wrapper.length) {
      wrapper = wrapper[0]
      var is_input = wrapper.tagName === "INPUT" || wrapper.tagName === "TEXTAREA"
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
      if (is_input) {
        temp.textContent = wrapper.value
      } else {
        temp.textContent = wrapper.textContent
      }
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
    }
  })

})
