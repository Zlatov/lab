require 'awesome_print'
require 'net/http'
require 'uri'
require 'json'

uri = URI('https://id.vk.com/oauth2/auth')
http = Net::HTTP.new(uri.host, uri.port)
http.read_timeout = 5
http.use_ssl = true
request = Net::HTTP::Post.new(uri.path)
request['content-type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
request.set_form_data(
  'grant_type' => 'authorization_code',
  'code_verifier' => 'codecodecodecodecodecodecodecodecodecodecodecodecodecodecodecodecodecodecodecode',
  'redirect_uri' => 'https://zenonline.ru',
  'code' => '',
  # 'ip' => '',
  'client_id' => '',
  'device_id' => '',
  'state' => 'XXXRandomZZZ'
)
response = http.request(request)
if !response.is_a?(Net::HTTPSuccess)
  print 'response.message: '.red; puts response.message
  print 'response.body: '.red; puts response.body
  exit # fail 'fail'
end
answer = response.body
print 'answer: '.red; puts answer
