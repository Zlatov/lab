# Rails

Rails - фреймворк ruby

## Установка

* ruby 2.5.3 (rbenv install 2.5.3 (ruby -v))
* gem 3.0.3 (gem update --system # Для обновления gem. (gem -v))
* bundler 2.0.1 (gem install bundler -v 2.0.1 (gem list bundler))

rails 5.2.2 (`gem install rails -v 5.2.2`, `gem list rails`)

* Следить за состоянием rbenv:
* ~/.rbenv git pull
* ~/.rbenv/plugins/ruby-build git pull

## Приложение

__Создание нового__

* `rails new testApp`
* `rails new .`
* `rails _5.2.3_ new lorem_rails --webpack --skip-sprockets`

__Запуск__

* `rails s`
* `rails s -d` - как демона.
* `rails s -b 0.0.0.0` - с доступом извне.
* `rails s -b 0.0.0.0 -p 3002` - на порту 3002.

__Остановка__

`ps aux | grep puma`
`ps aux | grep lorem_rails`
`kill -9 process_id`

```
[[ -s tmp/pids/server.pid ]] && kill -QUIT `cat tmp/pids/server.pid` || echo 'Not found.'; exit 0
```

## Миграции

### Экспорт/импорт схемы

Настройка экспорта схемы в файле `config/environments/development.rb`:

```ruby
  # Если выбрано :ruby, тогда схема хранится в db/schema.rb, иначе в db/structure.sql
  config.active_record.schema_format = :sql
```

`rails db:structure:dump` - экспорт схемы.
`rails db:structure:load` - импорт схемы.


## Полезные гемы

* __Kaminari__ - пагинациая.
* __annotate__ - автоматическая нототация моделей.
* __pry__ - альтернатива стандартной оболочке IRB для Ruby.
