import $ from "jquery"
global.$ = $
global.jQuery = $

import "bootstrap"

import "ilorem"

import "holderjs"

import "./js/chart.js"

import "./sass.scss"

// Импорт изображений
import "./images/logo.svg"
import "./images/favicon.svg"

;(function($) {

  "use strict"

  $(document).ready(function() {

    window.chart.activate()
  });
})(jQuery);
