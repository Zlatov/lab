# Sidekiq

Фоновая обработка задач

## Установка

## Запуск

```bash
# Запуск Процесса-обработчика (он берет задачу из redis и выполняет её в установленное время).
RAILS_ENV=production bundle exec sidekiq -L log/sidekiq.log -d
# -C config/sidekiq.yml - только в том случае, если файл расположен не в
#  стандартном месте (По документации должен схватывать стандартное
#  расположение).
# -d отменён в последней версии - используем systemd ...
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

```rb
# Удалить все данные о задачах в redis.
Sidekiq.redis(&:flushdb)
# Удалить все сообщения о проваленых задачах
Sidekiq.redis{|c| c.del('stat:failed')}
# или
Sidekiq::Stats.new.reset('failed')
```

https://gist.github.com/Chocksy/6dccf8cbc0469404ea1967088f00f132
```rb
# FOR BUSY JOBS
# take the process_id from the /busy page in sidekiq and kill the longest running one.
workers = Sidekiq::Workers.new
workers.each do |process_id, thread_id, work|
  process = Sidekiq::Process.new('identity' => process_id)
  process.stop! if process_id == 'integration.3:4:71d1d7f4ef5a'
end

# FOR SCHEDULED JOBS
# you need to know the jid to make this happen
job = Sidekiq::ScheduledSet.new.find_job('e460064eda529b97e93314d4')
job.delete # will just remove the job

# FOR RETRY JOBS
# you need to know the jid to make this happen
job = Sidekiq::RetrySet.new.find_job('e460064eda529b97e93314d4')
job.delete # will just remove the job
```

https://stackoverflow.com/questions/25889699/sidekiq-stop-one-single-running-job
```rb
# Задача по прерыванию других задач
class ThreadLightlyWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  # Рекомендуется установить время истечения срока действия больше, чем время,
  # необходимое для выполнения задания.
  def expiration
    # 60 * 60 * 24 * ...
    @expiration ||= 10
  end

  def perform(tid, callback = nil)
    cla = nil
    cla = callback.constantize if callback.present? && Object.const_defined?(callback)
    puts format('I am %<class>s, and I will be terminating TID: %<tid>s...', class: self.class, tid: tid)
    Thread.list.each do |t|
      next if t.object_id.to_s(36) != tid

      puts format('Goodbye %<tid>s!', tid: t)
      t.exit
      cla.new.stop_callback(true) if cla.present?
      return true
    end
    cla.new.stop_callback(false) if cla.present?
  end
end
```

https://stackoverflow.com/questions/24886371/how-to-clear-all-the-jobs-from-sidekiq
```rb
require 'sidekiq/api'

# Clear retry set

Sidekiq::RetrySet.new.clear

# Clear scheduled jobs 

Sidekiq::ScheduledSet.new.clear

# Clear 'Dead' jobs statistics

Sidekiq::DeadSet.new.clear

# Clear 'Processed' and 'Failed' jobs statistics

Sidekiq::Stats.new.reset

# Clear all queues

Sidekiq::Queue.all.map(&:clear)

# Clear specific queue

stats = Sidekiq::Stats.new
stats.queues
# => {"main_queue"=>25, "my_custom_queue"=>1}

queue = Sidekiq::Queue.new('my_custom_queue')
queue.count
queue.clear
```

## Авторизация для страницы управления /sidekiq

Два способа.

1. Базовая аутентификация

```rb
# config/initializers/sidekiq.rb
require 'sidekiq'
require 'sidekiq/web'

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  # Protect against timing attacks:
  # - See https://codahale.com/a-lesson-in-timing-attacks/
  # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
  # - Use & (do not use &&) so that it doesn't short circuit.
  # - Use digests to stop length information leaking
  Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(user), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USER"])) &
  Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
end
```

2. Аутентификация 

```rb
# config/routes.rb
authenticate :user do
  mount Sidekiq::Web => '/sidekiq'
end
# или
authenticate :user, lambda { |u| u.admin? } do
  mount Sidekiq::Web => '/sidekiq'
end
```
