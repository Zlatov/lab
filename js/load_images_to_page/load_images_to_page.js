$(document).ready(()=>{
  function preview_images(event) {
    var files = this.files;
    var preview_div     = $('#js_preview_div');
    readers = []
    if (files.length) {
      for (var i = 0; i < files.length; i++) {
        var file = files[i]
        var reader  = new FileReader()
        var img = $("<img>")

        img[0].onload = function(){
          var img = $(this);
          var minImgWidht = 250;
          var minImgHeight = 300;
          var maxPrevieWidth = 600;
          var maxPrevieHeight = 300;
          var maxk = maxPrevieWidth/maxPrevieHeight;
          var imgWidth = this.naturalWidth;
          var imgHeight = this.naturalHeight;
          var imgk = imgWidth/imgHeight;
          if (imgk > maxk) {
            // ограничивать по ширине
            var previeWidth = maxPrevieWidth;
            var k = previeWidth/imgWidth;
            var previeHeight = Math.floor(k*imgHeight);
          } else {
            // ограничивать по высоте
            var previeHeight = maxPrevieHeight;
            var k = previeHeight/imgHeight;
            var previeWidth = Math.floor(k*imgWidth);
          }
          var minAreaWidth = Math.ceil(k*minImgWidht);
          var minAreaHeight = Math.ceil(k*minImgHeight);
          img.width(previeWidth);
          img.height(previeHeight);
        }
        
        reader.onloadend = function(){
          img.appendTo(preview_div)
          img[0].src=reader.result
        }

        reader.readAsDataURL(file)
      }
    } else {
      preview_div.html('')
      preview_div.slideUp();
    }
  }
  $('#js_form').on('change', '#js_input_images', preview_images);
})
