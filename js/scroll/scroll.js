
// Можно так
tabs_discounts_button = $("...")
window.scrollTo({
  top: tabs_discounts_button.offset().top,
  // left: ...,
  behavior: "smooth"
})

// Можно так
window.scrollTo(window.pageXOffset, header.offset().top)

// В JQ тоже есть
$("div.content").scrollTop() // возвратит величину вертикального скроллинга
$("div.content").scrollLeft(30) // устанавливает величину горизонтального скроллинга у всех div-элементов с классом content равной 30.
