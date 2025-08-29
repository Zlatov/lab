# Ctrl + b

require 'awesome_print'
require 'net/http'

url = 'http://localhost:4567/do_stuff'
uri = URI.parse(url)

body = nil
begin
  body = Net::HTTP.get(uri)
rescue => exeption
  print 'exeption.class: '.red; puts exeption.class
  print 'exeption.message: '.red; puts exeption.message
  print 'exeption.backtrace.join("\n"): '.red; puts exeption.backtrace.join("\n")
else
  print 'p body: '.red; p body
  print 'puts body: '.red; puts body
end
