# encoding: UTF-8
require_relative '../colorize/colorize'

arr = 'asd'
h = {
  :r => "Камень",
  :arr => arr,
  :Mike => 214134,
  :jes => '1432352',
  0 => ['asd'],
  asdf: ['asd'],
  'asdf' => ['asd'],
}
p h

# Добавить новый элемент
h[3] = '3'
# h[:mike] = 'test'
p h
p h[:Mike]

# Имеется ли элемент с ключем
puts
puts 'Имеется ли элемент с ключем'.green
if h.key? :mike
  p h[:mike]
end
p h[0]
p h[3]

# Перебор
p 'Перебор'
h.each do |key,value|
  print key.to_s + ' - '
  print value.to_s
  print "\n"
end

# Количество элементов
p h.count

# Удаление по ключу
puts
puts 'Удаление по ключу'.green
a = {a: 1, 'a' => 2}
a.delete 'a'
print 'a: '.red; puts a
a.delete :a
print 'a: '.red; puts a

# Преобразование в hash с фильтрацией
puts
puts 'Преобразование в hash с фильтрацией'.green
p Hash[ [1,2,3,4,5,6,7,8].select{ |node|
  node != 2
}.map{ |node|
  [node, node]
}]

puts ({a:1,b:2}).select{ |k,v| k != :a}

# Преобразование всех полей в хэше
puts 'Преобразование всех полей в хэше'.green
# Старый хэш, старые строки (преобразованные):
a = {a:'a0',b:'b0'}
a.each{ |_,v| v.gsub! '0', '1' }
print 'a: '.red; puts a
# Старый хэш, новые строки:
a = {a:'a0',b:'b0'}
a.each{ |k,v| a[k] = "#{v[0]}2" }
print 'a: '.red; puts a
# Новый хеш:
a = {a:'a0',b:'b0'}
b = Hash[a.map{|k,v| [k,v+'3'] } ]
print 'a: '.red; puts a
print 'b: '.red; puts b

# Слияние двух hash
puts
puts 'Слияние двух hash'.green
h1 = {a:'a',b:'b'}
h2 = {a:nil,c:'cc'}
h3 = h1.merge(h2)
p h1
p h2
p h3
h1.merge! h2
p h1

# Ключи в стрингу
puts
puts 'Ключи в стрингу'.green
puts 'В Rails .stringify_keys()'.blue
a = {a:'aa',c:'cc'}
b = Hash[a.map{|k,v|[k.to_s,v]}]
print 'a: '.red; puts a
print 'b: '.red; puts b

# Ключи в символ (один уровень)
puts
puts 'Ключи в символ (один уровень)'.green
puts 'Новый hash'.blue
a = {'a' => 'a','b b' => {'c' => 'c'}}
b = Hash[a.map{|k,v|[k.to_sym,v]}]
print 'a: '.red; puts a
print 'b: '.red; puts b
puts 'Себя'.blue
a = {'a' => 'a','b' => {'c' => 'c'}}
a.keys.each do |key|
  a[(key.to_sym rescue key) || key] = a.delete(key)
end
print 'a: '.red; puts a

a = 'ds'
a = nil
puts "asd: #{a.to_s.red}"


# def nested_hash hash
#   hash.each{|k,v| nested_hash k}
# end

# a = {a: {b: nil}, c: nil}
# b = a.each{|k,v| k}
# print 'a: '.red; puts a
# print 'b: '.red; puts b
