require 'awesome_print'
require 'net/http'

require_relative 'temp_key'
print '$key: '.red; puts $key

uri = URI.parse('https://gptunnel.ru/v1/chat/completions')
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true

request = Net::HTTP::Post.new(uri.path)
request['Authorization'] = $key
request.set_form_data(
  'model' => 'gpt-3.5-turbo',
  # 'messages' => [
  #   {
  #     role: 'system',
  #     content: 'My name is Robert.'
  #   },
  #   {
  #     role: 'user',
  #     content: 'как тебя зовут'
  #   }
  # ]
)

response = http.request(request)

print 'response.code: '.red; puts response.code
print 'response.message: '.red; puts response.message
print 'response.body: '.red; puts response.body

# if response.is_a? Net::HTTPRedirection
#   uri = URI("https://id.vk.com#{response['location']}")
#   redirect_response = Net::HTTP.get_response(uri)

#   print 'redirect_response.code: '.red; puts redirect_response.code
#   print 'redirect_response.message: '.red; puts redirect_response.message
#   print 'redirect_response.body: '.red; puts redirect_response.body
# end
