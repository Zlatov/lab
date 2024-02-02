require 'awesome_print'
require 'active_model'

puts 'Преобразовать значение, например полученное из данных формы, в булев тип или nil'.green
a = 'true'
b = ActiveModel::Type::Boolean.new.cast(a)
c = nil # Остаётся nil!
d = ActiveModel::Type::Boolean.new.cast(c)
e = '' # Преобразуется в nil!
f = ActiveModel::Type::Boolean.new.cast(e)
j = 0
h = ActiveModel::Type::Boolean.new.cast(j)
print 'a: '.red; puts a.inspect
print 'b: '.red; puts b.inspect
print 'c: '.red; print c.inspect; puts ' Остаётся nil!'.blue
print 'd: '.red; puts d.inspect
print 'e: '.red; print e.inspect; puts ' Преобразуется в nil!'.blue
print 'f: '.red; puts f.inspect
print 'j: '.red; puts j.inspect
print 'h: '.red; puts h.inspect
