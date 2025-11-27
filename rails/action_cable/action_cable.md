# Action Cable

## Создание / Настройка

```bash
# Создаст два основных файла канала, и отальные, необходимые для работы:
# app/channels/import_channel.rb
# app/javascript/channels/import_channel.js
docker compose exec web bundle exec rails generate channel import --no-test-framework
```

Не забыть кабелине дать редис (REDIS_URL) в файле config/cable.yml.

```yml
# 
development:
  # adapter: async
  adapter: redis
  url: <%= ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" } %>
  channel_prefix: appname

test:
  adapter: test

production:
  adapter: redis
  url: <%= ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" } %>
  channel_prefix: appname_production
```


## Реализации js

```js
// Базовая "из коробки"
// Работает всегда, нет жизненного цикла подписок (неоптимально)
// Один объект - одна подписка (неоптимально)
import consumer from "./consumer"

consumer.subscriptions.create(
  "SomeChannel",
  {
    // Вызывается, когда подписка готова к использованию на сервере.
    connected() {
      console.log('> connected')
    },

    // Вызывается, когда подписка прекращена сервером.
    disconnected() {
      console.log('> disconnected')
    },

    // Вызывается, когда на веб-сокете есть входящие данные для этого канала.
    received(data) {
      console.log('data: ', data)
    }
  }
)




// Активация при turbolinks:load - неполный жизненный цикл - нет удаления ненужных подписок.
// Множество объектов с классом ".make_service", у каждого своя подписка основанная на различии class_name - норм.
$(document).on('turbolinks:load', function() {
  activate_some_channel_subscriptions()
})

function activate_some_channel_subscriptions() {
  const make_services = document.querySelectorAll(".make_service")
  if (make_services.length == 0) return

  const class_names = new Set()
  make_services.forEach(dom => {
    class_names.add(dom.dataset.class_name)
  })

  class_names.forEach(class_name => {
    create_subscription(class_name)
  })
}

function create_subscription(class_name) {
  consumer.subscriptions.create(
    {
      channel: "SomeChannel",
      class_name: class_name
    },
    {
      // Вызывается, когда подписка готова к использованию на сервере.
      connected() {
        console.log('> connected')
      },

      // Вызывается, когда подписка прекращена сервером.
      disconnected() {
        console.log('> disconnected')
      },

      // Вызывается, когда на веб-сокете есть входящие данные для этого канала.
      received(data) {
        // console.log('class_name: ', class_name)
        // console.log('data: ', data)
        var service = $(`.make_service[data-class_name=${class_name}]`)
        if (data.status != null) service.find(".make_service-status").text(data.status)
        if (data.notice != null) service.find(".make_service-notices").append($(`<p class="mb-0">${data.notice}</p>`))
      }
    }
  )
}


// Жизненный цикл подписок (кроме visibilitychange - возвращение на вкладку
// браузера `if (document.hidden) {pauseSubscriptions()} else
// {resumeSubscriptions()}`)
class ServiceSubscriptions {
  constructor() {
    this.subscriptions = new Map()
    this.setupEventListeners()
  }

  // Жизненный цикл подписок
  setupEventListeners() {
    // Turbolinks
    document.addEventListener('turbolinks:before-visit', () => this.unsubscribeAll())
    document.addEventListener('turbolinks:load', () => this.setupFromDOM())

    // Стандартная загрузка (первая или как при data-turbolinks="false")
    document.addEventListener('DOMContentLoaded', () => this.setupFromDOM())

    // Восстановление при возврате онлайн (браузер определил что интернет появился)
    document.addEventListener('online', () => this.restoreSubscriptions())
  }

  setupFromDOM() {
    const services = document.querySelectorAll('.make_service')
    const current_class_names = new Set()
    
    services.forEach(e => current_class_names.add(e.dataset.class_name))
    
    // Удаляем устаревшие подписки
    this.subscriptions.forEach((sub, class_name) => {
      if (!current_class_names.has(class_name)) {
        this.unsubscribe(class_name)
      }
    })
    
    // Добавляем новые
    current_class_names.forEach(class_name => {
      if (!this.subscriptions.has(class_name)) {
        this.subscribe(class_name)
      }
    })
  }

