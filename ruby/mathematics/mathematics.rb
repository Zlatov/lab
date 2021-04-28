# encoding: UTF-8
require 'awesome_print'
require 'active_support/all'

puts 'Остаток от деления'.green
a = 1.15
b = a % 0.5
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit

puts 'Окружение строки тэгом враппера при выводе массива записей'.green
o = nil
n = 3
(0..7).each do |i|
  o = i % n
  b = o == 0 ? '[' : ''
  e = o == n - 1 ? ']' : ''
  puts "#{b}" if b.present?
  print 'i, o: '.red; puts "#{i}, #{o}"
  puts "#{e}" if e.present?
end
e = o != n - 1 ? ']' : ''
puts "#{e}" if e.present?
# exit

puts 'Неполное частное'.green
a = 0
b = a.divmod(0.5)
c = b[0]
print 'a: '.red; puts a
print 'b: '.red; p b
print 'c: '.red; p c
# exit

puts 'Деление целого возвращает всегда целое'.green
a = 3 / 2
b = 3.0 / 2
c = 3.to_f / 2
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c

puts 'Округление в сторону'.green
print 'ceil - большую: '.red; puts 1.001.ceil
print 'floor - меньшую: '.red; puts 1.999.floor
