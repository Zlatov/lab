window.wysiwyg = {}

window.wysiwyg.activate = function() {
  this.activate_tinyMCE()
}

window.wysiwyg.activate_tinyMCE = function() {
  var tinyMCE_instances = window.tinyMCE.get()
  for (var i=0, l=tinyMCE_instances.length; i<l; i++) {
    tinyMCE_instances[i].remove()
  }
  window.tinyMCE.init({
    selector: 'textarea',
    language: 'ru',
    theme: 'modern',
    height: window.config.textarea.height,
    // plugins: 'fullpage', - плагин который фигачит доктайп в текстарею
    plugins: 'print preview searchreplace autolink directionality visualblocks visualchars fullscreen image link media template codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists textcolor wordcount imagetools contextmenu colorpicker textpattern code',
    toolbar1: 'formatselect | bold italic strikethrough forecolor backcolor | link | alignleft aligncenter alignright alignjustify  | numlist bullist outdent indent  | removeformat | code',
    relative_urls: false,
    image_advtab: true,
    code_dialog_width: 1240,
    menubar: 'edit insert view format table tools',
  })
}



;(function(){
  "use strict"

  window.object.wysiwyg = {}

  window.object.wysiwyg.activate = function() {
    this.activate_tinyMCE()
  }

  window.object.wysiwyg.activate_tinyMCE = function() {
    var tinyMCE_instances = window.tinyMCE.get()
    for (var i=0, l=tinyMCE_instances.length; i<l; i++) {
      tinyMCE_instances[i].remove()
    }
    window.tinyMCE.init(this.options.tinyMCE)
  }

  window.object.wysiwyg.options = {
    tinyMCE: {
      selector: 'textarea.tinymce',
      language: 'ru',
      theme: 'modern',
      height: 400,
      // plugins-: 'fullpage',
      plugins: 'print preview searchreplace autolink directionality visualblocks visualchars fullscreen image link media template codesample table charmap hr pagebreak nonbreaking anchor toc insertdatetime advlist lists textcolor wordcount imagetools contextmenu colorpicker textpattern code',
      toolbar1: 'formatselect | bold italic strikethrough forecolor backcolor | link | alignleft aligncenter alignright alignjustify  | numlist bullist outdent indent  | removeformat | code',
      relative_urls: false,
      image_advtab: true,
      code_dialog_width: 1240,
      menubar: 'edit insert view format table tools',
    }
  }

})();

