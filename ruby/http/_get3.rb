# Ctrl + b

require 'awesome_print'
require 'net/http'

url = 'http://localhost:4567/do_stuff'
uri = URI.parse(url)
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = (uri.scheme == "https")

# По умолчанию: 60 секунд (бесконечное ожидание). Рекомендуется выставить
# open_timeout! Ожидаем установления TCP-соединения с сервером.
http.open_timeout = 5
# По умолчанию: 60 секунд. Мы пишем в сокет, слишком долго = не нормально:
http.write_timeout = 10
# По умолчанию: 60 секунд. Ждём ответ от сервера. Это ограничение "времени
# бездействия", если ответ уже начал приходить, то ограничение "сбрасывается"
# для каждой части ответа.
http.read_timeout  = 30

print 'http.use_ssl?: '.red; puts http.use_ssl?
request = Net::HTTP::Get.new(uri)
request["Accept"] = "application/json"
print 'request: '.red; puts request
print 'request.size: '.red; puts request.size
print 'request.content_length: '.red; puts request.content_length
print 'request.each_header: '.red; puts request.each_header

response = nil
begin
  response = http.request(request)
  http.finish if http.active? # важно: соединение нужно закрыть вручную
rescue => exeption
  print 'exeption.class: '.red; puts exeption.class
  print 'exeption.message: '.red; puts exeption.message
  print 'exeption.backtrace.join("\n"): '.red; puts exeption.backtrace.join("\n")
else
  print 'response: '.red; puts response
  print 'response.class: '.red; puts response.class
  print 'response.is_a?(Net::HTTPOK): '.red; puts response.is_a?(Net::HTTPOK)
  print 'response.each_header.to_h: '.red; puts response.each_header.to_h
  print 'response.code: '.red; puts response.code
  print 'response.message: '.red; puts response.message
  print 'puts response.body: '.red; puts response.body
  print 'p    response.body: '.red; p response.body
end
