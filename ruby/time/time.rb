# encoding: UTF-8
require_relative '../colorize/colorize'
require_relative '../string/declension'

# a = Time.new
# p a
# a = Time.now
# p a

puts 'UNIX timestamp'.green
p Time.now
p Time.now.to_i
p Time.now.zone
p Time.now.utc
p Time.utc(2012,3,3,3,3,3,999999).usec
p Time.now.utc.usec
# exit

print 'Time.now: '.red; puts Time.now
# exit

# puts 'Пауза выполнения кода.'.green
# puts 'сек'.blue
# sleep 1
# puts '1/2 сек'.blue
# sleep 0.5
# puts '1/2 сек'.blue
# sleep 0.5
# puts 'yay'.blue
# # exit

a = Time.new(1998, 2, 8, 9, 12, 23, "+03:00")
print 'a: '.light_blue; puts a
b = Time.new(1998, 2, 9, 8, 13, 41, "+03:00")
print 'b: '.light_blue; puts b
c = (b - a).to_i
print 'c: '.light_blue; puts c
diff = c

if diff >= 86400
  days = diff/86400
  days_w = declension days, 'дней,день,дня'
  puts "#{days} #{days_w} назад"
elsif diff < 10
  puts 'Только что'
else
  text = ''
  hours = diff / 3600
  diff-= hours * 3600
  minutes = diff / 60
  diff-= minutes * 60
  seconds = diff
  puts "#{hours}:#{minutes}:#{seconds} времени назад"
  text+= "#{hours} ч. " if hours>0
  text+= "#{minutes} мин. " if minutes>0
  text+= "#{seconds} с. "
  text+= "назад"
  puts text
end
# p (b.to_date - a.to_date).to_i

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
    diff_string += "#{days} #{declension days, 'дней, день, дня'}"
    diff_string += " "
    diff = diff - days * 24 * 60 * 60
  end
  if diff >= 60 * 60 || options[:full]
    hours = diff/(60 * 60)
    diff_string += "#{hours} #{declension hours, 'часов, час, часа'}"
    diff_string += " "
    diff = diff - hours * 60 * 60
  end
  if diff >= 60 || options[:full]
    minutes = diff/(60)
    diff_string += "#{minutes} #{declension minutes, 'минут, минута, минуты'}"
    diff_string += " "
    diff = diff - minutes * 60
  end
  if diff > 0 || diff_string.empty? || options[:full]
    diff_string += "#{diff} #{declension diff, 'секунд, секунда, секунды'}"
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
