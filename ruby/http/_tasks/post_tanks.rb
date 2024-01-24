require 'awesome_print'
require 'net/http'
require 'uri'
require 'json'

# uri = URI('http://localhost:3111/action')
# print 'uri.port: '.red; puts uri.port
# http = Net::HTTP.new(uri.host, uri.port)
# http.read_timeout = 15
# print 'http: '.red; puts http
# response = http.post(uri.path, nil)
# print 'response: '.red; puts response
# fail 'message' if !response.is_a?(Net::HTTPSuccess)
# answer = response.body
# print 'answer: '.green; puts answer

# uri = URI('http://localhost:3111/action')
# http = Net::HTTP.new(uri.host, uri.port)
# http.read_timeout = 5
# response = http.request_post(uri.path, nil)
# print 'response.body: '.red; puts response.body

# uri = URI('http://localhost:3111/action')
# http = Net::HTTP.new(uri.host, uri.port)
# http.read_timeout = 5
# req = Net::HTTP::Post.new(uri.path.concat("?access_token=asdasdasdas"))
# # req['Content-Type'] = 'application/json'
# # req['charset'] = 'UTF-8'
# req.set_form_data('asd' => '1000', 'asdsa[asdasd]' => 'as,das')
# res = http.request(req)

# exit

uri = URI('https://tanki.su/wotpbe/tankopedia/api/vehicles/by_filters/')
# params = 'filter[nation]=ussr&filter[type]=&filter[role]=&filter[tier]=5&filter[language]=ru&filter[premium]=0,1'
http = Net::HTTP.new(uri.host, uri.port)
http.read_timeout = 5
http.use_ssl = true
request = Net::HTTP::Post.new(uri.path)
request['content-type'] = 'application/x-www-form-urlencoded; charset=UTF-8'
request.set_form_data(
  'filter[nation]' => 'ussr',
  'filter[type]' => '',
  'filter[role]' => '',
  'filter[tier]' => '5',
  'filter[language]' => 'ru',
  'filter[premium]' => '0,1'
)
response = http.request(request)

if !response.is_a?(Net::HTTPSuccess)
  print 'response.message: '.red; puts response.message
  print 'response.body: '.red; puts response.body
  exit # fail 'fail'
end

answer = response.body
print 'answer: '.red; puts answer
