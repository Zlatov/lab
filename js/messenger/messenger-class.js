/**
 * Информер
 * 
 * 
 * Инициализация
 * =============
 * some_informer = Informer.get_instance('place_id')
 * 
 * Инициализация со своими настройками:
 * some_informer = Informer.get_instance('place_id', {my_option:option, ...})
 * 
 * Доступ к информеру
 * ==================
 * применены патерны программирования: фабрика синглтонов, поэтому
 * возможно получить объект без инициализации:
 * Informer.get_instance('place_id')
 * 
 * i1 = Informer.get_instance('place_one')
 * i2 = Informer.get_instance('place_one')
 * 
 * i1 === i2 // true
 * 
 * Размещение сообщений
 * ====================
 * Informer.get_instance('place_id').print('My message.')
 * Informer.get_instance('place_id').print('No value.', 'warning')
 * Informer.get_instance('place_id').print('Error!', {type:danger, show_time: null})
 * 
 * Опции
 * =====
 * Эффект появления:
 * print: ['fly left', 'flash']
 * отключить (появится мгновенно): print: null
 *
 * Максимальное количество сообщений (ограничение стека)
 * max_count: 5
 * не ограничивать стек сообщений: max_count: 0
 *
 * Время до исчезновения сообщения
 * show_time: 5000
 * показывать постоянно: show_time: 0
 * 
 */

if (typeof(Array.prototype.in_array)==='undefined') {
  Array.prototype.in_array = function(p_val) {
    for(var i = 0, l = this.length; i < l; i++) {
      if(this[i] == p_val) {
        return true;
      }
    }
    return false;
  }
}

var Informer = (function () {
  var instances = {}

  function create_instance(id, options) {
    var place = $('#'+id)
    if (!place.length) {
      // console.log('place: ', place)
      throw new Error('Не найден DOM объект с идентификатором ' + id)
    }
    if (options!=null&&options.template!=null) {

    }
    var object = new Object({

      place: place,

      options: (options!=null)?Object.assign({},Informer.options,options):Informer.options,

      print: function(text, options=null) {
        var type
        switch(typeof(options)) {
          case 'string':
            type = options
            options = null
            break
          case 'object':
            type = (options && typeof(options.type)==='string')?options.type:null
            options = (options)?options:null
            break
          case 'undefined':
          default:
            type = null
            options = null
            break
        }
        var id = this.create_message(text, type, options)
        this.show_message(id)
        return id
      },

      create_message: function(text, type, options) {
        var message_options = this.options_merge(options)
        var id = this.generate_id()
        if (!type) {
          type = this.options.types[0]
        }
        var message = $(this.q_replace({id:id, type:type, text:text}))
        message.data('options', message_options)
        var message_options = message.data().options

        if (!message_options.stack) {
          this.clear()
        }
        if (message_options.stack && message_options.max_count>0 && this.get_count_messages() >= message_options.max_count) {
          this.lead_to_length(message_options.max_count)
        }
        this.place.append(message)
        return id
      },

      q_replace: function(hash) {
        html = this.options.template.replace(/\?\?([a-z0-9_]+)\?\?/g, (full,part) => {
          if (part==='type'&&hash[part]!=null) {
            return (this.options.assign_classes[hash[part]]!=null)?this.options.assign_classes[hash[part]]:hash[part]
          }
          if (typeof(hash[part])==='undefined') {
            return ''
          }
          return hash[part]
        })
        return html
      },

      lead_to_length: function(lenght) {
        var count = this.get_count_messages()
        var l = count - lenght + 1
        for (var i = 0; i < l; i++) {
          this.remove_first_message()
        }
      },

      options_merge: function(options) {
        if (options != null) {
          return Object.assign({}, this.options, options)
        } else {
          return this.options
        }
      },

      get_message: function(message_id) {
        var message = this.place.children('div[data-id="' + message_id + '"]')
        return message
      },

      show_message: function(message_id) {
        var message = this.get_message(message_id)
        var message_options = message.data().options
        // Эффект появления сообщения может быть задан стрингой и массивом стрингов
        if (this.options.print!=null) {
          switch(typeof(message_options.print)) {
            case 'object':
                this.options.print.forEach((effect,index)=>{
                  message.transition(effect)
                })
              break
            case 'string':
              message.transition(this.options.print)
              break
            default:
              message.show()
              break
          }
        } else {
          message.show()
        }
        // Прятать ли?
        if (message_options.show_time) {
          setTimeout(()=>{this.hide_message(message_id)}, message_options.show_time)
        }
      },

      hide_message: function(message_id) {
        var message = this.get_message(message_id)
        message.transition({ scale: 0 }).on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(e){$(this).remove()} )
      },

      remove_message: function(message_id) {
        var message = this.get_message(message_id)
        message.remove()
      },

      remove_first_message: function() {
        var message = this.place.children().eq(0)
        var message = this.place.children().first()
        message.remove()
      },

      clear: function() {
        this.place.html('')
      },

      generate_id: function() {
        var count = this.get_count_messages()
        var data_ids = this.get_messages_id()
        for (var i = 0; i < count; i++) {
          if (!data_ids.in_array(i)) {
            return i
          }
        }
        return count
      },

      get_count_messages: function() {
        return this.place.children().length
      },

      get_messages_id: function() {
        var data_ids = []
        this.place.children().each(function(index,message) {
          data_ids.push($(message).data('id'))
        })
        return data_ids
      }
    });
    return object;
  }

  return {
    options: {
      types: ['default','info','success','warning','danger'],
      assign_classes: {
        default: '',
        danger: 'error'
      },
      template: '<div data-id="??id??" class="ui compact mini message ??type??" style="display:none;"><p>??text??</p></div>',
      stack: true,
      print: ['fly left', 'flash'],
      max_count: 5,
      show_time: 5000
    },
    get_instance: function (id, options=null) {
      if (typeof(id)!=='string'||!id) {
        throw new Error('Необходим идентификатор места')
      }
      if (typeof(instances[id])==='undefined') {
        instance = create_instance(id, options)
        instances[id] = instance
      }
      return instances[id]
    }
  }
})();
