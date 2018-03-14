# encoding: UTF-8
require_relative '../colorize/colorize'
require "open-uri"
require 'rubygems'
require 'awesome_print'
require 'mini_magick'

  class Array
    def lib_to_info i
      Hash[ self.map{ |value|
        -> value {
          [value[i], value]
        }.call(value) if !value[i].nil?
      }]
    end
    alias :to_info :lib_to_info
  end

puts '--------------------------------'
puts 'Задание массива'.green
arr = []
arr = Array.new
arr = Array.new(5)
arr = Array.new(5,"aaaaa")
arr << :a
arr << :b
arr << :c
arr << :d
p arr.sample
puts 'Масси включает в себя `:b`?'.red
p (arr.include?(:b)? 'y' : 'n')
arr = ['asd', 'asd', 'asd']
p arr
arr = %w{
asd
asd
asd
}
ap arr


puts '--------------------------------'
puts 'Пересечение'.green
a = [1,1,3,4]
b = [1,2,4,5]
c = a & b
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c

puts 'Объеденение?++++++++++++++++++++++++++++++++'.green
a = [1,1,3,4]
b = [1,2,4,5]
c = a + b
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c

puts 'Объеденение?++++++++++++++++++++++++++++++++'.green
a = [1,1,3,4]
b = [1,2,4,5]
c = a | b
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c

puts 'Объеденение?++++++++++++++++++++++++++++++++'.green
a = [[1,1,3,4],[1,2,4,5]]
b = a.flatten
print 'a: '.red; p a
print 'b: '.red; p b

puts '--------------------------------'
puts 'Перебор'.green
puts 'each, v не является ссылкой'.blue
a = [1,'asd',nil]
print 'a: '.red; ap a
a.each do |v|
  print 'v: '.red; puts v
  v = 3
end
print 'a: '.red; ap a

puts 'each_with_index'.blue
a = [1,'asd',nil]
a.each_with_index do |value, key|
  print key.to_s.red, ' ', value.to_s, "\n"
end

puts 'for in'.blue
a = [1,2,3]
for val in a
  next if val == 2 # как continue во многих других языках
  puts val
end

puts '--------------------------------'
puts 'Последний элемент массива'.green
a = [1,'asd',nil]
puts arr.last.to_s.red

puts 'Перебо, остаток от деления'.green
a = 1..5
a.each_with_index do |value, key|
  puts "#{'ключ:'.light_blue} #{key.to_s}, #{'остаток от деления на 2:'.light_blue} #{(key%2).to_s}"
  p 'значение: ' + value.to_s
end

puts 'flat - перебор вверх до нужного родителя'.green
a = {
  '1'.to_sym => {id: '1', parent: '#'},
  '2'.to_sym => {id: '2', parent: '1'},
  '3'.to_sym => {id: '3', parent: '2'},
  '4'.to_sym => {id: '4', parent: '3'},
}
node = a[:'4']
while node[:parent] != '#'
  node = a[node[:parent].to_sym]
end

p node

puts
puts 'Перебор nested'.green
a = [
  {id: '1'},
  {id: '2', 'children' => [] },
  {id: '3', 'children' =>
    [
      {id: '3-1'},
      {id: '3-2', 'children' => [] }
    ]
  },
  {id: '4', 'children' => [] }
]

level = 0
cache = []
cache[level] = a
parents = []
parents[level] = nil
# Если нет .next()
i = []
i[level] = 0

while level >= 0
  node = cache[level][i[level]]
  i[level]+= 1
  if node != nil

    print 'level: '.red; puts level
    print 'node: '.red; puts node
    print 'parents: '.red; puts parents

    if !node['children'].nil? && node['children'].length > 0
      level+= 1
      parents[level] = node.clone
      cache[level] = node['children']
      i[level] = 0
    end
  else
    parents[level] = nil
    level-= 1
  end
end

array_of_hash = [
  {'id':1},
  {'id':2},
  {'id':3},
  {'id':2},
]


hash_of_hash = {
  a: {id:1},
  b: {id:2},
  c: {id:3},
}

puts
puts 'Массив хэшей - проверить есть ли хешь со значением поля равным заданному (.any?)'.green
p [{text:'a'},{text:'b'},{text:'c'}].any?{|node|node[:text]=='b'}
p [{text:'a'},{text:'b'},{text:'c'}].any?{|node|node[:text]=='d'}

