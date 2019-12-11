require 'active_support/time'
require 'awesome_print'
require 'date'

puts 'Установка'.green
a = DateTime.new
b = DateTime.now
c = DateTime.new(2001,2,3,4,5,6,'+0100')
# active_support/time
d = c.change offset: '+0300'
print 'a: '.red; puts a
print 'a.zone: '.red; puts a.zone
print 'b: '.red; puts b
print 'b.zone: '.red; puts b.zone
print 'c: '.red; puts c
print 'c.zone: '.red; puts c.zone
print 'd: '.red; puts d
print 'd.zone: '.red; puts d.zone
