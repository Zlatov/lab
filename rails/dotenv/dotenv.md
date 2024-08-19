```rb
# Gemfile
# Для формирования переменных среды.
gem 'dotenv-rails', groups: [:development, :test, :production]

# config/application.rb
require 'dotenv'
Dotenv.load('variables.env')

# .gitignore
variables.env

# app/controllers/..._controller.rb
# Если nil - нормальное значение для данной переменной.
some_param = ENV['SCOPE_SOME_PARAM']
# Если приложение не должно работать со значением nil - эта строка бросит исключение.
some_param = ENV.fetch('SCOPE_SOME_PARAM')
# Если приложение не может работать со значением nil но может со значением по умолчанию.
some_param = ENV.fetch('SCOPE_SOME_PARAM', 'default_value')
some_param = ENV.fetch('SCOPE_SOME_PARAM') { 'default_value' }
```
