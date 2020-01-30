# Rails

Rails - фреймворк ruby

## Установка

1. Проверить версию руби `ruby -v`, установить необходимую - см. _ruby/all.md_;
2. gem 3.0.3 (gem update --system # Для обновления gem. (gem -v))
3. bundler 2.0.1 (`gem install bundler -v 2.0.1` (`gem list bundler`))
4. Проверить доступные версии rails `gem list ^rails$ --remote --all`
5. Проверить конкретную версию rails `gem install rails -v 5.2.0`

* __Postgres__ (гем pg) потребует библиотеку
  * `sudo apt install libpq-dev` (Ubuntu);
  * `yum install postgresql-devel` (Centos).
  Если несколько постгресов, то потребуется дополнительная настройка:
  ```bash
  # Либо установить вручную gem:
  gem install pg -- --with-pg-config=/usr/pgsql-9.6/bin/pg_config
  # Либо добавиьт настройку в bundler
  bundle config build.pg --with-pg-config=/usr/pgsql-9.6/bin/pg_config
  # Это НЕ тот путь который нужно использовать!!:
  psql -XAt -U postgres -c 'SHOW config_file'
  ```
* __Sqlite__ (гем sqlite3) потребует библиотеку `sudo apt install libsqlite3-dev`
* __Mysql__ (гем mysql2) потребует библиотеку `sudo apt-get install libmysqlclient-dev`
* __Система__ (ubuntu) потребует изменение параметров ядра `echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p`


## Приложение

__Создание нового__

`gem list ^rails$ --remote --all`
`gem install rails -v 6.0.2.1`

* `rails new testApp`
* `rails new .`
* `rails _5.2.3_ new lorem_rails --webpack --skip-sprockets`
* `rails _6.0.2.1_ new . --webpack --skip-sprockets`

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
