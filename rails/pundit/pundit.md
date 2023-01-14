# Pundit

Система авторизации, достаточно простая и поэтому понятная/масштабируемая/надёжная.


## Установка

```sh
bundle add pundit
rails g pundit:install
```

## Использование

```sh
rails g pundit:policy post
```

```rb
class ApplicationController < ActionController::Base
  include Pundit::Authorization
end
```

## Получить права вне контроллера или вьюхи

Обычно это исключение из правил, однако условная валидация в модели:

```rb
# app/policies/offer_policy.rb
class OfferPolicy
  ...
  def specify_project?
    user.present? && user.role?(
  ...
end

# app/models/offer.rb
class Offer ...
  attr_accessor :current_user
  validates :project, presence: true, if: -> {
    Pundit.policy(current_user, self).specify_project?
  }
```
