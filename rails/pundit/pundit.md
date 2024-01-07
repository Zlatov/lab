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
rails g pundit:policy admin/product
```

```rb
class ApplicationController < ActionController::Base
  include Pundit::Authorization
end
```

## Описание основных методов

```rb
authorize object # авторизуй какой-то объект - используется в экшенах контроллера.
# Авторизуй - проерь можно ли с этим объектом и текущим пользователем делать этот экшн.

def show
  authorize @post # Авторизуй Пост в экшене show (будет искать в PostPolicy метод show?).
  authorize @post, :update? # Авторизуй Пост, но проверь для экшена update
                            # (будет искать в PostPolicy метод update?).
  authorize Post # Авторизуй Пост (будет искать в PostPolicy) текущий экшн.
  authorize :pages # Авторизуй "что-то" (тут я понимаю как контроллер
                   # PagesController), будет искать в PagesPolicy, текущий экшн
                   # для текущего пользователя (см. в документации раздел
                   # Headless policies).
  authorize [:admin, :pages] # Авторизуй "что-то" (будет искать в
                             # Admin::PagesPolicy) текущий экшн для текущего
                             # пользователя (см. в документации раздел Policy
                             # Namespacing).
  authorize([:admin, :pages], :global?) # Авторизуй "что-то",(будет искать в
                             # Admin::PagesPolicy, экшн global?
  authorize @post, policy_class: PublicationPolicy # Авторизуй объект по чужой политике прав.


# Проверить право.
# Во вьюхах:
if policy(Post).index?
if policy(:pages).index?
if policy([:admin, :pages]).index?
# В любом другом месте:
Pundit.policy!(user, post)
Pundit.policy(user, post)
Pundit.policy(current_user, [:admin, :home]).dashboard?
Pundit.policy_scope!(user, Post)
Pundit.policy_scope(user, Post)
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
    # Берёт класс разрешения (Admin::OfferPolicy) автоматически c пространствои
    # имён объекта self (Admin::Offer)
    Pundit.policy(current_user, self).specify_project?
    # Можно проверить право просто взяв его (со своим пространством имён)
    Admin::OfferPolicy.new(current_user, self).specify_project?
  }
```
