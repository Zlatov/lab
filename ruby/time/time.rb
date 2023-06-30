# encoding: UTF-8
require_relative '../string/declension'

require 'awesome_print'
# require 'active_support'
# require 'active_support/core_ext'
require 'active_support/all'


puts 'Текущее время'.green
a = Time.current
b = Time.new
c = Time.now
d = a.year
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
# exit


puts 'В секундах, микросекунд, часовая зона'.green
a = Time.now
b = Time.now.to_i
c = Time.now.zone
d = Time.now.utc
e = Time.utc(2012,3,3,3,3,3,999999).usec
f = Time.now.utc.usec
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
print 'd: '.red; p d
print 'e: '.red; p e
print 'f: '.red; p f
a = Time.current
b = Time.current.to_i
c = Time.current.zone
d = Time.current.utc
e = Time.current.usec
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
print 'd: '.red; p d
print 'e: '.red; p e
# exit


puts 'new, at - Задать время'.green
a = Time.new()
b = Time.new(2000, 1, 1, 0, 0, 0, "+03:00")
c = Time.at(1653042556, 333)
d = Time.at(1653042556, 333, :millisecond)
e = Time.at(1653042556, 333, :microsecond)
f = Time.at(1653042556, 333, :microsecond, in: -3*60*60)
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
print 'd: '.red; p d
print 'e: '.red; p e
print 'f: '.red; p f
# exit


puts 'sleep - пауза выполнения кода.'.green
# puts 'сек'.blue
# sleep 1
# puts '1/2 сек'.blue
# sleep 0.5
# puts '1/2 сек'.blue
# sleep 0.5
# puts 'yay'.blue
# # exit


puts 'Разница времени'.green
a = Time.new(2000, 1, 1, 0, 0, 0, "+03:00")
b = Time.at(946674000, 333333)
c = b - a
d = c.to_i
e = Time.new(2000, 1, 1, 0, 0, 0, "+03:00").to_i
print 'a: '.blue; p a
print 'b: '.blue; p b
print 'c: '.blue; p c
print 'd: '.blue; p d
print 'e: '.blue; p e
# exit

puts 'Узнать разницу в годах'.green
a = Time.new(2020, 2, 29, 12, 12, 12, "+03:00")
b = a + 1.years - 1.seconds
c = ActiveSupport::Duration.build(b - a).parts
diff = b.year - a.year
diff += a + diff.years > b ? -1 : 0
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'diff: '.red; puts diff
# exit

puts 'Узнать разницу в меяцах'.green
a = Time.new(2020, 11, 29, 12, 12, 12, "+03:00")
b = a + 2.month - 1.seconds
diff = (b.month - a.month) % 12
diff += a + diff.months > b ? -1 : 0
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'diff: '.red; puts diff
# exit

puts 'Перевод разницы в дни, часы, ... секунды'.green
a = Time.new(2000, 1, 1, 0, 0, 0, "+03:00")
b = Time.new(2000, 1, 1, 1, 1, 1, "+03:00")
diff = (b - a).to_i
if diff >= 86400
  days = diff/86400
  days_w = days.declension 'дней,день,дня'
  puts "#{days} #{days_w} назад"
elsif diff < 10
  puts 'Только что'
else
  text = ''
  hours = diff / 3600
  diff -= hours * 3600
  minutes = diff / 60
  diff -= minutes * 60
  seconds = diff
  puts "#{hours}:#{minutes}:#{seconds} времени назад"
  text += "#{hours} ч. " if hours > 0
  text += "#{minutes} мин. " if minutes > 0
  text += "#{seconds} с. "
  text += "назад"
  puts text
end
# exit

puts 'Разница в микросекундах'.green
a = Time.at 1111111111, 111111
b = Time.at 1111111111, 222222
c = ((b - a) * 10**6).to_i
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
exit

p (b.to_date - a.to_date).to_i

a = Time.now
b = a.year
c = a.month
d = a.strftime("%Y-%m-%d %H:%M:%S")
# e = a.to_s :db  #(rails only)
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'd: '.red; puts d
# exit

