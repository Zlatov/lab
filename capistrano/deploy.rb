require 'awesome_print'
# require 'active_support'
# require 'active_support/core_ext'

# config valid for current version and patch releases of Capistrano
lock "~> 3.17.0"

set :application, "project-name"
set :repo_url, "git@gitlab.ru:gitlab-instance-123123123/project-name.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'
append :linked_files, "variables.env", ".env"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"
append :linked_dirs,
  "db/fs",
  "log",
  "node_modules",
  "public/assets",
  "public/packs",
  "tmp/pids",
  "tmp/cache",
  "tmp/sockets",
  "public/.well-known",
  "volumes"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure




# 
# Задачи особенностей деплоя
# 
namespace :deploy do

  desc 'Спросить про гит ветку.'
  task :branch do
    git_branch = `git rev-parse --abbrev-ref HEAD`.chomp
    set :branch, git_branch if git_branch.present?
    set :branch, ENV['BRANCH'] if ENV['BRANCH'].present?
    branch = fetch(:branch)
    ask :answer, "Продолжить деплой ветки: «#{branch}»? [Y|n]"
    case fetch(:answer).downcase
    when 'n', 'no'
      puts "Прервано пользователем.".blue
      exit 0
    else
      puts "Ветка подтерждена."
    end
  end
end



# 
# Задачи деплоя приложения
# 
namespace :app do

  # bundle exec cap staging app:stop
  desc 'Остановить.'
  task :stop do
    on roles(:all) do |host|
      application = fetch(:application)
      execute "sudo systemctl stop #{application}"
      info "Приложение остановлено."
    end
  end

  # bundle exec cap staging app:start
  desc 'Запустить.'
  task :start do
    on roles(:all) do |host|
      application = fetch(:application)
      execute "sudo systemctl start #{application}"
      info "Приложение запущено."
    end
  end

  # bundle exec cap staging app:restart
  desc 'Перезапустить.'
  task :restart do
    on roles(:all) do |host|
      application = fetch(:application)
      execute "sudo systemctl restart #{application}"
      info "Приложение перезапущено."
    end
  end

  # bundle exec cap staging app:phased_restart
  desc 'Перезапустить воркеры поочерёндно (годно для перезапуска без миграций).'
  task :phased_restart do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production pumactl phased-restart"
      info "Приложение запущено."
    end
  end

  # bundle exec cap staging app:status
  desc 'Посмотреть состояние приложения.'
  task :status do
    on roles(:all) do |host|
      application = fetch(:application)
      execute "systemctl status #{application} || echo &>/dev/null"
    end
  end

  # bundle exec cap staging app:bundle
  desc 'Устанавиваем необходимые гемы для приложения.'
  task :bundle do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && bundle"
      info "Гемы установлены."
    end
  end

  # bundle exec cap staging app:yarn
  desc 'Обновляем npm зависимости.'
  task :yarn do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && yarn"
      info "Npm зависимости обновлены."
    end
  end

  # bundle exec cap staging app:clobber
  desc 'Удалить все ранее сгенерированные файлы фронтэнда.'
  task :clobber do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && rails assets:clobber"
      info "Фронтэнд удалён."
    end
  end

  # bundle exec cap staging app:assets
  desc 'Подготавливаем фронтэнд.'
  task :assets do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && NODE_ENV=production bundle exec rails assets:precompile"
      info "Фронтэнд подготовлен."
    end
  end

  # bundle exec cap staging app:db_drop
  desc 'Удаление базы данных.'
  task :db_drop do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RAILS_ENV=production bundle exec rails db:drop"
      info "База данных удалена."
    end
  end

  # bundle exec cap staging app:db_create
  desc 'Создание базы данных.'
  task :db_create do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production bundle exec rails db:create"
      info "База данных создана."
    end
  end

  # bundle exec cap staging app:db_schema_load
  desc 'Загрузка схемы базы данных.'
  task :db_schema_load do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && DISABLE_DATABASE_ENVIRONMENT_CHECK=1 RAILS_ENV=production bundle exec rails db:schema:load"
      info "Схема базы данных загружена."
    end
  end

  # bundle exec cap staging app:db_migrate
  desc 'Миграция.'
  task :db_migrate do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production bundle exec rails db:migrate"
      info "Промигрировали."
    end
  end

  # bundle exec cap staging app:db_seed
  desc 'Загрузка обязательных данных.'
  task :db_seed do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production bundle exec rails db:seed"
      info "Обязательные данные загружены."
    end
  end

  desc 'Загрузка демонстрационных данных.'
  task :db_seed_staging do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production bundle exec rails db:seed:staging"
      info "Демонстрационные данные загружены."
    end
  end

  desc 'Перенос данных на сервер посредством файлов.'
  task :db_seed_transfer do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production bundle exec rails db:seed:transfer"
      info "Перенос данных посредством файлов осуществлён."
    end
  end

  # bundle exec cap staging app:market_import_users
  desc 'Поставить импорт пользователей из маркета в очередь задач.'
  task :market_import_users do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production rails market_import:users"
      info "Импорт пользователей из маркета поставлен в очередь задач."
    end
  end
