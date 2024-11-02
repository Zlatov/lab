require 'awesome_print'

puts 'В самом простом случае, когда группировочный ключ на первом месте достаточно x.shift. x.shift одновременно извлечет ключ из массива и вернёт его группировщику.'.green
a = [['a', 'asd'], ['a', 'zxc'], ['b', 'qwe']]
print 'a: '.red; p a
b = a.group_by{|x| x.shift}
c = b.transform_values{|x| x.flatten}
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c

puts 'Если группировочный ключ не на первом месте, то указываем его используя индекс, удаляем из результатов используя индекс и возвращаем группировочный ключ группировщику.'.green
a = [[2, 1], [3, 1]]
print 'a: '.red; p a
b = a.group_by{|x| group_key = x[1]; x.delete_at(1); group_key}.transform_values{|x| x.flatten}
print 'a: '.red; p a
print 'b: '.red; p b