# Возвращает строку "прошло времени" в днях, часах, минутах, секундах
# возможен полный и краткий вариант, пример:
# краткий вариант: "1 день 1 минута"
# полный вариант:  "1 день 0 часов 1 минута 0 секунд"
# @param [Int|Time] time_start_finish
# @param [Int|Time] time_finish_start
# @param [Hash|null] options
# @return [String]
# Зависимость: declension
def diff_time time_start_finish, time_finish_start, options={full: false}
  diff_string = ''
  diff = (time_start_finish - time_finish_start).to_i.abs
  if diff >= 24 * 60 * 60 || options[:full]
    days = diff/(24 * 60 * 60)
    diff_string += "#{days} #{days.declension 'дней, день, дня'}"
    diff_string += " "
    diff = diff - days * 24 * 60 * 60
  end
  if diff >= 60 * 60 || options[:full]
    hours = diff/(60 * 60)
    diff_string += "#{hours} #{hours.declension 'часов, час, часа'}"
    diff_string += " "
    diff = diff - hours * 60 * 60
  end
  if diff >= 60 || options[:full]
    minutes = diff/(60)
    diff_string += "#{minutes} #{minutes.declension 'минут, минута, минуты'}"
    diff_string += " "
    diff = diff - minutes * 60
  end
  if diff > 0 || diff_string.empty? || options[:full]
    diff_string += "#{diff} #{diff.declension('секунд, секунда, секунды')}"
  end
  diff_string
end

print 'diff_time 0, 0: '.red; puts diff_time 0, 0
print 'diff_time 0, 1: '.red; puts diff_time 0, 1
print 'diff_time 0, 59: '.red; puts diff_time 0, 59
print 'diff_time 0, 60: '.red; puts diff_time 0, 60
print 'diff_time 0, 61: '.red; puts diff_time 0, 61
print 'diff_time 0, 3599: '.red; puts diff_time 0, 3599
print 'diff_time 0, 3600: '.red; puts diff_time 0, 3600
print 'diff_time 0, 3601: '.red; puts diff_time 0, 3601
print 'diff_time 0, 3660: '.red; puts diff_time 0, 3660
print 'diff_time 0, 86399: '.red; puts diff_time 0, 86399
print 'diff_time 0, 86400: '.red; puts diff_time 0, 86400
print 'diff_time 0, 86401: '.red; puts diff_time 0, 86401
print 'diff_time 0, 86460: '.red; puts diff_time 0, 86460
print 'diff_time 0, 86461: '.red; puts diff_time 0, 86461
print 'diff_time 0, 90061: '.red; puts diff_time 0, 90061

print 'diff_time 0, 0, full:true: '.red; puts diff_time 0, 0, full:true
print 'diff_time 0, 1, full:true: '.red; puts diff_time 0, 1, full:true
print 'diff_time 0, 59, full:true: '.red; puts diff_time 0, 59, full:true
print 'diff_time 0, 60, full:true: '.red; puts diff_time 0, 60, full:true
print 'diff_time 0, 61, full:true: '.red; puts diff_time 0, 61, full:true
print 'diff_time 0, 3599, full:true: '.red; puts diff_time 0, 3599, full:true
print 'diff_time 0, 3600, full:true: '.red; puts diff_time 0, 3600, full:true
print 'diff_time 0, 3601, full:true: '.red; puts diff_time 0, 3601, full:true
print 'diff_time 0, 3660, full:true: '.red; puts diff_time 0, 3660, full:true
print 'diff_time 0, 86399, full:true: '.red; puts diff_time 0, 86399, full:true
print 'diff_time 0, 86400, full:true: '.red; puts diff_time 0, 86400, full:true
print 'diff_time 0, 86401, full:true: '.red; puts diff_time 0, 86401, full:true
print 'diff_time 0, 86460, full:true: '.red; puts diff_time 0, 86460, full:true
print 'diff_time 0, 86461, full:true: '.red; puts diff_time 0, 86461, full:true
print 'diff_time 0, 90061, full:true: '.red; puts diff_time 0, 90061, full:true


# puts 'Парсинг строки во время'.green
# a = '2017-02-08 08:00'
# b = a.to_time
# print 'a: '.red; puts a
# print 'b: '.red; puts b
