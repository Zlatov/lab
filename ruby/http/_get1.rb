# Ctrl + b

require 'awesome_print'
require 'net/http'

url = 'http://localhost:4567/do_stuff'
uri = URI.parse(url)

response = nil
begin
  response = Net::HTTP.get_response(uri)
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
