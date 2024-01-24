require 'awesome_print'
require 'uri'
require 'rack/utils'

puts 'Инстанс URI из строки'.green
url = 'https://zenonline.ru/events/5398'
uri = URI.parse(url)
print 'uri.inspect: '.red; puts uri.inspect
print 'uri.to_s.inspect: '.red; puts uri.to_s.inspect

url = 'https://zenonline.ru/events/5398'
uri = URI url
print 'uri.inspect: '.red; puts uri.inspect
print 'uri.to_s.inspect: '.red; puts uri.to_s.inspect


puts 'Инстанс URI без домена'.green
url = '/events/5398'
uri = URI url
print 'uri.inspect: '.red; puts uri.inspect
print 'uri.to_s.inspect: '.red; puts uri.to_s.inspect


puts 'Добавление параметра'.green
url = 'http://foo.com/posts?id=30&limit=5#time=1305298413'
url = 'http://foo.com/posts#time=1305298413'
url = '/posts?id=30&limit=5'
uri = URI url
print 'uri.scheme: '.red; puts uri.scheme
print 'uri.host: '.red; puts uri.host
print 'uri.path: '.red; puts uri.path
print 'uri.query: '.red; puts uri.query.inspect
print 'uri.fragment: '.red; puts uri.fragment
# uri.query = URI.encode_www_form(erid: 'asd865sda5f43asdf4@#$%^&') # Заменит существующие параметры
uri.query = URI.encode_www_form CGI::parse(uri.query || '').merge(erid: 'asd865sda5f43asdf4@#$%^&')
print 'uri.to_s: '.red; puts uri.to_s

puts 'Параметры в хэш'.green
url = 'http://site.local/admin/model?page=2&sorter0=level%2Casc&sorter1=nation%2Cdesc'
uri = URI(url)
params = uri.query
# Этот метод пытается все параметры свернуть в массив
# Скорее всего позволит правильно обрабатывать такой шаблон:
# 'a[]=1&a[]=2'
hash_params = CGI::parse(params)
# Этот метод не пытается сразу обрабатывать параметры как массив
hash_params2 = Rack::Utils.parse_nested_query(params)
print 'params: '.red; puts params
print 'hash_params: '.red; puts hash_params
print 'hash_params2: '.red; puts hash_params2
# exit 0

a = 'Русский ёж'
b = URI.encode_www_form_component a
print 'b: '.red; puts b
