;(function($) {

"use strict"

window.Vue.component('basket-list', {
  data: function() {
    return {
      basket: window.app.basket
    }
  },
  template: `
    <div class="basket-list">
      <table>
        <caption>Корзина</caption>
        <thead>
          <tr>
            <th></th>
            <th>Наименование товара</th>
            <th>Цена</th>
            <th>В наличии</th>
            <th>Под заказ</th>
            <th>Количество</th>
            <th>Итого</th>
            <th><span class="remove_all" v-on:click="remove_all">Очистить корзину</span></th>
          </tr>
        </thead>
        <tbody class="list">
          <tr v-for="tovar in basket" v-bind:data-articul="tovar.articul" class="item">
            <td><div class="img" v-bind:style="tovarStyle(tovar.img)"></div></td>
            <td><a v-bind:href="href(tovar.articul)">{{ tovar.name }}</a> <span>#{{ tovar.articul }}</span></td>
            <td>{{ tovar.price }}</td>
            <td>{{ tovar.amount_count }}</td>
            <td>{{ tovar.order_count }}</td>
            <td>{{ tovar.count }}</td>
            <td>{{ tovar.total_price }}</td>
            <td><span class="remove" v-on:click="remove"></span></td>
          </tr>
        </tbody>
      </table>
    </div>
  `,
  methods: {
    tovarStyle: function(img) {
      return (img != null) ? "background-image:url(/theme/images/" + img + ")" : ""
    },
    new_data: function(data) {
      this.basket.splice(0)
      for (var i = 0, l = data.length; i < l; i++) {
        var item = data[i]
        this.basket.push(item)
      }
    },
    href: function(articul) {
      return "/cat/" + articul
    },
    remove: function(event) {
      console.log('this: ', this)
      // console.log('event: ', event)
      // console.log('$: ', $)
      var button = $(event.target)
      // console.log('button: ', button)
      // console.log('button.length: ', button.length)
      var item = button.parentsUntil(".basket-list").filter(".item")
      if (item.length != 1)
        throw new Error("DOM корзины некорректен.")
      // console.log('item: ', item)
      var articul = item.data("articul")
      if (articul == null)
        throw new Error("Не найден артикул итема.")
      console.log('articul1: ', articul)
      // this.$parent.basket_remove_item(articul)
      for(var i = 0; i < this.basket.length; i++) {
        console.log('i: ', i)
        console.log('this.basket.length: ', this.basket.length)
        if (this.basket[i].articul == articul) {
          this.basket.splice(i, 1)
          i--
        }
      }
    },
    remove_all: function() {
      console.log('this: ', this)
      this.basket.splice(0)
    }
  }
})


})(jQuery);
