# encoding: UTF-8
require 'awesome_print'
require 'pathname'

puts 'Путь к текущему исполняемому файлу (не всегда, см Dir.pwd)'.green
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

puts 'Два пути - прямые родственники?'.green
a = "/home/iadfeshchm/projects/my/lab/ruby/pathname/pathname.rb"
b = Pathname.new "/home/iadfeshchm"
def blood_relative? a, b
  pathname_a = a.is_a?(Pathname) ? a : Pathname.new(a)
  pathname_b = b.is_a?(Pathname) ? b : Pathname.new(b)
  raise 'Передано два относительных путя.' if pathname_a.relative? && pathname_b.relative?
  if (pathname_a.relative? || pathname_b.relative?) && pathname_a.relative?
    pathname_a = pathname_b.join pathname_a
  else
    pathname_b = pathname_a.join pathname_b
  end
  array_a = pathname_a.to_s.gsub!(/(?:^\/+)|(?:\/+$)/,"").split("/")
  array_b = pathname_b.to_s.gsub!(/(?:^\/+)|(?:\/+$)/,"").split("/")
  min = [array_a.length, array_b.length].min
  array_a[0...min] == array_b[0...min]
end
c = blood_relative? a, b
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
