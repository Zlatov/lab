# Rails

Rails - фреймворк ruby

## Установка

1. Проверить версию руби `ruby -v`, установить необходимую - см. _ruby/all.md_;
2. gem 3.0.3 (gem update --system # Для обновления gem. (gem -v))
3. bundler 2.0.1 (`gem install bundler -v 2.0.1` (`gem list bundler`))
4. Проверить доступные версии rails `gem list ^rails$ --remote --all`
5. Проверить конкретную версию rails `gem install rails -v 5.2.0`

* __Postgres__ (гем pg) потребует библиотеку
  ```bash
  sudo apt install -y libpq-dev
  sudo yum install -y postgresql-devel
  ```
  Если несколько постгресов, то потребуется дополнительная настройка:
  ```bash
  # Либо установить вручную gem:
  gem install pg -- --with-pg-config=/usr/pgsql-9.6/bin/pg_config
  # а при полной жопе (что часто) можно указать старую версию и библиотеки где:
  gem install pg -v'1.2.3' -- --with-pg-config=/usr/pgsql-12/bin/pg_config --with-pg-lib=/usr/pgsql-12/lib/
  # Либо добавиьт настройку в bundler
  bundle config build.pg --with-pg-config=/usr/pgsql-9.6/bin/pg_config
  # Это НЕ тот путь который нужно использовать!!:
  psql -XAt -U postgres -c 'SHOW config_file'
  ```
* __Sqlite__ (гем sqlite3) потребует библиотеку
  ```bash
  sudo apt install -y libsqlite3-dev
  sudo yum install -y sqlite-devel
  ```
* __Mysql__ (гем mysql2) потребует библиотеку
  ```bash
  sudo apt install -y libmysqlclient-dev
  sudo yum install -y mysql-devel
  ```
* __Система__ (ubuntu) потребует изменение параметров ядра `echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p`


## Создание нового приложения

```sh
ruby --version # Проверить версию руби, в кажой версии может быть установлены свои версии рельс.
rbenv versions # Проверить доступные версии, вереключиться/установить другую см. ruby/all.md
gem list ^rails$ # В текущей версии руби посмотреть доступные версии рельс.
gem list ^rails$ --remote --all # Доступные для установки версии.
gem install rails -v 6.0.2.1 # Установить требуемую версию рельс.
rails --version # Покажет скорее всего послеюнюю из доступных.

# Создание
mkdir newapp
cd newapp
rails new ./
subl ./
bundle exec rails s -p 3001

# Команды создания:
rails new testApp
rails new .
rails _5.2.3_ new lorem_rails --webpack --skip-sprockets
rails _6.0.2.1_ new . --webpack --skip-sprockets
rails _6.1.5_ new comics_geek_backend --database=postgresql --api
```

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


## Создание rails с postgresql в докер контейнере

```sh
sudo apt install -y libpq-dev
rails new temp_rails -d postgresql
cd temp_rails
touch .env
subl .env
# Файл .env
COMPOSE_PROJECT_NAME=temp_rails
POSTGRES_USER=temp_rails
POSTGRES_PASSWORD=temp_rails

touch docker-compose.yml
subl docker-compose.yml
# Файл docker-compose.yml
---
version: "3.8"

services:
  pg:
    image: postgres:14.6-alpine
    environment:
      - POSTGRES_USER=${POSTGRES_USER:?Пользователь postgres не установлен, смотри файл .env}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD:?Пароль postgres не установлен, смотри файл .env}
    volumes:
      - ./volumes/pg_data:/var/lib/postgresql/data
    ports:
      - 5434:5432
    restart: unless-stopped

subl config/database.yml
# Файл config/database.yml
default: &default
  ...
  host: localhost
  port: 5434
  username: temp_rails
  password: temp_rails

docker compose up --build --no-start
docker compose start
rails db:create
rails s
```

И удаление временного приложения

```sh
docker compose stop
docker compose down -v --remove-orphans
sudo rm -rf temp_rails
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
