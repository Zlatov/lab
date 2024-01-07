# !/usr/bin/env ruby
require 'sinatra'
require 'json'
require 'awesome_print'

set :port, 3111 # Порт по умолчанию 4567

# class Server < Sinatra::Base

# print 'Process.pid: '; puts Process.pid
# File.write 'pid.file', Process.pid

  # def self.run!
  #   print 'settings.host: '.red; puts settings.host
  #   print 'settings.port: '.red; puts settings.port
  #   # Launchy.open("http://#{settings.host}:#{settings.port}/")
  #   print 'Process.pid: '; puts Process.pid
  #   super
  # end

post '/action' do
  puts "received: #{params}"
  sleep 2
  puts "Sending response..."
  "The result was: 20"
end

get '/action' do
  puts "received: #{params}"
  sleep 2
  puts "Sending response..."
  "The result was: 30"
end

get '/json' do
  content_type :json
  {asd: :zxc}.to_json
end

post '/json' do
  content_type :json
  {post: :true}.to_json
end

# end

