;(function() {

"use strict"

window.Vue.component("NumberCorrector", {
  props: {
    count: Number
  },
  data: function() {
    return {}
  },
  template: `
    <div class="number-corrector">
      <span class="m"></span>
      <input type="text" name="count" v-bind:value="count">
      <span class="p"></span>
    </div>
  `,
  methods: {
  }
})

})();
