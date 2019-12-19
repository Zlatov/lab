import $ from "jquery"
global.$ = $
global.jQuery = $

import "ilorem"

import "./jquery.fias.min.js"

// Изоляция
;(function($) {
  "use strict"

  $.fias.token = 'fDf3iiQsQA3hsaA74y9K39FQAKDDiy3e';
  $.fias.url = 'https://kladr-api.ru/api.php';

  $(document).ready(function() {
    var input = $("#address").fias({oneString: true})
  });

})(jQuery);
