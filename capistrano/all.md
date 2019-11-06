# Capistrano

Средство автоматизации и развертывания удаленного сервера, написанное на Ruby.

## Установка

__Локально для проекта (предпочтительно):__

1. Добавить гем строки _Gemfile_, затем `bundle`:
```ruby
# Деплой
gem "capistrano", "~> 3.11", require: false
```
2. Установим начальную структуру файлов капистрано
```bash
bundle exec cap install
```

__Глобально:__

`gem install capistrano` или см. [capistranorb.com](https://capistranorb.com/documentation/getting-started/installation/)
