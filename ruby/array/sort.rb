# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

# Сортировка по числам работает нормально
puts 'Сортировка по числам работает нормально'.green
a = [20, 101, 100, 1]
b = a.sort
print 'a: '.red; ap a
print 'b: '.red; ap b

# Сортировка строк с числами сортируется как строки
puts 'Сортировка строк с числами сортируется как строки'.green
a = ['101', '100', '20', '1']
b = a.sort
print 'a: '.red; ap a
print 'b: '.red; ap b

# Для сортировки строк с числами можно применить `.sort_by{|x| x.to_i}`
puts 'Для сортировки строк с числами можно применить `.sort_by{|x| x.to_i}`'.green
a = ['101', '100', '20', '1']
b = a.sort_by!{|x| x.to_i}
print 'a: '.red; ap a
print 'b: '.red; ap b

a = 's'
b = a.to_i
print 'b: '.red; puts b
