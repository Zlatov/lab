# Devise

Аутентификация

## Установка

```ruby
# Gemfile
# Аутентификация.
gem 'devise'

bundle

rails generate devise:install

https://github.com/heartcombo/devise/wiki/I18n

# config/environments/development.rb
# Гем device требует для отправки писем определиться с доменом
config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

# config/environments/production.rb
# Гем device требует для отправки писем определиться с доменом
config.action_mailer.default_url_options = {
  host: (ENV['WEB_HOSTS'] || 'localhost').split("\s")[0],
  port: nil
}

rails generate devise User

# app/models/user.rb и в соответствии с ним: db/migrate/_devise_create_users.rb
  # Include default devise modules. Others available are:
  # :confirmable                - письмо с инструкциями для подтверждения аккаунта
  # :lockable                   - блокирует аккаунт после количества неудачных попыток авторизации
  # :timeoutable                - продолжительность сессии активности пользователя в системе
  # :trackable                  - ведет статистику количества входов, учитывает время и IT-адреса
  # :omniauthable               - поддержку Omniauth https://github.com/intridea/omniauth
  # :database_authenticatable   - входа на основе зашифрованного и хранимого в базе данных пароля
  # :registerable               - позволяет редактировать и удалять аккаунты
  # :recoverable                - инструкции по восстановлению на почту
  # :rememberable               - запоминать пользователей на основе cookies
  # :validatable                - инструменты валидации e-mail и пароля
  devise :database_authenticatable,
    :confirmable,
    :lockable,
    :timeoutable,
    :trackable,
    :registerable,
    :recoverable,
    :rememberable,
    :validatable

RAILS_ENV=development bundle exec rails db:migrate
RAILS_ENV=test        bundle exec rails db:migrate

gem install mailcatcher

mailcatcher

# config/initializers/devise.rb
config.allow_unconfirmed_access_for = 2.days
config.timeout_in = 4.hours

# app/controllers/admin/application_controller.rb
before_action :authenticate_user!

rails generate devise:controllers admin/devises
rails generate devise:views admin/devises

# config/initializers/devise.rb
config.scoped_views = true

# config/routes.rb
scope "admin/devises" do
  devise_for :users, controllers: {
    sessions: "admin/devises/sessions",
    confirmations: "admin/devises/confirmations",
    passwords: "admin/devises/passwords",
    registrations: "admin/devises/registrations",
    unlocks: "admin/devises/unlocks",
    omniauth: "admin/devises/omniauth"
  }
end
```


## Использование

```ruby
current_user.confirmed? # Подтверждён email?
current_user.update! confirmed_at: nil # Сбросить подтверждение вручную.
user.skip_confirmation! # Перед сохранением нового пользователя установить флаг для отмены отправки подтверждающего письма.
user.skip_confirmation_notification! # Установить флаг для отмены отправки письма уведомляющего об успешном подтверждении.
user.save(validate: false) # Отменить валидацию полезно если мы хотим email: admin (без @) и дефолтный пароль - (только для первого запуска приложения - потом например зайти и исправить пароль)
```

## Использование в Grape API

```rb
# app/controllers/api/v1/authenticate_helpers.rb
module Api
module V1
module AuthenticateHelpers
  extend Grape::API::Helpers

  def current_user
    @current_user ||= env["warden"].authenticate
  end  
end
end
end

# app/controllers/api/v1/index_api.rb
class Api::V1::IndexApi < Component::Rest::Api
  helpers Api::V1::AuthenticateHelpers

# Как использовать хелперы приложения
# app/controllers/api/v1/trader_api.rb
class Api::V1::TraderApi < Component::Rest::Api
  helpers ApplicationHelper
```
