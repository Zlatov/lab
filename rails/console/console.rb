rails c
rails s -p 3001
rails routes
rails dev:cache # включить/выключить кеширование в девелопе
rails assets:clobber # удалить сгенерированные ранее ассеты
rails assets:precompile
bundle exec rails -T -A




# Эмулировать HTTP запрос к приложению
> app.get '/posts/1'
> response = app.response
# you now have a rails response object much like the integration tests

> response.body            # get you the HTML
> response.cookies         # hash of the cookies




# Вызвать метод контроллера (экшн)
Controller.new.send :act_name




# Отключить вывод запросов в дев консоли
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil
# ActiveRecord.запросы ...
ActiveRecord::Base.logger = old_logger
