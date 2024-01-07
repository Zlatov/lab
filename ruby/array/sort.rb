# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

puts 'Сортировка по числам работает нормально'.green
a = [20, 101, 100, 1]
b = a.sort
print 'a: '.red; ap a
print 'b: '.red; ap b

puts 'Сортировка строк с числами сортируется как строки'.green
a = ['101', '100', '20', '1']
b = a.sort
print 'a: '.red; ap a
print 'b: '.red; ap b

puts 'Для сортировки строк с числами можно применить `.sort_by{|x| x.to_i}`'.green
a = ['101', '100', '20', '1']
b = a.sort_by!{|x| x.to_i}
print 'a: '.red; ap a
print 'b: '.red; ap b

puts 'Важно возвращать 1 или -1, 0 - не гарантирует порядок.'.green
a = [1, 2, 3, 4]
b = a.sort{|x, y| x > 2 ? -1 : 1}
print 'b: '.red; p b
a = [1, 2, 3]
b = a.sort_by do |x|
  x > 1 ? -1 : 1
end
print 'a: '.red; p a
print 'b: '.red; p b
# exit

a = 's'
b = a.to_i
print 'b: '.red; puts b

a = [
  {order: 1,   id: 1},
  {order: 100, id: 3},
  {order: 100, id: 2},
  {order: 20,  id: 4},
  {order: 10,  id: 5},
  {order: 1,   id: 6},
  {order: 20,  id: 7},
  {order: 10,  id: 8}
]
b = a.sort_by{|x| x[:id]}.reverse.sort_by{|x| x[:order]}
print 'a: '.red; p a
print 'b: '.red; p b

puts 'Сортировка по другому массиву'.green
a = [
'(10000-12000 K), бин C1',
'(10000-14000 K), бин B14',
'(11000-12000 K), бин C-2',
'(11000-12000 K), бин C-2D',
'(2700-3000 K), бин AE5-1',
'(3000-3500 K), бин 30D',
'(3000-3500 K), бин H05-D',
'(4000-4500 K), бин 40E'
]
# binsort = lambda do |x, y|
#   return 0
# end
# b = a.sort{|x, y| binsort.call(x, y)}
# indexes = ['C1', 'B14']
# binsort = lambda do |x|
#   return indexes.index(x)
# end
# b = a.sort_by{|x| binsort.call(x)}
indexes = [
'(2700-3000 K), бин AE5-1',
'(11000-12000 K), бин C-2D'
]
b = a.sort_by{|x| indexes.index(x) || a.length}
print 'a: '.red; p a
print 'b: '.red; p b


