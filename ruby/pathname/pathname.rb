# encoding: UTF-8
require 'awesome_print'
require 'pathname'

puts 'Путь к текущему исполняемому файлу'.green
a = __FILE__
print 'a: '.red; puts a


puts 'Путь к предку'.green
a = Pathname.new __FILE__
b = a.parent
c = a.join '..'
d = a.join '../'
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'd: '.red; puts d


puts 'Относительный путь'.green
a = Pathname.new __FILE__
b = a.relative_path_from a.join('../../')
print 'b: '.red; puts b
