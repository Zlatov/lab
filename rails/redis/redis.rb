# https://www.rubyguides.com/2019/04/ruby-redis/

require 'redis'
require 'awesome_print'
require 'active_support/all'

redis = Redis.new(host: "localhost")

puts 'Возвращает строку при записи'.green
a = redis.set("a", 1)
print 'a: '.red; puts a
print 'a.class: '.red; puts a.class

puts 'Возвращает строку при чтении'.green
a = redis.get("a")
print 'a: '.red; puts a
print 'a.class: '.red; puts a.class
redis.set("a", {asd: 3})
a = redis.get("a")
print 'a: '.red; puts a
print 'a.class: '.red; puts a.class
