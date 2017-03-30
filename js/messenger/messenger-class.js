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
 * Опции
 * =====
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

  function create_instance(id,options) {
    var place = $('#'+id)
    var instance_options = (typeof(options)!=='undefined' && options)?options:Informer.options
    var object = new Object({

      place: place,

      options: instance_options,

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
        var message_id = this.generate_id()
        var message = this.create_message(message_id, text, type, options)
        this.add_message(message)
        this.show_message(message_id)
        return message_id
      },

      create_message: function(id, text, type, options) {
        if (!type) {
          type = Informer.types[0]
        }
        var message = Informer.q_replace({id:id, type:type, text:text})
        message = $(message)
        return message
      },

      get_message: function(message_id) {
        var message = this.place.children('div[data-id="' + message_id + '"]')
        return message
      },

      add_message: function(message) {
        this.place.append(message)
      },

      show_message: function(message_id) {
        var message = this.get_message(message_id)
        switch(typeof(this.options.print)) {
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
      },

      remove_message: function(message_id) {
        var message = this.get_message(message_id)
        message.remove()
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
    types: ['default','success','warning','danger'],
    template: '<div data-id="??id??" data-type="??type??" class="ui compact message ??type??" style="display:none;"><p>??text??</p></div>',
    options: {
      stack: true,
      // print: 'flash'
      print: ['fly left', 'flash']
    },
    q_replace: function(hash) {
      html = this.template.replace(/\?\?([a-z0-9_]+)\?\?/g, (full,part) => {
        if (typeof(hash[part])==='undefined') {
          return ''
        }
        return hash[part]
      })
      return html
    },
    get_instance: function (id) {
      if (typeof(id)!=='string'||!id) {
        throw new Error('Необходим идентификатор места')
      }
      if (typeof(instances[id])==='undefined') {
        instance = create_instance(id)
        instances[id] = instance
      }
      return instances[id]
    }
  }
})();

