# Ctrl + b

require 'awesome_print'
require 'net/http'

url = 'http://domain.com/some/path/file.ext?id=1&name=string#go'
uri = URI.parse(url)
query = {
  id: 123,
  code: '000123',
  text: "asd\nzxc",
  url: 'https://русский-ёж.рф/статьи'
}
uri.query = URI.encode_www_form(query)
print 'uri.class: '.red; puts uri.class
print 'uri.scheme: '.red; puts uri.scheme
print 'uri.port: '.red; puts uri.port
print 'uri.host: '.red; puts uri.host
print 'uri.path: '.red; puts uri.path
print 'uri.query: '.red; puts uri.query
print 'uri.fragment: '.red; puts uri.fragment
print 'uri: '.red; puts uri
# exit 0
