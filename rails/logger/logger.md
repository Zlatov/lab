## Уровни лога, 

:debug, :info, :warn, :error, :fatal, :unknown

```rb
config.log_level = :warn # In any environment initializer, or
Rails.logger.level = 0 # at any time
```

```ruby
# Запись в стандартный лог
logger.error       "#{e.message}\n#{e.backtrace.join("\n")}" # в контроллере
Rails.logger.error "#{e.message}\n#{e.backtrace.join("\n")}" # хер знает откуда

logger.error ([e.message] + e.backtrace).join("\n")
```
