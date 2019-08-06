# Sidekiq

## Установка

## Запуск

```bash
RAILS_ENV=production bundle exec sidekiq -L log/sidekiq.log -C config/sidekiq.yml -d
```

__Ключи__

* -d, Daemonize process
* -L, path to writable logfile
* -C, path to YAML config file
* -e, Application environment

__Остановка__

Если в _sidekiq.yml_ настроено хранение pid, то можно выключать его командой:

```
sidekiqctl stop tmp/pids/sidekiq.pid
```

## Настройка

_config/routes.rb_

```ruby
  mount Sidekiq::Web => '/sidekiq'
```

_Gemfile_

```ruby
gem 'sidekiq' # задачник
gem 'sidekiq-queue-pause' #ставить на паузу задачи в задачнике
#gem 'sidekiq-scheduler' # типа cron task в нутри задачника
#gem 'sidekiq-statistic' # расширенная статистика задач
gem 'whenever', require: false # перегоняет задачи rake в системный cron
```

_config/sidekiq.yml_

```yaml
:concurrency: 4
production:
  :concurrency: 24
:timeout: 15
:queues:
  - mailers
  - default
```


## Использование

### Redis

* Очистить все задачи sidekiq в базе редиски `redis-cli flushdb`.

### Sidekiq

__Возобновлнение задач определённых типов после убийства процесса sidekiq__

```ruby
answer = Sidekiq::QueuePause.unpause(:mailers, :default)
```
