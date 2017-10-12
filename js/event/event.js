var event_click_lorem = new Event('click_lorem')
// var event_click_lorem = new Event('click_lorem', {bubbles:true, cancelable:false})
// var event_click_lorem = new CustomEvent('click_lorem', {bubbles:true, cancelable:false})
console.log('event_click_lorem: ', event_click_lorem)

var lorem = document.getElementsByTagName('div')[0]
console.log('lorem: ', lorem)

lorem.addEventListener('click', function(event) {
  console.log('this: ', this)
  if ((this.innerHTML.trim()) == '') {
    console.log('> empty')
  } else {
    console.log('> not empty')
    this.dispatchEvent(window.event_click_lorem)
  }
})

lorem.addEventListener('click_lorem', function(event) {
  console.log('event click_lorem: ', event)
  return false;
})
