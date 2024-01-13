# Action Cable

## Создание / Настройка

```bash
# Создаст два основных файла канала, и отальные, необходимые для работы:
# app/channels/import_channel.rb
# app/javascript/channels/import_channel.js
docker compose exec web bundle exec rails generate channel import --no-test-framework
```

Не забыть кабелине дать редис (REDIS_URL) в файле config/cable.yml.

```yml
# 
development:
  # adapter: async
  adapter: redis
  url: <%= ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" } %>
  channel_prefix: appname

test:
  adapter: test

production:
  adapter: redis
  url: <%= ENV.fetch("REDIS_URL") { "redis://localhost:6379/1" } %>
  channel_prefix: appname_production
```
