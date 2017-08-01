# encoding: UTF-8
require_relative '../colorize/colorize'

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
arr = %w[asd asd asd]
p arr

arr.each do |item|
  p item
end

arr.each_with_index do |value, key|
  puts key.to_s, value
end

p arr.last

puts 'Перебо, остаток от деления'.red
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

puts 'nested - перебор всех'.green
a = [
  {
    id: '1'
  },
  {
    id: '2',
    'children' => [
    ]
  },
  {
    id: '3',
    'children' => [
      {
        id: '3-1'
      },
      {
        id: '3-2',
        'children' => [
        ]
      }
    ]
  },
  {
    id: '4',
    'children' => [
    ]
  }
]

cache = []
i = []
level = 0
cache[level] = a
i[level] = 0

while level >= 0
  node = cache[level][i[level]]
  i[level]+= 1

  if node != nil

    p node

    if node['children'] != nil && node['children'].length != 0
      level+= 1
      cache[level] = node['children']
      i[level] = 0
    end
  else
    level-= 1
  end
end

array_of_hash = [
  {id:1},
  {id:2},
  {id:3},
  {id:2},
]


hash_of_hash = {
  a: {id:1},
  b: {id:2},
  c: {id:3},
}

puts '.any?'.green
p array_of_hash.any?{|node|node[:id]==4}
p hash_of_hash.any?{|node|node[1][:id]==4}

puts '.select'.green
p array_of_hash.select{|node|node[:id]==2}
p hash_of_hash.select{|key,node|node[:id]==2}


# Удалить из массива хешей по значению хеша
puts 'Удалить из массива хешей по значению хеша'.red
array_of_hash.delete_if{|v| v[:id]===3}
p array_of_hash


puts 'Перебор массива - создание нового'.red
ids = array_of_hash.map{|v|v[:id]*2}
p ids
p array_of_hash


puts 'Создание нового идентификатора'.red
ids = (0..5).map {|v|v.to_s}
p ids
id = nil
ids.each_with_index{|v,i|
  if v!=i.to_s
    id = i.to_s
    break
  end
}
id = ids.length.to_s if !id
p id
