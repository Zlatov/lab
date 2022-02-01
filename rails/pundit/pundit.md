# Pundit

Система авторизации, достаточно простая и поэтому понятная/масштабируемая/надёжная.

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
