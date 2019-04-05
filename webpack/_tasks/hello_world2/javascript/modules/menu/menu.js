"use strict"

import "./menu.css"

function Menu(data={}) {
  this.html = '<ul class="menu">'
  this.items = data.list
  this.selector = data.place
  for (let i = 0, l = this.items.length; i < l; i++) {
    let item = this.items[i]
    this.html += "<li><a href='" + item.href + "'>" + item.text + "</a></li>"
  }
  this.html += '</ul>'
  this.place = $(this.selector)
  console.log('this.selector: ', this.selector)
  console.log('this.place.length: ', this.place.length)
  if (this.place.length == 1) {
    this.place.empty()
    this.place.append(this.html)
  }
}

export default Menu
