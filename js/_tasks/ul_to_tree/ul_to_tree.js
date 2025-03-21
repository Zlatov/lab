$(document).ready(function() {

  $(".ul_to_tree.ul_to_tree-dropdown").on("click", "li", function(event) {
    event.stopPropagation()
    // console.log('event: ', event)
    // console.log('event.offsetX: ', event.offsetX)
    // console.log('event.offsetY: ', event.offsetY)
    // console.log('$(this).offsetWidth: ', $(this).offsetWidth)
    // if ($(this).nextAll("ul").css('display')=='none') {
    //   $(this).nextAll("ul").slideDown(400)
    //   $(this).css({'background-position':"-11px 0"})
    // } else {
    //   $(this).nextAll("ul").slideUp(400)
    //   $(this).css({'background-position':"0 0"})
    // }
    if (event.offsetX >= -6 && event.offsetX <= 5 && event.offsetY >= 5 && event.offsetY <= 16 ) {
      var li = $(this)
      var elBlock = li.find(">ul")[0]
      if (elBlock.style.height === "0px") {
        elBlock.style.height = `${elBlock.scrollHeight}px`
      } else {
        elBlock.style.height = `${elBlock.scrollHeight}px`
        window.getComputedStyle(elBlock, null).getPropertyValue("height")
        elBlock.style.height = "0"
      }
      li.toggleClass("close")
    }
  })

  $(".ul_to_tree.ul_to_tree-dropdown ul").on("transitionend", function(event) {
    var elBlock = $(this)[0]
    if (elBlock.style.height !== "0px") {
      elBlock.style.height = "auto"
    }
  })

  // elToggle.addEventListener("click", () => {
  //   if (elBlock.style.height === "0px") {
  //     elBlock.style.height = `${ elBlock.scrollHeight }px`
  //   } else {
  //     elBlock.style.height = `${ elBlock.scrollHeight }px`
  //     window.getComputedStyle(elBlock, null).getPropertyValue("height")
  //     elBlock.style.height = "0"
  //   }
  // })

  // elBlock.addEventListener("transitionend", () => {
  //   if (elBlock.style.height !== "0px") {
  //     elBlock.style.height = "auto"
  //   }
  // });

  // $(".ul-dropfree").find("ul").slideUp(400).parents("li").children("div.drop").css({'background-position':"0 0"})

})
