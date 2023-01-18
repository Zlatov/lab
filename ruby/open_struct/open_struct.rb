require 'ostruct'
require 'awesome_print'
require 'json'
require 'active_support/all'


puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"


puts 'Создание нового'.green
a = OpenStruct.new asd: 1
print 'a: '.red; puts a


puts 'Доступ к полям объека'.green
a = OpenStruct.new asd: 1
print 'a.asd: '.red; puts a.asd
print 'a[:asd]: '.red; puts a[:asd]
print 'a[\'asd\']: '.red; puts a['asd']


puts 'Доступ к несуществующим полям объека'.green
a = OpenStruct.new asd: 1
print 'a.zxc: '.red; puts a.zxc
print 'a.zxc.class: '.red; puts a.zxc.class
print 'a[:zxc]: '.red; puts a[:zxc]
print 'a[\'zxc\']: '.red; puts a['zxc']


puts 'Создание полей на лету'.green
a = OpenStruct.new asd: 1
# a.zxc = 2
# a[:zxc] = 2
a['zxc'] = 2
print 'a.zxc: '.red; puts a.zxc
print 'a[:zxc]: '.red; puts a[:zxc]
print 'a[\'zxc\']: '.red; puts a['zxc']

puts 'Сериализация'.green
puts 'Сериализация единичного объекта'.blue
a = OpenStruct.new asd: 1
b = a.to_h
print 'b: '.red; puts b
puts 'Сериализация массива объектов'.blue
a = [{asd: 1}, {asd: 2}].map{|x| OpenStruct.new(x)}
b = a.as_json
c = a.map{|x| x.to_h}.as_json
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
