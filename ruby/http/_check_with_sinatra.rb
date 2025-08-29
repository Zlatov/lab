#!/usr/bin/env ruby

# cdlab
# gem install sinatra
# gem update sinatra
# ./ruby/http/_check_with_sinatra.rb

require 'sinatra'
require 'awesome_print'

set :environment, :production # Без этой настройки запрещаются запросы (403) из докер-контейнеров.
# use Rack::Protection::HostAuthorization, allowed_hosts: [".*"] # разрешить любые хосты
# set :protection, false
# set :protection, :except => [:all]
# Sinatra::Application.middleware.clear
# use Rack::Protection::HostAuthorization, :allow => ['localhost', '127.0.0.1', 'host.docker.internal']
set :port, 4567 # Порт по умолчанию 4567
set :bind, '0.0.0.0' # Прослушиваем со всех IP, в том числе из докер-контейнеров (не 127.0.0.1)

get '/do_stuff' do
  print 'params: '.red; p params

  accept_header = request.env['HTTP_ACCEPT']
  print 'Заголовок "Accept" в синатре => "HTTP_ACCEPT": '.red; puts accept_header

  sleep 2

  puts 'Отправляем ответ'.green
  "Текстовый ответ"
end

post '/do_stuff' do
  print 'params: '.red; p params

  accept_header = request.env['HTTP_ACCEPT']
  print 'Заголовок "Accept" в синатре => "HTTP_ACCEPT": '.red; puts accept_header

  sleep 2

  puts 'Отправляем ответ'.green
  "Текстовый ответ"
end
