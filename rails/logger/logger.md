```ruby
# Запись в стандартный лог
logger.error       "#{e.message}\n#{e.backtrace.join("\n")}" # в контроллере
Rails.logger.error "#{e.message}\n#{e.backtrace.join("\n")}" # хер знает откуда

logger.error ([e.message] + e.backtrace).join("\n")
```
