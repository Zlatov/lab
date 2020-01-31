# 
# Настройка соединения
# 
set :deploy_to, ENV["ZENONLINE_CAP_STAGING_PATH"]
set :tmp_dir, ENV["ZENONLINE_CAP_STAGING_TEMP"]
server ENV["ZENONLINE_CAP_STAGING_IP"],
  user: ENV["ZENONLINE_CAP_STAGING_USER"],
  ssh_options: {
    user: ENV["ZENONLINE_CAP_STAGING_USER"],
    keys: %w(~/.ssh/id_rsa),
    forward_agent: false,
    auth_methods: %w(publickey)
  }

set :branch, :master # из какой ветки лить
set :branch, ENV['BRANCH'] if ENV['BRANCH']

set :keep_releases, 5 # количество хранимых версий (для отката cap rollback)




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




namespace :app do

  desc 'Остановить.'
  task :stop do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && [[ -a tmp/pids/server.pid ]] && pumactl stop || echo &>/dev/null"
      info "Приложение остановлено."
    end
  end

  desc 'Запустить.'
  task :start do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production bundle exec puma -d"
      info "Приложение запущено."
    end
  end

  desc 'Перезапустить.'
  task :restart do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production pumactl restart"
      info "Приложение запущено."
    end
  end

  desc 'Перезапустить воркеры поочерёндно (годно для перезапуска без миграций).'
  task :phased_restart do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && RAILS_ENV=production pumactl phased-restart"
      info "Приложение запущено."
    end
  end

  desc 'Устанавиваем необходимые гемы для приложения.'
  task :bundle do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && bundle"
      info "Гемы установлены."
    end
  end

  desc 'Обновляем npm зависимости.'
  task :yarn do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && yarn"
      info "Npm зависимости обновлены."
    end
  end

  desc 'Подготавливаем фронтэнд/pipeline.'
  task :pipeline do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && rm -rf ./public/assets"
      execute "cd #{deploy_to}/current && NODE_ENV=production bundle exec rails assets:precompile"
      info "Фронтэнд/pipeline подготовлен."
    end
  end

  desc 'Подготавливаем фронтэнд/webpack.'
  task :webpack do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && rm -rf ./public/packs"
      execute "cd #{deploy_to}/current && NODE_ENV=production ./bin/webpack"
      info "Фронтэнд/webpack подготовлен."
    end
  end

  # desc 'Определить состояние.'
  # task :status do
  #   on roles(:all) do |host|
  #     execute "cd #{deploy_to}/current/market && ./bash/status/app.sh"
  #   end
  # end

  desc 'Удаление базы данных.'
  task :db_drop do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && DISABLE_DATABASE_ENVIRONMENT_CHECK=1 bundle exec rails db:drop"
      info "База данных удалена."
    end
  end

  desc 'Создание базы данных.'
  task :db_create do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && bundle exec rails db:create"
      info "База данных создана."
    end
  end

  desc 'Загрузка схемы базы данных.'
  task :db_schema_load do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && bundle exec rails db:schema:load"
      info "Схема базы данных загружена."
    end
  end

  desc 'Миграция.'
  task :db_migrate do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && bundle exec rails db:migrate"
      info "Промигрировали."
    end
  end

  desc 'Загрузка обязательных данных.'
  task :db_seed do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && bundle exec rails db:seed"
      info "Обязательные данные загружены."
    end
  end

  desc 'Загрузка демонстрационных данных.'
  task :db_seed_staging do
    on roles(:all) do |host|
      execute "cd #{deploy_to}/current && bundle exec rails db:seed:staging"
      info "Демонстрационные данные загружены."
    end
  end
end

before :deploy, 'deploy:branch'
before :deploy, 'app:stop' unless ENV['SKIP_HOOKS']

after :deploy, 'app:bundle' unless ENV['SKIP_HOOKS']
after :deploy, 'app:yarn' unless ENV['SKIP_HOOKS']
after :deploy, 'app:pipeline' unless ENV['SKIP_HOOKS']
after :deploy, 'app:webpack' unless ENV['SKIP_HOOKS']
after :deploy, 'app:db_drop' unless ENV['SKIP_HOOKS']
after :deploy, 'app:db_create' unless ENV['SKIP_HOOKS']
after :deploy, 'app:db_schema_load' unless ENV['SKIP_HOOKS']
after :deploy, 'app:db_migrate' unless ENV['SKIP_HOOKS']
after :deploy, 'app:db_seed' unless ENV['SKIP_HOOKS']
after :deploy, 'app:db_seed_staging' unless ENV['SKIP_HOOKS']

after :deploy, 'app:start' unless ENV['SKIP_HOOKS']
