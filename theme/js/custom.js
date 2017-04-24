$(document).ready(function(){
  function eval_js(tag) {
    // var code = this.innerHTML
    var code = tag.textContent || tag.innerText || ''
    // console.log(tag)
    // console.log(code)
    // var c = confirm('Выполнить?')?true:false;
    // if (c) {
      eval(code)
    // }
  }
  $('.eval_js').on('dblclick', function(event) {
    eval_js(this)
  })
});