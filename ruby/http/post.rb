exit 0

require 'net/http'

# Посмотреть все заголовки cURL консольной утилиты: --verbose
# curl --verbose "https://ya.ru/api" -d "param=true"

uri = URI.parse("https://id.vk.com/oauth2/auth")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.ssl_version = :TLSv1
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
http.verify_mode = OpenSSL::SSL::VERIFY_PEER # please don't use verify_none.
http.ca_file = '/etc/ssl/certs/ca-certificates.crt'
http.ca_path = '/etc/ssl/certs'

request = Net::HTTP::Post.new(uri.path)
request = Net::HTTP::Post.new(uri)
request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36"
request["User-Agent"] = "curl/7.29.0"
request["Accept"] = "*/*"
request["Host"] = "id.vk.com"

# Передача параметров в теле запроса
# 
# Если используется метод set_form_data, то этот заголовок добавляется автоматически.
request['content-type'] = 'application/x-www-form-urlencoded'
# Возможно необходимо кодировать значения передаваемых параметров.
string_params = hash_params.map{|k, v| "#{k}=#{CGI.escape(v)}"}.join('&')
request.body = string_params
# Или через метод set_form_data:
# Так значения кодируются автоматически?:
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

print 'response.code: '.red; puts response.code
print 'response.message: '.red; puts response.message
print 'response.body: '.red; puts response.body

if response.is_a? Net::HTTPRedirection
  uri = URI("https://id.vk.com#{response['location']}")
  redirect_response = Net::HTTP.get_response(uri)

  print 'redirect_response.code: '.red; puts redirect_response.code
  print 'redirect_response.message: '.red; puts redirect_response.message
  print 'redirect_response.body: '.red; puts redirect_response.body
end
