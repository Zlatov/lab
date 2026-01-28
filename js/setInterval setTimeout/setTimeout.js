"use strict"

// Синтаксис:
// var timerId = setTimeout(func / code, delay[, arg1, arg2...])

console.log('> Старт')

function func() {
  console.log('> Привет')
}

function func2(phrase, who) {
  console.log(phrase + ', ' + who)
}

var a = setTimeout(func, 1000)
console.log('a: ', a)
var b = setTimeout(func2, 2000, "Привет", "Василий")
console.log('b: ', b)

return null




var timerId = setTimeout(function() { alert(1) }, 1000)
// timerId - идентификатор таймера, (передаётся как "число", не ссылкой, а значением?).
console.log('timerId: ', timerId)

clearTimeout(timerId);
// всё ещё число, оно не обнуляется после отмены
console.log('timerId: ', timerId)


// Функция event_listener - запускается множество раз. Функцию console.log
// необходимо запустить 1 раз, если была пауза между запусками event_listener в
// 2000 мс.
function event_listener(event, data) {
  // Идентификатор setTimeout необходимо хранить в объекте, на крайний случай глобально:
  if (window.run_search_timeout_id != null) {
    clearTimeout(window.run_search_timeout_id)
  }
  window.run_search_timeout_id = setTimeout(function() {
    console.log('> Это необходимо запустить 1 раз')
  }, 2000)
}




  // Антиповторитель на основе underscore. На примере jstree.
  // 
  // Необходимо предотвратить множественный запуск jstree_column(data) при
  // повторяющихся срабатываниях различных событий.
  $(".alternative_tree").jstree({
    core: {
      operations: {
        jstree_column_debounced: _.debounce(function(data) {
          jstree_column(data)
        }, 300),
      }
    }
  }).on("loaded.jstree refresh.jstree open_node.jstree load_node.jstree rename_node.jstree", function(event, data) {
    var tree = data.instance
    tree.settings.operations.jstree_column_debounced(data)
  })




  // «Антиповторитель с накапливанием значений» или «Пакетирование» на основе
  // underscore. На примере jstree.
  // 
  // Функция create_alternatives должна запуститься 1 раз если появилась пауза в
  // 500 мс между запусками событий copy_node.jstree.
  // 
  // Причем данные от каждого события необходимо накопить не в глобальной
  // переменной, а аккуратней - в переменной alternative_ids внутри замыкания.
  $(".alternative_tree").jstree({
    operations: {
      create_alternatives_debounced: (function() {
        var alternative_ids = []
        var debounced = _.debounce(function() {
          var tree = this
          var data = alternative_ids
          alternative_ids = []
          tree.settings.operations.create_alternatives.call(tree, data)
        }, 500)

        return function(alternative_id) {
          alternative_ids.push(alternative_id)
          debounced.call(this)
        }
      })(),
      create_alternatives: function(alternative_ids) {
        var tree = this
        $.ajax({
        }).done(function(data, textStatus, jqXHR) {
        })
      },
    }
  }).on("copy_node.jstree", function(event, data) {
    var tree = data.instance
    var parent_node = tree.get_node(data.parent)

    // Копирование из вспомогательного дерева
    if (data.old_instance?.element?.hasClass("alternative_bit_tree")) {
      var copied_node = data.original
      // Копировали Аналог в Товар
      if (copied_node.type == "product" && parent_node.type == "product") {
        // Пакетирование
        tree.settings.operations.create_alternatives_debounced.call(tree, {
          product_id: parent_node.data.id,
          alternative_id: copied_node.data.id
        })
      }
    }
  })
