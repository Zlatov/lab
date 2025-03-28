# encoding: UTF-8
require 'json'
require_relative '../colorize/colorize'

puts 'Json текст в переменную ruby'.green

a = '[{"id":1,"name":"Nick"},{"id":"1","name":"\\u003cb\\u003eMikle\\u003c/b\\u003e"}]'
b = JSON.parse a
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0

puts 'Переменную ruby в текст json'.green

b = ['asd']
jb = b.to_json
print 'jb: '.light_blue; puts jb

c = [{asd:'asd'},{"id"=>1}]
jc = JSON.pretty_generate c
print 'jc: '.light_blue; puts jc

a = {mtime:123}
b = a.to_json
p b

# symbolize_names
p JSON.parse('{"key": "value"}', symbolize_names: true)

a = '{"a": true}'
b = JSON.parse a
print 'b["a"].class.name: '.red; puts b["a"].class.name
