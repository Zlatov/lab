require 'awesome_print'
require 'net/http'

client_id = '52135123'
redirect_uri = 'http://localhost/home/accept_token'

code = 'vk2.a.5mZfea4I2nPgsNH6cMVcfjbg9bX4qgSrFAGejeyPF4yCuVISOCLelyXWnwUF7TgQZLoJI-UO-oU0dh1CCWrSktJLKRKC5tuYUPrajZd4_x4BJ_x-eAEkMXiDbFC_kDPpeLmrG89lQCnY0yJSMqNu6hFgY-26soL2JwrM0qUn2PsIV0JL6PgtvxM6ZEBt-4lT__X7stxVC6nruO4TXoMAYA'
device_id = 'LYevuorebka5-IDkw1Y-YWxY-NBYcdfzMKU0srmUSc9WuxcsuAayeuycNMYg3xSR5yfFSO5WMJ8sd0E2-dsQ_A'
code_verifier = '6b08232df676c452241941e33df8c7a0fff9bd09aa8a04ee9a7ff5676b99aa33aafc7e9e4d5ca646e28fa82d097c6769f6b8c2911aee344c817c4c44a227c14f'
state = 'f649e3ea58cff844021dc4f8c4df481b'


# С помощбю консольного cURL = получаем хороший ответ (json, сейчас не важно что в ответе текст о ошибке - ответ есть!)
curl = "curl \"https://id.vk.com/oauth2/auth\" -d \"" +
  "client_id=#{client_id}&grant_type=authorization_code&" +
  "code_verifier=#{code_verifier}&device_id=#{device_id}&" +
  "state=#{state}&" +
  "code=#{code}&redirect_uri=#{redirect_uri}\""
result = %x(#{curl})
print 'result УРА: '.red; puts result


# С помощью ruby Net::Http = получаем редирект (в редиректе тупо html страница с ошибкой, что мы не так лезем в АПИ)
uri = URI.parse("https://id.vk.com/oauth2/auth")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
request = Net::HTTP::Post.new(uri)
request.set_form_data(
  "client_id" => client_id,
  "code" => code,
  "code_verifier" => code_verifier,
  "device_id" => device_id,
  "grant_type" => "authorization_code",
  "redirect_uri" => redirect_uri,
  'state' => state
)
response = http.request(request)

print 'response.code ХРЕН: '.red; puts response.code
print 'response.message: '.red; puts response.message
print 'response.body: '.red; puts response.body


# if response.is_a? Net::HTTPRedirection
#   uri = URI("https://id.vk.com#{response['location']}")
#   redirect_response = Net::HTTP.get_response(uri)

#   print 'redirect_response.code: '.red; puts redirect_response.code
#   print 'redirect_response.message: '.red; puts redirect_response.message
#   print 'redirect_response.body: '.red; puts redirect_response.body
#   print 'response[location]: '.red; puts response['location']
# end