end




# 
# Управление ассинхронным процессом обработки задач
# 
namespace :worker do

  # bundle exec cap staging worker:stop
  desc 'Остановить.'
  task :stop do
    on roles(:all) do |host|
      worker = fetch(:worker)
      execute "sudo systemctl stop #{worker}"
      info "Обработчик остановлен."
    end
  end

  # bundle exec cap staging worker:start
  desc 'Запустить.'
  task :start do
    on roles(:all) do |host|
      worker = fetch(:worker)
      execute "sudo systemctl start #{worker}"
      info "Обработчик запущен."
    end
  end

  # bundle exec cap staging worker:status
  desc 'Посмотреть состояние обработчика.'
  task :status do
    on roles(:all) do |host|
      worker = fetch(:worker)
      execute "systemctl status #{worker} || echo &>/dev/null"
    end
  end
end




# 
# Управление поисковыми индексами elasticsearch через гем searchkick
# 
namespace :searchkick do

  # bundle exec cap staging searchkick:reindex_all
  desc 'Переиндексировать всё.'
  task :reindex_all do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production rails searchkick:reindex:all"
      info "Переиндексирование завершено."
    end
  end
end




# 
# Глобальные команды управления приложением
# 
namespace :docker_compose do

  # bundle exec cap production docker_compose:stop
  desc 'Полностью остановить приложение.'
  task :stop do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && docker compose stop"
      info "Приложение store полностью остановлено."
    end
  end

  # bundle exec cap production docker_compose:start
  desc 'Запустить приложение.'
  task :start do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && docker compose start"
      info "Приложение store запущено."
    end
  end
end




# 
# Частные команды управления контейнером web
# 
namespace :web do

  # bundle exec cap production web:bundle
  desc 'Установить гемы.'
  task :bundle do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && docker compose run --rm project_web bundle install"
      info "Гемы установлены."
    end
  end

  # bundle exec cap production web:migrate
  desc 'Произвести миграции.'
  task :migrate do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && docker compose run --rm project_web bundle exec rails db:migrate"
      info "Миграции проведены."
    end
  end

  # bundle exec cap production web:seed
  desc 'Выполнение идемпотентной загрузки обязательных данных.'
  task :seed do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && docker compose run --rm project_web bundle exec rails db:seed"
      info "Идемпотентная загрузка обязательных данных выполнена."
    end
  end

  # bundle exec cap production web:assets
  desc 'Подготавливаем фронтэнд.'
  task :assets do
    on roles(:all) do |host|
      # TODO! переписать удаления ассетов так, чтобы не грохалась папки
      # public/assets и public/packs. Потому, что после удаления этих папок они
      # создаются командой assets:precompile из под root и тогда капистрано не
      # может удалить старые релизы (рутовые папки в них) и вообще тогда
      # теряется смысл пробрасывания этих папок в shared
      # 
      # execute "cd #{deploy_to}/current && docker compose run --rm project_web bundle exec rails assets:clobber"
      execute "cd #{deploy_to}/current && docker compose run --rm project_web bundle exec rails assets:precompile"
      info "Фронтэнд подготовлен."
    end
  end
end
