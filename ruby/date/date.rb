# encoding: UTF-8
require 'active_support/all'
require 'awesome_print'
require 'date'

# def set_stat_date string_date
#   string_date ||= Time.now.strftime("%Y-%m-%d")
#   @stat_date = DateTime.strptime(string_date, "%Y-%m-%d")
#   puts "Дата парсинга: #{@stat_date.strftime("%Y-%m-%d").blue}."
# end

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
