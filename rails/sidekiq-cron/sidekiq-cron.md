```rb
# Gemfile:
gem 'sidekiq-cron'


# config/schedule.yml
make_advcatalog_switch_worker:
  cron: "* * * * *"
  class: "MakeAdvcatalogSwitchWorker"
  queue: "default"


# config/initializers/sidekiq.rb:
Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
  # Загружаем расписание при старте Sidekiq
  Rails.application.reloader.to_prepare do
    schedule_file = "config/schedule.yml"
    if File.exist?(schedule_file)
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
      puts "✅ Loaded #{Sidekiq::Cron::Job.all.size} cron jobs".yellow
    else
      puts "❌ Schedule file not found: #{schedule_file}".red
    end
  end
end

```
