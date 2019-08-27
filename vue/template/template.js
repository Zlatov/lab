;(function() {


"use strict"

window.Vue.component("UserInfo", {
  data: function() {
    return {
      account: window.vue.application.app.data.account,
    }
  },

  template: `
    <div class="user-info">
      <li v-for="item in items">
        {{ item.message }}
      </li>
      <li v-for="(item, index) in items">
        {{ parentMessage }} - {{ index }} - {{ item.message }}
      </li>
      <div v-for="(value, name) in object">
        {{ name }}: {{ value }}
      </div>
    </div>
  `

})


})();
