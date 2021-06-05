import $ from "jquery"
global.$ = $
global.jQuery = $

import "bootstrap"

import "jquery-ui/ui/widgets/tooltip"
import "jquery-ui/themes/base/base.css"

import "ilorem"

import "holderjs"

import "./sass.scss"

// Импорт изображений
import "./images/logo.svg"
import "./images/favicon.svg"

$(document).ready(function() {
  $(".text-tooltip").tooltip({
    tooltipClass: "custom-tooltip-styling",
    my: "center top",
    at: "center bottom"
  })
});
