;(function() {

"use strict"

window.test = function() {
  window.test_app()
  window.test_basket()
}

window.test_app = function() {
}

window.test_basket = function() {
  function set() {
    window.Vue.set(window.app.basket, 0, {img:"64-64-nature.jpg",name:"xxxxxx"})
    window.app.$set(window.app.basket, 1, {img:"64-64-nature.jpg",name:"zzzzzzzz"} )
  }
  function set2() {
    window.Vue.set(window.app.basket, 0, {img:"64-64-nature.jpg",name:"222"})
    window.app.basket.splice(1)
  }
  function set3() {
    window.app.basket.splice(0)
    window.app.$set(window.app.basket, 0, {img:"64-64-nature.jpg",name:"100000000"})
  }
  function set4() {
    window.app.basket_new_data([
      {
        articul:      "000012345",
        img:          "854-480-autumn-colorful.jpg",
        name:         "del",
        price:        123.23,
        amount_count: 1.2,
        order_count:  2.0,
        count:        3,
        total_price:  333
      },
      {
        img:          "854-480-headlights-lamborghini.jpg",
        name:         "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ipsam dignissimos explicabo facere architecto nam fugiat odit, saepe, labore harum repudiandae necessitatibus enim quisquam aut recusandae id fuga repellendus doloribus sapiente!",
        price:        12300000000000000000000000000000000000000000000000000000000.23,
        amount_count: 100000000000000000000000000000000000000000000000000000000.2,
        order_count:  200000000000000000000000000000000000000000000000000000.0,
        count:        333333333333333333333333333333333333333333333333333333333,
        total_price:  333333333333333333333333333333333333333333333333333333333333333333
      }
    ])
  }
  function set5() {
    window.app.$refs.basketList.new_data([
      {
        articul:      "000012345",
        img:          "854-480-headlights-lamborghini.jpg",
        name:         "del",
        price:        123.23,
        amount_count: 1.2,
        order_count:  2.0,
        count:        3,
        total_price:  333
      },
      {
        articul:      "000012346",
        img:          "854-480-autumn-colorful.jpg",
        name:         "Lorem ipsum dolor sit amet, consectetur adipisicing elit.",
        price:        123.23,
        amount_count: 100.2,
        order_count:  200.0,
        count:        333,
        total_price:  333
      }
    ])
  }
  setTimeout(set,  1000)
  setTimeout(set2, 2000)
  setTimeout(set3, 3000)
  setTimeout(set4, 4000)
  setTimeout(set5, 5000)
}

})();