puts 'Массив хэшей|Хэш хэшей - выбрать только те элементы значения которых равны заданному (.select)'.green
p   [{text:'a'},{text:'b'},{text:'b'}].select{|node|node[:text]=='b'}
p ({a:{id:'a'},b:{id:'b'},c:{id:'b'}}).select{|k,node|node[:id]=='b'}


# Удалить из массива хешей по значению хеша
puts "#{'Удалить из массива хешей по значению хеша'.green} #{'# преобразует ключи тварь'.red}"
array_of_hash = [
  {'id':1},
  {'id':2},
  {'id':3},
  {'id':2},
]
p array_of_hash
array_of_hash.delete_if{|v| v['id'.to_sym]==3}
p array_of_hash


puts 'Перебор массива map! - '.green
a = [1,2,3,4]
b = a.map!{|e| e+= 1}
print 'a: '.red; puts a
print 'b: '.red; puts b

# puts 'Создание нового идентификатора'.red
# ids = (0..5).map {|v|v.to_s}
# p ids
# id = nil
# ids.each_with_index{|v,i|
#   if v!=i.to_s
#     id = i.to_s
#     break
#   end
# }
# id = ids.length.to_s if !id
# p id


proj_iarticle_slug = Hash[ {vips: {article:'000023'}}.map { |k,v|
  -> k, v {
    return nil if v[:article].nil?
    return [v[:article].to_sym, k.to_s]
  }.call k,v
}]
p proj_iarticle_slug

proj_iarticle_slug = Hash[ {vips: {article:'000023'}}.map { |k,v|
  -> k, v {
    return nil if v[:article].nil?
    return [v[:article].to_sym, k.to_s]
  }.call k,v
}]
p proj_iarticle_slug

a = [1,2,3]
b = []
a.delete_if.with_index do |_, index|
  puts _.to_s.red
  if index==1
    b << 1
  end
  b.include? index
end
p a

p *[:asd].to_s



puts '--------------------------------'
puts 'Массив хэшей в хэш-инфо'.green
p [{id: 1}, {id: 2}].to_info :id

puts '--------------------------------'
puts 'Массив строку'.green
ap ['asd','zxc'].join('|')

puts '--------------------------------'
puts 'Массив в sql строку'.green
a = [1, '2', nil, 0]
ap a
ap a.map!{|v| if v.is_a? String then "'#{v}'" elsif v.nil? then 'NULL' else v.to_s end}.join(', ')

puts '--------------------------------'
puts 'Удаление по значению'.green
a = [0,1,2,3,4,5]
a.delete_if do |v|
  v == 4 || v == 5
end
puts a

puts
puts 'Вывод nested'.green
a = [
  {id: '1'},
  {id: '2', 'children' => [] },
  {id: '3', 'children' =>
    [
      {id: '3-1'},
      {id: '3-2', 'children' => [] }
    ]
  },
  {id: '4', 'children' => [] },
  {id: '5', 'children' =>
    [
      {id: '5-1', 'children' =>
        [
          {id: '5-1-1'},
          {id: '5-1-2'}
        ]
      }
    ]
  }
]

level = 0
cache = []
cache[level] = a
parents = []
parents[level] = nil
# Если нет .next()
i = []
i[level] = 0

print "<ul>\n"

while level >= 0
  node = cache[level][i[level]]
  i[level]+= 1
  if node != nil

    print "#{'    '*level+'    '}<li><a>#{node[:id]}</a>"

    if !node['children'].nil? && node['children'].length > 0
      level+= 1
      print "\n#{'    '*level}<ul>\n"
      parents[level] = node.clone
      cache[level] = node['children']
      i[level] = 0
    else
      print "</li>\n"
    end
  else
    parents[level] = nil
    print "#{'    '*(level<0 ? 0 : level)}</ul>\n"
    level-= 1
  end
end

a =  [1,2]
b =  [1,2]
c = a + b
print 'c: '.red; puts c

a = {}
a[:a] ||= []
a[:a].push({a:1})
print 'a[:a]: '.red; p a[:a]

# Массив в строки по 10 элементов
puts 'each по несколько элементов'.green
a = (1..45).to_a
ap a
a.each_slice(10) do |slice|
  puts slice.join(', ')
end


# Изъять, выбрать из массива
puts
puts 'Изъять, выбрать из массива'.green
puts 'С конца'.blue
a = [1,2,3]
b = a.pop
print 'a: '.red; p a
print 'b: '.red; p b
puts 'С начала'.blue
a = [1,2,3]
b = a.shift
print 'a: '.red; p a
print 'b: '.red; p b

