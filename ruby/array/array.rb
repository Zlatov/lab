# encoding: UTF-8
require 'rubygems'
require 'awesome_print'
require_relative '../colorize/colorize'
require "open-uri"
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
# [1, 2, 3]
# %w(foo bar baz #{1+1}) == ["foo", "bar", "baz", "\#{1+1}"]
# %W(foo bar baz #{1+1}) == ["foo", "bar", "baz", "2"]
# exit

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
# exit

puts 'Пересечение'.green
a = [1,1,3,4]
b = [1,2,4,5]
c = a & b
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
# exit

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
# exit 0

puts 'Вычитание'.green
a = [1,1,3,4]
b = [1,2,4,5]
c = a - b
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
# exit 0

puts 'Перебор'.green
puts 'each, v не является ссылкой'.blue
a = [1,'asd',nil]
print 'a: '.red; ap a
a.each do |v|
  next if v == 'asd'
  print 'v: '.red; puts v
  v = 3
end
print 'a: '.red; ap a
# exit 0

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
# exit 0

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
      {id: '3-2', 'children' =>
        [
          {id: '3-2-1'}
        ]
      }
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
    print 'parents: '.red; p parents

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

puts 'Массив хэшей|Хэш хэшей - удалить только те элементы значения которых равны заданному (.reject)'.green
p   [{text:'a'},{text:'b'},{text:'b'}].reject{|node|node[:text]=='b'}
p ({a:{id:'a'},b:{id:'b'},c:{id:'b'}}).reject{|k,node|node[:id]=='b'}


# Удалить из массива хешей по значению хеша
puts 'Удалить из массива хешей по значению хеша (.delete_if)'.green
a = [{id:1}, {id:2}, {id:3}, {id:2}]
b = a.delete_if{|v| v['id'.to_sym]==3}
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0


puts 'Изменение массива в переборе (.map!)'.green
a = [1,2,3,4]
b = a.map!{|e| e+= 1}
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0

puts 'Изменение хеш в переборе (.map)'.green
a = {vips: {article:'000023'}}
b = Hash[ a.map { |k,v|
  -> k, v {
    return nil if v[:article].nil?
    return [v[:article].to_sym, k.to_s]
  }.call k,v
}]
print 'a: '.red; p a
print 'b: '.red; p b

a = {vips: {article:'000023'}}
logic = ->(k,v) do
end
b = Hash[ a.map { |k,v|
  [v[:article], k]
}]
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0

puts 'Удалить по условию с учётом индекса'.green
a = [1,2,3]
b = []
a.delete_if.with_index do |_, index|
  if index==1
    puts _.to_s.red
    b << 1
  end
  b.include? index
end
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0


puts 'Массив хэшей в хэш-инфо'.green
p [{id: 1}, {id: 2}].to_info :id

puts 'Массив строку'.green
ap ['asd','zxc'].join('|')

puts 'Массив в sql строку'.green
a = [1, '2', nil, 0]
ap a
ap a.map!{|v| if v.is_a? String then "'#{v}'" elsif v.nil? then 'NULL' else v.to_s end}.join(', ')

puts 'Удаление по условию (.delete_if)'.green
puts 'Модифицирует иходный массив.'.blue
a = [0,1,2,3,4,5]
b = a.delete_if do |v|
  v == 4 || v == 5
end
print 'a: '.red; p a
print 'b: '.red; p b

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
# exit 0

puts 'Склеить, сложить и вычесть массивы (+ -).'.green
a =  [1,2]
b =  [1,2]
c = a + b
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
a = [1,2,3,4,4]
b = [1,4,7]
c = a - b
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
# exit 0

puts 'Назначить если нет (||=), вставить в массив (.push)'.green
a = {}
a[:a] ||= []
a[:a].push({a:1})
print 'a[:a]: '.red; p a[:a]
# exit 0

puts 'each по несколько элементов (.each_slice)'.green
a = (1..5)
b = a.each_slice(2) do |x|
  print 'x: '.red; p x
end
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0

puts 'Изъять, выбрать из массива'.green
puts 'С конца (.pop)'.blue
a = [1,2,3]
b = a.pop
print 'a: '.red; p a
print 'b: '.red; p b
puts 'С начала (.shift)'.blue
a = [1,2,3]
b = a.shift 2
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0

