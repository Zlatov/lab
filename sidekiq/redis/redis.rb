# Удалить все сообщения о проваленых задачах
Sidekiq.redis {|c| c.del('stat:failed') }
# Аналогично:
Sidekiq::Stats.new.reset('failed')
