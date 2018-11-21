;(function() {

"use strict"

// window.Vue.component("NumberCorrector", {
window.NumberCorrector = {
  props: {
    count: Number,
    // артикул можно было не передавать, но можно
    articul: String
  },
  data: function() {
    return {}
  },
  template: `
    <div class="number-corrector">
      {{ articul }}
      <!-- тут вызываем события родительского компонента "m" -->
      <span class="m" @click="$emit('m')"></span>
      <input type="text" name="count" v-bind:value="count">
      <!-- тут вызываем события родительского компонента "m" с параметром -->
      <span class="p" @click="$emit('p', articul)"></span>
    </div>
  `
// })
}

})();
