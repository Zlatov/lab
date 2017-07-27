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
}
p h

# Добавить новый элемент
h[3] = '3'
# h[:mike] = 'test'
p h
p h[:Mike]

# Имеется ли элемент с ключем
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

# Удалить элемент с ключем :a
h.delete("a")

p nil&&nil

# Преобразование в hash с фильтрацией
puts 'Преобразование в hash с фильтрацией'.red
p Hash[ [1,2,3,4,5,6,7,8].select{ |node|
  node != 2
}.map{ |node|
  [node, node]
}]

# Слияние двух hash
puts 'Слияние двух hash'.red
h1 = {a:'a',b:'b'}
h2 = {a:'aa',c:'cc'}
h3 = h1.merge(h2)
p h1
p h2
p h3

# Ключи в стрингу
a = {a:'aa',c:'cc'}
# {a:'aa',c:'cc'}.stringify_keys
p Hash[a.map{|k,v|[k.to_s,v]}]
p a

p a.delete 'a'
p a.delete :a
p a
