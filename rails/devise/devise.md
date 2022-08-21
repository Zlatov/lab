# Devise

Аутентификация

## Установка

## Использование

```ruby
current_user.confirmed? # Подтверждён email?
current_user.update! confirmed_at: nil # Сбросить подтверждение вручную.
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
