require 'awesome_print'
require 'net/http'

require_relative 'temp_key'
print '$key: '.red; puts $key

uri = URI.parse('https://gptunnel.ru/v1/balance')


http = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.instance_of?(URI::HTTPS), read_timeout: 5)
print 'http: '.red; puts http
print 'http.use_ssl?: '.red; puts http.use_ssl?
print 'http.read_timeout: '.red; puts http.read_timeout


request = Net::HTTP::Get.new uri
request['Authorization'] = $key
print 'request: '.red; puts request


response = http.request(request)
print 'response: '.red; puts response
print 'response.class: '.red; puts response.class
print 'response.is_a?(Net::HTTPOK): '.red; puts response.is_a?(Net::HTTPOK)
print 'response.each_header.to_h: '.red; puts response.each_header.to_h
print 'response.code: '.red; puts response.code
print 'response.message: '.red; puts response.message
print 'response.body: '.red; puts response.body
