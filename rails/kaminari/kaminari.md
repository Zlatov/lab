# Пагинация kaminari

## Установка

```rb
# Gemfile

# Пагинация
gem 'kaminari'
```

```sh
bundle
```


## Настройка своих шаблонов

```sh
rails g kaminari:views default --views-prefix admin
# https://github.com/amatsuda/kaminari_themes
rails g kaminari:views bootstrap4 --views-prefix admin
```


## Изменение общих настроек при инициализации (запуске) проекта

```rb
# config/initializers/kaminari.rb
Kaminari.configure do |config|
  config.default_per_page = 10
end
```


## Интернационализация (i18n)

```yml
# config/locales/kaminary.ru.yml
ru:
  views:
    pagination:
      first: "&laquo; Первая"
      last: "Последняя &raquo;"
      previous: "&lsaquo; Пред."
      next: "След. &rsaquo;"
      truncate: "&hellip;"
  helpers:
    page_entries_info:
      one_page:
        display_entries:
          zero: "No %{entry_name} found"
          one: "Displaying <b>1</b> %{entry_name}"
          other: "Displaying <b>all %{count}</b> %{entry_name}"
      more_pages:
        display_entries: "Displaying %{entry_name} <b>%{first}&nbsp;-&nbsp;%{last}</b> of <b>%{total}</b> in total"

```


## Использование в проекте

В моделях

```rb
class User < ActiveRecord::Base
  paginates_per 50
end
```

В шаблонах

```rb
= paginate @admin_users, views_prefix: 'admin'
= paginate orders, views_prefix: 'admin', param_name: :orders_page, params: {anchor: 'tab-1'}, pagination_class: 'mb-0'
```
