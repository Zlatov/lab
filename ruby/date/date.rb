# encoding: UTF-8
require 'active_support/all'
require 'awesome_print'
require 'date'

puts 'DateTime'.green
a = DateTime.new()
print 'a: '.red; puts a
a = DateTime.new(2001,2,3,4,5,6)
print 'a: '.red; puts a
a = DateTime.now
print 'a: '.red; puts a
print 'a.hour: '.red; puts a.hour
print 'a.zone: '.red; puts a.zone
print 'a.strftime("%m/%d/%Y"): '.red; puts a.strftime("%m/%d/%Y")

puts 'Time'.green
a = Time.now
print 'a: '.red; puts a
print 'a.hour: '.red; puts a.hour
print 'a.zone: '.red; puts a.zone
print 'a.strftime("%m/%d/%Y"): '.red; puts a.strftime("%m/%d/%Y")

puts 'Арифметика'.blue
puts 'Разность дат DateTime'.green
a = DateTime.new 2000, 1, 1
b = DateTime.new 2000, 1, 2
c = b - a
print 'c: '.red; puts c
c = a - b
print 'c.to_i: '.red; puts c.to_i
puts 'Разность дат Time'.green
a = Time.new 2000, 1, 1
b = Time.new 2000, 1, 2
c = b - a
print 'c: '.red; puts c
c = a - b
print 'c.to_i: '.red; puts c.to_i

puts 'Использование activesupport с DateTime'.green
a = DateTime.new(2000,1,1) - 1.day
print 'a: '.red; puts a
