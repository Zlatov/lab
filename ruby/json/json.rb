# encoding: UTF-8
require 'json'
require_relative '../colorize/colorize'

puts 'Json текст в переменную ruby'.green

ja = '[{"id":1,"name":"Nick"},{"id":"1","name":"Mikle"}]'
a = JSON.parse ja
print 'a: '.light_blue; p a

puts 'Переменную ruby в текст json'.green

b = ['asd']
jb = b.to_json
print 'jb: '.light_blue; puts jb

c = [{asd:'asd'},{"id"=>1}]
jc = JSON.pretty_generate c
print 'jc: '.light_blue; puts jc
