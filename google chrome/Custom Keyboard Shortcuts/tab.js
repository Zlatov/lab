;(function() {

  "use strict"

  console.log('> Shortkyes Tab!')

  window.google_tabulation = {
    options: {
      result_list_item_selector: "div.rc", // element with css style "position: relative"
    },
    selected_element_index: 0
  }

  function scroll_to_element(element) {
    var rect = element.getBoundingClientRect()
    if (!(rect.top >= 0 && rect.bottom <= window.innerHeight)) {
      window.scrollTo(0, rect.top + window.pageYOffset - (window.innerHeight / 2))
    }
  }

  function select_element(index) {
    var elements = window.document.querySelectorAll(window.google_tabulation.options.result_list_item_selector)
    if (elements.length == 0) {
      console.log('> google_tabulation: no elements.')
      return null
    }
    if (index < 0 || index >= elements.length) {
      console.log('> google_tabulation: this is end of the list.')
      return null
    }
    var result_pointer = document.getElementById("result-pointer")
    if (result_pointer != null) {
      result_pointer.remove()
    }
    var element = elements[index]
    element.innerHTML = '<div id="result-pointer" style="position:absolute;left:-15px;">&gt;</div>' + element.innerHTML
    scroll_to_element(element)
    var link = element.querySelector('a')
    link.focus()
    window.google_tabulation.selected_element_index = index
  }

  document.onkeyup = function(event) {
    if(event.keyCode == 38) {
      console.log('> up')
      select_element(window.google_tabulation.selected_element_index - 1)
    }
    if(event.keyCode==40) {
      console.log('> down')
      select_element(window.google_tabulation.selected_element_index + 1)
    }
  }

  select_element(0)

})();
