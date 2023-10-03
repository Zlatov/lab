#!/usr/bin/env ruby

# Запуск sinatra сервера из консоли lab: ./ruby/http/_tasks/sinatra.rb

require 'sinatra'

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
