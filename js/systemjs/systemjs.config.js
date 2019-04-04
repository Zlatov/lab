;(function() {

  "use strict"

  SystemJS.config({
    // Для удобаства указываем сокращения путей (чот мне не удобно)
    paths: {
      "npm:": "../../node_modules/",
      "src:": "./"
    },
    // Пути всех библиотек необходимо знать заранее, удобно: require("jquery")...:
    map: {
      app: "src:app.js",
      jquery: "npm:jquery/dist/jquery.min.js",
    }
  })

})();
