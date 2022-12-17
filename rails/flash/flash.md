## controller

```rb
# Установить
flash.notice = 'Мне не спится, нет огня;'
flash[:notice] = 'Мне не спится, нет огня'
flash.alert = 'Всюду мрак и сон докучный.'
flash[:alert] = 'Всюду мрак и сон докучный'

# Удалить ранее установленное сообщение
flash.delete :recaptcha_error

# Регистрация дополнительных типов flash
# Но это приведёт к появлению паразитных хелперов во вьюхах (info, danger...)
class ApplicationController
  add_flash_types :success, :info, :warning, :danger
  def action
    # Зато однострочно можно задавать сообщение при редиректах, имхо сомнительное достижение.
    redirect_to posts_url, success: 'post was ..!'
  end
end

```

## view

_layout_:

```html
<p class="notice"><%= notice %></p>
<p class="alert"><%= alert %></p>

<% flash.each do |name, msg| %>
  <%= content_tag :div, msg, class: "alert alert-#{name}" %>
<% end %>
<div id="flashes">
  <% flash.each do |key, message| %>
    <% # По документации devise пропускаем рендеринг этого ключа. %>
    <% next if key == 'timedout' %>
    <% message_type = key.to_s %>
    <% message_type = 'info' if message_type == 'notice' %>
    <% message_type = 'warning' if message_type == 'alert' %>
    <div class="flash">
      <div class="flash-center">
        <div class="container">
          <div class="flash-wrap">
            <div class="alert alert-<%= message_type %> alert-dismissible">
              <%= message %>
              <button type="button" class="btn-close"></button>
            </div>
          </div>
        </div>
      </div>
    </div>
  <% end %>
</div>
```
```css
#flashes {
  .flash {
    background-color: rgba(0, 0, 0, 0.5);
    position: fixed;
    width: 100%;
    height: 100%;
    top: 0;
    z-index: 10010;

    &.closed {
      display: none;
    }

    .flash-center {
      position: absolute;
      width: 100%;
      top: 50%;
      transform: translateY(-50%);
    }

    .flash-wrap {
      background-color: white;
      border-radius: $border_radius;
      padding: 20px;
      margin: 0 20px;
      & :last-child {
        margin-bottom: 0;
      }
    }

    .flash-close {
      display: block;
      float: right;
      cursor: pointer;
      line-height: 1em;

      &:before {
        content: "\f2d3";
        font-family: FontAwesome;
        color: #a94442;
      }
    }
  }
}
```
```js
// Закрытия всплывших сообщений (см. вьюху
// app/views/admin/application/_flashes.html.erb)

"use strict"

var instance

function Flashes() {
  this.options = {
    place: "#flashes",
    flash: ".flash",
    close: ".btn-close"
  }
}

Flashes.getInstance = function() {
  if (instance == null) {
    instance = new this()
  }
  return instance
}

Flashes.prototype.activate = function() {
  this.place = $(this.options.place)
  if (this.place.length != 1) {
    return this
  }
  this.place.on('click', this.options.close, {instance: this}, this.close_handler)
  this.place.on('click', this.options.flash, {instance: this}, this.close_handler)
  return this
}

Flashes.prototype.close_handler = function(event) {
  event.stopPropagation()
  var instance = event.data.instance
  var object = $(event.target)
  var flash = null
  // Определяем на что кликнули
  switch(true) {
    case object.is(instance.options.flash):
      // На "подложку"
      flash = object
    break
    case object.is(instance.options.close):
      // На "крестик"
      flash = object.parents(instance.options.flash).first()
    break
  }
  if (flash != null) {
    flash.addClass("closed")
  }
}

$(document).on('turbolinks:load', function() {
  Flashes.getInstance().activate()
})
```
