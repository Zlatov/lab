# Rspec

Система тестов для ruby/rails.

Неплохой начальный урок: https://www.youtube.com/watch?v=3ku89naLPg8


## Установка, настройка

https://github.com/rspec/rspec-rails#installation


## Надстройки

__gem 'factory_bot'__

https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md

__gem 'faker'__

https://github.com/faker-ruby/faker


## Использование

```sh
rake spec
bundle exec rake spec
bundle exec rspec
```

```sh
# .rspec

--require spec_helper

# Формат вывода
--format documentation
--format progress
```
