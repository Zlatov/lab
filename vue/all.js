// 
// template
// 

// v-if
// v-else
// v-show
// v-show не работает на элементе <template> и не работает с v-else.
'<div v-if="!is_data_error">' // Создает DOM только в случае истины.
'</div>'
`<div v-else-if="type === 'B'">`
`</div>`
'<div v-else>' // Аналогично
'</div>'
'<div v-show="fields.some.is_editable"></div>' // Дом создаёт всегда и переключает CSS-свойство display.
'</div>'


// События
// v-on сокращение: @
'<button v-on:click="counter += 1">+1</button>' // Код обработки события тут-же.
'<button v-on:click="greet">Поприветствовать</button>' // Код обработки выенсен в обработчик.
'<button v-on:click="say(\'hi\')">Скажи hi</button>' // Передача данных в обработчик.
'<button v-on:click="warn(3, $event)">Отправить</button>' // Доступ к оригинальному событию.
// Модификаторы событий
'<a v-on:click.stop="doThis"></a>' // Не будет всплывать дальше.
'<form v-on:submit.prevent="onSubmit"></form>' // Больше не будет перезагружать страницу.
'<a v-on:click.stop.prevent="doThat"></a>' // Модификаторы можно объединять в цепочки
'<form v-on:submit.prevent></form>' // и использовать без указания метода-обработчика.
'<div v-on:click.capture="doThis">...</div>' // Событие, нацеленное на внутренний элемент, обрабатывается здесь.
'<div v-on:click.self="doThat">...</div>' // Вызов обработчика только в случае наступления события непосредственно на данном элементе.
// Коды клавиш
'<input v-on:keyup.enter="submit">'
'<input v-on:keyup.13="submit">'
// @keyup.enter
// @keyup.tab
// @keyup.delete (ловит как «Delete», так и «Backspace»)
// @keyup.esc
// @keyup.space
// @keyup.up
// @keyup.down
// @keyup.left
// @keyup.right
Vue.config.keyCodes.f1 = 112 // позволит использовать `@keyup.f1`
// @keyup.ctrl
// @keyup.alt
// @keyup.shift
// @keyup.meta
'<input @keyup.alt.67="clear">' // Alt + C
'<div @click.ctrl="doSomething">Сделать что-нибудь</div>' // Ctrl + Click
'<button @click.ctrl.exact="onCtrlClick">A</button>' // Сработает, только когда нажат Ctrl и не нажаты никакие другие клавиши.

// CSS классы
`
<div
  class="static"
  v-bind:class="{ active: isActive, 'text-danger': hasError }"
></div>
`
// или определить этот хэш с помощью вычисляемых данных
`
<div
  :class="computedVariable"
></div>
`
computed: {
  computedVariable: function() {
    return {
      'class-name': this.is_active
    }
  },
}
