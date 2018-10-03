# encoding: UTF-8
require_relative '../colorize/colorize'

# a = Time.new
# p a
# a = Time.now
# p a

puts 'UNIX timestamp'.green
p Time.now.to_i.to_s
# exit

print 'Time.now: '.red; puts Time.now
# exit

puts 'Пауза выполнения кода.'.green
puts 'сек'.blue
sleep 1
puts '1/2 сек'.blue
sleep 0.5
puts '1/2 сек'.blue
sleep 0.5
puts 'yay'.blue
# exit

a = Time.new(1998, 2, 8, 9, 12, 23, "+03:00")
print 'a: '.light_blue; puts a
b = Time.new(1998, 2, 9, 8, 13, 41, "+03:00")
print 'b: '.light_blue; puts b
c = (b - a).to_i
print 'c: '.light_blue; puts c
diff = c

def declension number, words
  if words.is_a? String
    words = words.split(',').map{|v|v.strip}
  end
  words[1] = words[0] if (!words[1]||words[1].empty?)
  words[2] = words[1] if (!words[2]||words[2].empty?)
  number = number.abs%100
  if number.between?(11,19)
    return words[0]
  end
  i = number%10
  case i
  when 1
    return words[1]
  when 2..4
    return words[2]
  else
    return words[0]
  end
end

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
exit

# puts 'Парсинг строки во время'.green
# a = '2017-02-08 08:00'
# b = a.to_time
# print 'a: '.red; puts a
# print 'b: '.red; puts b
