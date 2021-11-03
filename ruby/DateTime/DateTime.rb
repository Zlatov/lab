require 'active_support/time'
require 'awesome_print'
require 'date'

puts 'Установка'.green
a = DateTime.new
b = DateTime.now
c = DateTime.new(2001,2,3,4,5,6,'+0100')
d = c.change offset: '+0300'
print 'a: '.red; puts a
print 'a.zone: '.red; puts a.zone
print 'a.hour: '.red; puts a.hour
print 'b: '.red; puts b
print 'b.zone: '.red; puts b.zone
print 'c: '.red; puts c
print 'c.zone: '.red; puts c.zone
print 'd: '.red; puts d
print 'd.zone: '.red; puts d.zone
a = DateTime.new(2001,2,3,4,5,6)
print 'a: '.red; puts a
print 'a.strftime("%m/%d/%Y"): '.red; puts a.strftime("%m/%d/%Y")
# exit

puts 'Изменение даты от заданной на указанное количество дней/часов...'.green
puts DateTime.current.advance(:days => +2, :hours => +8)
puts Date.current.advance(:weeks => +2)
# exit

puts 'Time'.green
a = Time.now
print 'a: '.red; puts a
print 'a.hour: '.red; puts a.hour
print 'a.zone: '.red; puts a.zone
print 'a.strftime("%m/%d/%Y"): '.red; puts a.strftime("%m/%d/%Y")
# exit

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

puts 'Интервал дат'.green
a = DateTime.strptime('2018-12-30', "%Y-%m-%d")
b = DateTime.strptime('2019-01-22', "%Y-%m-%d")
print 'a: '.red; puts a
print 'b: '.red; puts b
c = a
while c <= b do
  puts c.strftime("%Y-%m-%d")
  c += 1.day
end

