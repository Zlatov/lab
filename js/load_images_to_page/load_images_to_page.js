$(document).ready(()=>{

  // Обработчик изменения содержимого input type file
  var preview_images = function() {
    var files = this.files
    var div = $('#js_preview_div')
    div.html('')
    if (files.length) {
      // Один реадер для чтения всех файлов,
      // множество реадеров - не дает множественную обработку загрузки
      // (загружает только первое изображение на относительно слабых компах)
      var reader  = new FileReader()
      // счётчик обработанных файлов
      reader.fileindex = 0
      // рекурсивная функция
      function readFiles() {
        if (files.length > reader.fileindex) {
          var img = $("<img>")
          var file = files[reader.fileindex]
          reader.fileindex = reader.fileindex + 1
          reader.onloadend = function(loadEvent) {
            // что происходит когда в реадер поступила инфа
            img.appendTo(div)
            img[0].onload = function(){
              var img = $(this);
              var maxPrevieWidth = 100;
              var maxPrevieHeight = 100;
              var maxk = maxPrevieWidth/maxPrevieHeight
              var imgWidth = this.naturalWidth
              var imgHeight = this.naturalHeight
              var imgk = imgWidth/imgHeight
              if (imgk > maxk) {
                // ограничивать по ширине
                var previeWidth = maxPrevieWidth
                var k = previeWidth/imgWidth
                var previeHeight = Math.floor(k*imgHeight)
              } else {
                // ограничивать по высоте
                var previeHeight = maxPrevieHeight
                var k = previeHeight/imgHeight
                var previeWidth = Math.floor(k*imgWidth)
              }
              img.width(previeWidth)
              img.height(previeHeight)
            }
            img[0].src=reader.result
            readFiles()
          }
          reader.readAsDataURL(file)
        } else {
          // finishedReadingFiles() // no more files to read
        }
      }
      readFiles()
      div.slideDown()
    } else {
      div.html('')
      div.slideUp()
    }
  }

  $('#js_form').on('change', '#js_input_images', preview_images)

})