puts 'Очистить от нулевых значений (.compact)'.green
a = [nil, 1, 2, nil, 3]
b = a.compact!
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0

puts 'Очистить от дубликатов'.green
a = [ "a", "a", "b", "b", "c" ]
b = a.uniq
print 'a: '.red; p a
print 'b: '.red; p b
a = [["student","sam"], ["student","george"], ["teacher","matz"]]
b = a.uniq { |s| s.first }
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0

puts 'Определить наличие дубликатов (.detect)'.green
a = [1,2,3,2,2,4,4,5]
b = a.detect{|v| a.count(v) > 1}
print 'a: '.red; p a
print 'b: '.red; p b
a = [1,2,3,2,2,4,4,5]
b = a.select{|e| a.count(e) > 1}.uniq
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0

puts 'Сложить, просуммировать элементы одного массива (.reduce, .inject)'.green
a = (1..3)
b = a.reduce(:+)
print 'a: '.red; p a
print 'b: '.red; p b
a = (1..3)
b = a.inject{ |sum, x| sum + x }
print 'a: '.red; p a
print 'b: '.red; p b
a = (1..3)
b = a.inject(1){ |sum, x| sum + x }
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0

puts 'Перемножить элементы массива (.reduce, .inject)'.green
a = (1..3)
b = a.reduce(:*)
print 'a: '.red; p a
print 'b: '.red; p b
a = (1..3)
b = a.inject{|mul, x| mul * x}
print 'a: '.red; p a
print 'b: '.red; p b

puts 'Наилучший О.о элемент массива (.inject)'.green
a = %w(cat sheep bear)
b = a.inject{|memo, x| memo.length < x.length ? memo : x}
print 'a: '.red; p a
print 'b: '.red; p b

a, b = *[1,2,3]
print 'a: '.red; p a
print 'b: '.red; p b

a = [1,2,3,2,4,4,5]
b = a.group_by{|v| v}
c = b.select{|k,v| v.length > 1}
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
# exit
a = [{a:'1'},{a:'2'},{a:'3'},{a:'2'},{a:'4'},{a:'4'},{a:'5'}]
b = a.group_by{|v| v[:a]}.select{|k,v| v.length >1}
print 'a: '.red; p a
print 'b: '.red; p b

a = [
  {domain: 1, id: 1},
  {domain: 1, id: 2},
  {domain: 2, id: 3},
  {domain: 2, id: 4},
  {domain: 2, id: 5},
  {domain: 3, id: 6},
]
first_domain = true
parent_domain = nil
print 'a: '.red; puts a
a.each do |value|
  domain = value[:domain]
  puts '} '.red if domain != parent_domain && !first_domain
  puts "#{domain} { ".red if domain != parent_domain
  print 'value: '.red; puts value
  first_domain = false
  parent_domain = domain
end
puts '} '.red

puts 'Перебор nested с расширением'.green
class Array
  def each_nested
    level = 0
    cache = []
    cache[level] = self
    parents = []
    parents[level] = nil
    i = []
    i[level] = 0
    while level >= 0
      node = cache[level][i[level]]
      i[level]+= 1
      if node != nil

        yield(node.clone, parents.clone, level)

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
    self
  end
end

a = [
  {id: '1'},
  {id: '2', 'children' => [] },
  {id: '3', 'children' =>
    [
      {id: '3-1'},
      {id: '3-2', 'children' =>
        [
          {id: '3-2-1'}
        ]
      }
    ]
  },
  {id: '4', 'children' => [] }
]

a.each_nested do |node, parents, level|
  puts '-----------------------'.green
  print 'level: '.red; puts level
  print 'node: '.red; p node
  print 'parents: '.red; p parents
end

puts 'Клонирование массива'.green
a = []
b = a.clone
b[0] = 0
print 'a: '.red; p a
print 'b: '.red; p b

puts 'Над каждым элементом'.green
a = [1,2,3]
b = a.map(&:to_s)
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Удалить элемент по индексу'.green
puts 'Возвращает удалённый элемент'.blue
a = [1,2,3]
b = a.delete_at -1
print 'a: '.red; p a
print 'b: '.red; p b
