# Sinatra

```sh
gem install sinatra
```

## Использование

Файл _server.rb_

```rb
#!/usr/bin/env ruby
require 'sinatra'

set :port, 3111 # Порт по умолчанию 4567

post '/do_stuff' do
  puts "received: #{params}"
  sleep 2
  puts "Sending response..."
  "The result was: 20"
end

get '/do_stuff' do
  puts "received: #{params}"
  sleep 2
  puts "Sending response..."
  "The result was: 30"
end
```

Файл _query.rb_

```rb
require 'awesome_print'
require 'net/http'

uri = URI('http://localhost:3111/do_stuff')
query = {code: '000046651', angar_code: '000000003'}
uri.query = URI.encode_www_form(query)
response = Net::HTTP.get_response(uri)
if response.code != '200'
  print 'response.message: '.red; puts response.message
end
# data = JSON.parse(response.body)
print 'response.body: '.red; puts response.body


uri = URI('http://localhost:3111/do_stuff')
query = {code: '000046651', angar_code: '000000003'}
uri.query = URI.encode_www_form(query)
response = Net::HTTP.post_form(uri, {})
if response.code != '201'
  print 'response.message: '.red; puts response.message
end
# data = JSON.parse(response.body)
print 'response.body: '.red; puts response.body
```

Запуск сервера: `./server.rb`. Но это не удобно (дрочить консоль) если сидим в
сублайм, то можно настроить скрипты для запуска/перезапуска/остановки билдами
(Ctrl+b). Однако сублайм надо запустить из консоли (`subl`), а не по ярлыку,
чтобы он наследовал переменные окружения (PATH) для того чтобы знать как
запускать ruby башем.

server_start.sh

```sh
#!/usr/bin/env bash

set -eu

if [[ -f pid.file ]]
then
  echo "== Обнаружен pid.file, возможно, тестовый сервер уже запущен, в противном случае удалите pid.file вручную"
else
  sh -c 'echo $$ > pid.file; exec ruby server.rb'
fi

```

server_stop.sh

```sh
#!/usr/bin/env bash

set -eu

if [[ -f "./pid.file" ]]
then
  read pid < "./pid.file"
  kill -9 $pid
  rm ./pid.file
  echo "== Тестовый сервер остановлен"
else
  echo "== Не найден pid.file процесса"
fi
```

server_restart.sh

```sh
#!/usr/bin/env bash

set -eu

if [[ -f "./pid.file" ]]
then
  read pid < "./pid.file"
  kill -9 $pid
  rm ./pid.file
  echo "== Тестовый сервер остановлен"
else
  echo "== Не найден pid.file процесса"
fi

sh -c 'echo $$ > pid.file; exec ruby server.rb'
```
