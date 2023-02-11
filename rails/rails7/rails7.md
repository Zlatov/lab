# Отличия в rails 7

## Turbo-rails

```rb
# link_to affiliate, method: :delete
link_to affiliate, data: { 'turbo-method': :delete }

# link_to affiliate, data: { confirm: t(:are_you_sure) }
link_to affiliate, data: { 'turbo-confirm': t(:are_you_sure) }

form_for(resource, as: resource_name, url: password_path(resource_name), html: { method: :post }, data: {turbo: false}) do |f|

```
