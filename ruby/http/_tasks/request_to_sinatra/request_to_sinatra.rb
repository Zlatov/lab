# Запуск этого файла: Ctrl + b
require 'awesome_print'
require 'net/http'


uri = URI('http://localhost:4567/do_stuff')
query = {code: '000046651', angar_code: '000000003'}
uri.query = URI.encode_www_form(query)
response = Net::HTTP.get_response(uri)
if response.code != '200'
  print 'response.message: '.red; puts response.message
end
# data = JSON.parse(response.body)
print 'response.body: '.red; puts response.body


uri = URI('http://localhost:4567/do_stuff')
query = {code: '000046651', angar_code: '000000003'}
uri.query = URI.encode_www_form(query)
response = Net::HTTP.post_form(uri, {})
if response.code != '201'
  print 'response.message: '.red; puts response.message
end
# data = JSON.parse(response.body)
print 'response.body: '.red; puts response.body
