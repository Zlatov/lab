;(function() {

"use strict"

window.Vue.component("CountCorrector", {

  props: {
    count: Number,
    index: [Number, Object],
    disabled: Boolean
  },

  data: function() {
    return {
      count_i: this.count.toString(),
      mutated_index: this.index,
      mutated_count: this.count,
      is_count_updated_by_props: false,
    }
  },

  computed: {
  },

  watch: {
    '$route.fullPath': {
      handler: function(new_value, old_value) {
        this.person_id = this.$_calc_person_id()
      },
      deep: true
    },
    count_i: function(val, old_val) {
      // Чистим значение
      var ret = val.replace(/[^0-9.,]/gi, '')
      ret = ret.replace(/,/g, '.')
      var ret_a = ret.split('.')
      ret = (ret_a.length > 2) ? ret_a.slice(0, 2).join('.') : ret
      // Устанавливаем для отображения чистое значение
      this.count_i = ret

      // Если изменения были не от пользователя, а от данных, то не будем
      if (this.is_count_updated_by_props) {
        this.is_count_updated_by_props = false
        return null
      }

      // вызываем событие по изменению данных пользователем
      var ret_n = parseFloat(ret)
      this.mutated_count = isNaN(ret_n) ? 0 : ret_n
      this.$emit('cc_i', this.mutated_count, this.mutated_index)
    },
    count: function(val, old_val) {
      this.is_count_updated_by_props = true
      this.count_i = val.toString()
    },
  },
  template: `
    <div class="count-corrector">
      <span class="m" @click="$emit('cc_m')"></span>
      <input type="text" name="count" v-model="count_i" :disabled="disabled == true">
      <span class="p" @click="$emit('cc_p')"></span>
    </div>
  `,
})

})();