  subscribe(class_name) {
    const subscription = consumer.subscriptions.create(
      {
        channel: "SomeChannel",
        class_name: class_name
      },
      {
        // Вызывается, когда подписка готова к использованию на сервере.
        connected() {
          // console.log('> connected')
        },

        // Вызывается, когда подписка прекращена сервером.
        disconnected() {
          // console.log('> disconnected')
        },

        // Вызывается, когда на веб-сокете есть входящие данные для этого канала.
        received(data) {
          var service = $(`.make_service[data-class_name=${class_name}]`)
          if (data.status != null) service.find(".make_service-status").text(data.status)
          if (data.notice != null) service.find(".make_service-notices").append($(`<p class="mb-0">${data.notice}</p>`))
        }
      }
    )
    this.subscriptions.set(class_name, subscription)
  }

  unsubscribe(class_name) {
    if (this.subscriptions.has(class_name)) {
      this.subscriptions.get(class_name).unsubscribe()
      this.subscriptions.delete(class_name)
    }
  }

  unsubscribeAll() {
    this.subscriptions.forEach((sub, _class_name) => {
      sub.unsubscribe()
    })
    this.subscriptions.clear()
  }

  restoreSubscriptions() {
    // Переподписка при восстановлении соединения
    this.unsubscribeAll()
    this.setupFromDOM()
  }
}

// Инициализация
window.serviceSubscriptions = new ServiceSubscriptions()
```


## Реализация ruby


```rb
class SomeChannel < ApplicationCable::Channel
  def subscribed
    # Даёт возможность отправлять данные подписчикам стрима со строковым
    # идентификатором "some_channel"
    # 
    # Сообщает подписчику «слушай стрим со строковым
    # идентификатором "some_channel"»
    stream_from "some_channel"


    # Даёт возможность отправлять данные подписчикам стрима, связанного с
    # объектом (к примеру Post.find(id))
    # 
    # Сообщает подписчику «слушай стрим объекта object»
    # 
    # `stream_for "some_channel"` использует строку как объект, 
    # что создает стрим с именем "some:some_channel" (автоматическое преобразование)
    stream_for "some_channel"
    # Создает стрим на основе GlobalID объекта, имя
    # стрима: "some_channel:Z2lkOi8v... (gid объекта User)"
    stream_for current_user


    # Подписать на стрим только администраторов (необходимо изменить
    # app/channels/application_cable/connection.rb чтобы появился
    # current_user)
    if current_user.present? && current_user.admin?
      stream_from "some_channel:#{params[:class_name]}"
    else
      reject
    end
  end

  def unsubscribed
    puts 'unsubscribed'.green
    # Any cleanup needed when channel is unsubscribed
  end
end


# app/channels/application_cable/connection.rb
module ApplicationCable

class Connection < ActionCable::Connection::Base
  identified_by :current_user

  def connect
    # Devise хранит пользователя в env['warden'].user или, точнее, request.env['warden'].user, но тут:
    user = env['warden']&.user
    self.current_user = user

    # Тут можно жёстко отменить соединение если пользователь не найден, но можно
    # передать управление этой бизнес-логикой в Channel класс:
    # reject_unauthorized_connection if user.blank?
  end
end

end


# Примеры передачи данных из консоли
ActionCable.server.broadcast("some_channel", { message: "Hello from console!", timestamp: Time.current })
ActionCable.server.broadcast("some_channel:MakeAdvcatalogService", { message: "Hello from console!", timestamp: Time.current })
# если используется stream_for, то появляется возможность использовать удобный сахар:
SomeChannel.broadcast_to(object, { message: "Hello World!", from: "console" })
```
