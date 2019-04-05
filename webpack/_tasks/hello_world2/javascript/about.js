"use strict"

import welcome from "./modules/welcome"
// import $ from 'jquery/dist/jquery.min';

$(document).ready(function() {
  console.log('$("body").length: ', $("body").length)
});

welcome("app.js app")

export {welcome}
