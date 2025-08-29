# Ctrl + b

require 'awesome_print'
require 'net/http'

url = 'http://localhost:4567/do_stuff'
uri = URI.parse(url)

response = nil
begin
  response = Net::HTTP.start(
    uri.host, uri.port,
    use_ssl: uri.scheme == "https",
    open_timeout: 5,
    write_timeout: 5,
    read_timeout: 5
  ) do |http|
    print 'http.use_ssl?: '.red; puts http.use_ssl?
    request = Net::HTTP::Get.new(uri)
    request["Accept"] = "application/json"
    http.request(request)
  end
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
