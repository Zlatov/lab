# Sidekiq

Фоновая обработка задач

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

### Пример

```rb
class MyMailers < ActionMailer::Base
  def some_mailer(r.user_id)
    @user = User.find(r.user_id)
    mailer_name = "ROUNDUP"
    @email = @user.email
    @subject ="subject text"
    mail(to: @email,
      subject: @subject,
      template_path: '/notifer_mailers',
      template_name: 'hourly_roundup.html',
    )
  end
end
class SomeWorker
  include Sidekiq::Worker
  def perform()
    @user = User.all
    @reminders = @user.reminders.select(:user_id).uniq.newmade
    @reminders.each do |r|
      MyMailers.some_mailer(r.user_id).deliver_later
    end
  end
end
SomeWorker.perform_async
SomeWorker.set(queue: 'foo').perform_async(1)
```
