# encoding: UTF-8
require 'awesome_print'
require 'net/http'
require 'uri'
require 'json'
require 'rack'

uri = URI("https://api.site.com/api.dll")
print 'uri: '.red; puts uri
print 'uri: '.red; puts uri.class
print 'URI: '.red; puts URI

# postData = Net::HTTP.post_form(URI.parse('http://lab.local/php/post/post.php'), {'postKey'=>'postValue'})
# print 'postData.body: '.red; puts postData.body

# uri = URI("http://lab.local/php/post/post.php")
# http = Net::HTTP.new(uri.host, uri.port)
# http.use_ssl = false
# request = Net::HTTP::Post.new(uri.path)
# request["HEADER1"] = 'VALUE1'
# request["HEADER2"] = 'VALUE2'

# response = http.request(request)
# print 'response: '.red; puts response

response = Net::HTTP.post(
  URI('http://lab.local/php/post/post.php'),
  # { "q" => "ruby", "max" => "50" }.to_json,
  # { "q" => "ruby", "max" => "50" }.to_query,
  # "asd=asd",
  Rack::Utils.build_query({ "q" => "ruby", "max" => "50" })
  # "Content-Type" => "application/json"
  # "Content-Type" => "application/x-www-form-urlencoded"
  # "Content-Type" => "text/plain"
)

print 'response: '.red; puts response
print 'response.body: '.red; puts response.body
# print 'response.body: '.red; p JSON.parse(response.body)['a']

response = Net::HTTP.post_form(
  URI('http://lab.local/php/post/post.php'),
  { "q" => "ruby", "max" => "50" }
)

print 'response: '.red; puts response
print 'response.body: '.red; puts response.body
# print 'response.body: '.red; p JSON.parse(response.body)['a']


puts 'GET'.green
uri = URI('https://zenonline.ru/products/bl')
query = {code: '000046651', angar_code: '000000003'}
uri.query = URI.encode_www_form(query)
response = Net::HTTP.get_response(uri)
if response.code != '200'
  print 'response.message: '.red; puts response.message
end
data = JSON.parse(response.body)
print 'data: '.red; puts data
# exit

puts 'POST'.green
# uri = URI("https://zenonline.ru/trader/000046651")
uri = URI("http://zenonline.local/trader/000046651")
response = Net::HTTP.post_form(uri, {})
if response.code != '201'
  print 'response.message: '.red; puts response.message
  return
end
data = JSON.parse(response.body)
print 'data: '.red; puts data
# exit
