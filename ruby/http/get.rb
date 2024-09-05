require 'awesome_print'
require 'net/http'

uri = URI.parse('http://mini-light.local/admin#go')
uri = URI.parse('https://ya.ru/')
uri = URI.parse('https://nettakogodomena123.com/')
uri = URI.parse('http://mini-light.local/#target')
uri = URI.parse('http://mini-light.local/api/v1/affiliates')
uri = URI.parse('http://mini-light.local/admin/mini_applications/connection?id=1')
query = {
  id: 123,
  code: '000123',
  text: "asd\nzxc",
  url: 'https://русский-ёж.рф/статьи'
}
uri.query = URI.encode_www_form(query)
print 'uri.class: '.red; puts uri.class
print 'uri.scheme: '.red; puts uri.scheme
print 'uri.port: '.red; puts uri.port
print 'uri.host: '.red; puts uri.host
print 'uri.path: '.red; puts uri.path
print 'uri.query: '.red; puts uri.query
print 'uri.fragment: '.red; puts uri.fragment
print 'uri: '.red; puts uri

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true if uri.instance_of? URI::HTTPS
http.read_timeout = 5

response = nil
begin
  response = http.request_get(uri)
rescue => exeption
  print 'exeption.class: '.red; puts exeption.class
  print 'exeption.message: '.red; puts exeption.message
  print 'exeption.backtrace.join("\n"): '.red; puts exeption.backtrace.join("\n")
else
  print 'response: '.red; puts response
  print 'response.class: '.red; puts response.class
  print 'response.is_a?(Net::HTTPOK): '.red; puts response.is_a?(Net::HTTPOK)
  print 'response.each_header.to_h: '.red; puts response.each_header.to_h
  print 'response.body: '.red; puts response.body
end
