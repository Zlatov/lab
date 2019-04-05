"use strict"

import Menu from "./modules/menu/menu"

if (NODE_ENV == "development") {
  console.log('> common')
}

$(document).ready(function() {
  let menu = new Menu({
    place: "#menu",
    list: [
      {
        text: "asd1",
        href: "",
      },
      {
        text: "asd2",
        href: "",
      },
      {
        text: "asd3",
        href: "",
      },
      {
        text: "asd4",
        href: "",
      }
    ],
  })
});

export {Menu}
