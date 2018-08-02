# encoding: UTF-8
require 'awesome_print'

puts 'Остаток от деления'.green
a = 81
b = a % 10
print 'a: '.red; puts a
print 'b: '.red; puts b


puts 'Неполное частное'.green
a = 81
b = a.divmod(11)
c = b[0]
print 'a: '.red; puts a
print 'b: '.red; p b
print 'c: '.red; p c

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
