# encoding: UTF-8
require 'rubygems'
require 'awesome_print'
require "open-uri"
require 'mini_magick'

# require 'active_support/concern' u8 
# require 'active_support'
# require 'active_support/core_ext'
require 'active_support/all'

require_relative '../_libs/array/nested.rb'
class Array
  include Array::Nested
end

# 
# Все методы
# 
# reverse
# 

class Array
  def lib_to_info i
    Hash[ self.clone.compact.select{|e| e.keys.include? i}.map{ |h|
      -> h {
        [h[i], h]
      }.call(h)
    }]
  end
  alias :to_info :lib_to_info
end

puts 'Массив хэшей в хэш-инфо'.green
a = [{id: 1}, {id: 2}]
b = a.to_info :id
print 'a: '.red; p a
print 'b: '.red; p b
a = [{id: 1}, {id: 2}, nil, {}]
b = a.to_info :id
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Массив в хеш массивов (разбиение элементов по признаку)'.green
a = [
  {a: 1, b: 1},
  {a: 2, b: 2},
  {a: 3, b: 1}
]
b = {}
a.each{|v|
  b[v[:b]] ||= []
  b[v[:b]] << v
}
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Задание массива'.green
a = []
a = Array.new
a = Array.new(5){rand}
print 'a: '.red; p a
a = Array.new 5, "aaaaa"
print 'a: '.red; p a
a << :a
a << :b
a << :c
a << :d
b = %w(foo bar baz #{1+1})
c = %W(foo bar baz #{1+1})
f = %W/foo bar baz #{1+1}/
d = (1..3 ).to_a # от 1 до 3, включая 3
e = (1...3).to_a # от 1 до 3, НЕ включая 3
print 'a: '.red; p a
print 'a.sample: '.red; puts a.sample
print 'b: '.red; p b
print 'c: '.red; p c
print 'd: '.red; p d
print 'e: '.red; p e
print 'f: '.red; p f
# exit

puts 'Масси включает (содержит) в себе значение .include?'.green
a = [1, 2, 3]
b = a.include? 3
c = a.include? 4
print 'b: '.red; puts b
print 'c: '.red; puts c
puts 'Масси НЕ включает (НЕ содержит) в себе значение .exclude?'.green
a = [1, 2, 3]
b = a.exclude? 3
c = a.exclude? 4
print 'b: '.red; puts b
print 'c: '.red; puts c
# exit

puts 'Многострочное задание массива'.green
a = %w{
asd
  asd
asd
}
print 'a: '.red; p a
# exit

puts 'Пересечение'.green
a = [1,1,3,4]
b = [1,2,4,5]
c = a & b
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
a = [[1,1,3,4], [1,2,4,5], [2,4,5]]
b = a.reduce(:&)
print 'a: '.red; p a
print 'b: '.red; p b
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
a = [1,3,4,[1,2,4,5],5]
b = a.flatten
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Вычитание'.green
a = [1,1,3,4]
b = [1,2,4,5]
c = a - b
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
# exit

puts 'Перебор'.green
puts 'В each, value не является ссылкой.'.blue
a = [1, 'asd', nil]
print 'a: '.red; p a
b = a.each do |value|
  next if value == 'asd'
  value = 2
  print 'value: '.red; puts value
end
print 'a: '.red; p a
print 'b: '.red; p b
a = [{a: nil},{a: 1}]
print 'a: '.red; p a
puts 'В each, value не является ссылкой, но если value это не скалярная переменная, то value[:key] является ссылкой.'.blue
b = a.each do |value|
  value[:a] = 2
  value = 3 if value[:a].nil?
end
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'each_with_index'.blue
a = [1,'asd',nil]
a.each_with_index do |value, key|
  print key.to_s.red, ' ', value.to_s, "\n"
end

puts 'Пребор for но рубокоп предлагает each'.green
for i in 0..0
  print 'i 0..0 ВЫВЕДЕТ 0: '.red; puts i
end
for i in 0..1
  print 'i 0..1 ВЫВЕДЕТ 0 и 1: '.red; puts i
end
for i in 1..0
  print 'i 1..0 ХЕРОТА: '.red; puts i
end

(0..0).each do |i|
  print 'i 0..0 ВЫВЕДЕТ 0: '.red; puts i
end
(0..1).each do |i|
  print 'i 0..1 ВЫВЕДЕТ 0 и 1: '.red; puts i
end
(1..0).each do |i|
  print 'i 1..0 ХЕРОТА: '.red; puts i
end
# exit


puts 'for in'.blue
a = [1,2,3]
for val in a
  next if val == 2 # как continue во многих других языках
  puts val
end
# exit

puts '.insert(index, item1, item2,...)'.green
puts 'Возвращает тот оригинальный но изменённый массив'.blue
a = [0, 1, 2, 3]
b = a.insert(1, "asd", "zxc")
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts '.sort_by{|x| x.value}'.green
a = ['zxc', 'asd', 1, nil, 0]
b = a.sort_by{|x| x.to_s}
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'break'.green
for i in 0...3
  print 'i: '.red; puts i
  break if i == 1
end
(0..2).each do |i|
  print 'i: '.red; puts i
  break if i == 1
end
# exit

puts '--------------------------------'
puts 'Последний элемент массива'.green
a = [1,'asd',nil]
b = a.last.to_s
print 'a: '.red; p a
print 'b: '.red; puts b
# exit

puts 'Часть массива a[индекс старта..индекс конца] или a[индекс старта, сколько]'.green
a = (0..9).to_a
b = a[3..5] # [3, 4, 5]
c = a[3...5] # [3, 4]
d = a[7..-1] # [7, 8, 9]
e = a[4, 2] # [4, 5]
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
print 'd: '.red; p d
print 'e: '.red; p e
# exit

puts 'Перебо, остаток от деления'.green
a = 1..5
a.each_with_index do |value, key|
  puts "#{'ключ:'.blue} #{key.to_s}, #{'остаток от деления на 2:'.blue} #{(key%2).to_s}"
  p 'значение: ' + value.to_s
end
b = a.to_a
print 'a: '.red; p a
print 'a.class: '.red; puts a.class
print 'b: '.red; p b
print 'b.class: '.red; puts b.class
# exit

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
# Смотри аналогичные методы: .all? .one? .none?
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
# exit

puts 'Изменение массива в переборе (.map!)'.green
a = [1,2,3,4]
b = a.map!{|e| e+= 1}
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Изменение массива хэшей в переборе (.map!)'.green
a = [{a:1},{a:2},{a:3},{a:4}]
b = a.map!{|e| e[:a] += 1}
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Изменение хеш в переборе (.map)'.green
a = {vips: {article: nil}}
b = Hash[a.map{|k, v|
  next if v[:article].nil?
  [v[:article].to_sym, k.to_s]
}.compact]
print 'a: '.red; p a
print 'b: '.red; p b
# exit

a = {vips: {article:'000023'}}
b = Hash[ a.map { |k,v|
  [v[:article], k]
}]
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Массив в хеш.'.green
a = ['asd','zxc qwe']
b = Hash[ a.map{|v|
  [v, v]
}]
print 'a: '.red; p a
print 'b: '.red; p b
# exit

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
# exit

puts 'Массив строку; а в рельсе смотри метод .to_sentence() с i18n'.green
ap ['asd','zxc'].join # по умолчанию пустая строка
ap ['asd','zxc'].join('|')
a = ['asd', 'zxc', 'qwe'].to_sentence # => должно поидее вернуть 'asd, zxc and qwe', а возвращает 'asd, zxc, and qwe', идиотизм решается опцией last_word_connector
print 'a: '.red; puts a
a = ['asd', 'zxc', 'qwe'].to_sentence(last_word_connector: ' and ')
print 'a: '.red; puts a
# exit

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
# exit

puts 'to_html_nested'.green
a = [
  { name: '1' },
  { name: '2', children:
    [
      { name: '3' },
      { name: '4' }
    ]
  },
  { name: '5', children:
    [
      { name: '6', children:
        [
          { name: '7' }
        ]
      }
    ]
  },
  { name: '8', children:
    [
      { name: '9' }
    ]
  }
]
class Array
  def to_html_nested
    html = ''
    level = 0
    cache = []
    cache[level] = self.clone
    parents = []
    parents[level] = nil
    i = []
    i[level] = 0
    while level >= 0
      node = cache[level][i[level]]
      i[level]+= 1
      if node != nil

        html+= '    ' * (level * 2 + 1) + '<li>'
        html+= yield(node.clone, parents.clone, level)

        if !node[:children].nil? && node[:children].length > 0
          level+= 1
          html+= "\n" + '    ' * (level * 2) + '<ul>' + "\n"
          parents[level] = node.clone
          cache[level] = node[:children]
          i[level] = 0
        else
          html+= '</li>' + "\n"
        end
      else
        parents[level] = nil
        if level > 0
          html+= '    ' * (level * 2) + '</ul>' + "\n"
          html+= '    ' * (level * 2 - 1) + '</li>' + "\n"
        end
        level-= 1
      end
    end
    html
  end
end

puts (a.to_html_nested do |node, parents, level|
  "<a href=\"\">#{node[:name]}</a>"
end)
# exit

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
# exit

puts 'Назначить если нет (||=), вставить в массив (.push)'.green
a = {}
a[:a] ||= []
a[:a].push({a:1})
print 'a[:a]: '.red; p a[:a]
puts '.push может принимать несколько аргументов как отдельные элементы массива'.blue
a = []
b = [:asd, :zxc]
a.push *b
print 'a: '.red; p a
puts '<< принимает только один аргумент как элемент массива'.blue
a = []
b = [:asd, :zxc]
a << b
print 'a: '.red; p a
# exit

puts 'each по несколько элементов (.each_slice)'.green
a = (1..5)
b = a.each_slice(2) do |x|
  print 'x: '.red; p x
end
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'each по несколько элементов и индекс (.each_slice.with_index)'.green
a = (1..5)
b = a.each_slice(2).with_index do |x, i|
  print 'x: '.red; p x
  print 'i: '.red; puts i
end
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Добавить информацию о индексе к значениям map.with_index'.green
a = ['asd', 'zxc']
b = a.map.with_index do |value, index|
  [value, index]
end
print 'a: '.red; p a
print 'b: '.red; p b

puts 'Добавить информацию о индексе к значениям map.with_index'.green
a = ['asd', 'zxc']
b = a.each_with_index.to_a
print 'a: '.red; p a
print 'b: '.red; p b
# exit


puts 'each_slice и вычисление глобального индекса'.green
a = (0..9).to_a
print 'a: '.red; p a
a.each_slice(3).with_index do |b, packet_index|
  b.each_with_index do |c, i|
    global_index = packet_index * 3 + i
    print 'c: '.red; puts c
    print 'global_index: '.red; puts global_index
  end
end
# exit

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
puts 'Добавить в начало (.unshift)'.blue
a = [1,2,3]
b = a.unshift 4
print 'a: '.red; p a
print 'b: '.red; p b
puts 'Добавить по индексу (.insert)'.blue
a = [0, 1]
b = a.insert(1, 'asd')
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Очистить (удалить) от нулевых значений (.compact)'.green
a = [nil, 1, 2, nil, 3]
b = a.compact
print 'a: '.red; p a
print 'b: '.red; p b
b = a.compact!
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Очистить от дубликатов'.green
a = [ "a", "a", "b", "b", "c" ]
b = a.uniq
print 'a: '.red; p a
print 'b: '.red; p b
a = [["student","sam"], ["student","george"], ["teacher","matz"]]
b = a.uniq { |s| s.first }
print 'a: '.red; p a
print 'b: '.red; p b
# exit

puts 'Определить наличие дубликатов (.detect)'.green
a = [1,2,3,2,2,4,4,5]
b = a.detect{|v| a.count(v) > 1}
print 'a: '.red; p a
print 'b: '.red; p b
a = [1,2,3,2,2,4,4,5]
b = a.select{|e| a.count(e) > 1}.uniq
print 'a: '.red; p a
print 'b: '.red; p b
# exit

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
# exit

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
# exit

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

puts 'Перебор nested с расширением из Array::Nested.'.green
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

puts 'Склеивание древовидных структур.'.green
a = [
  [
    {'text' => 'asd', 'children' => [
      {'text' => 'rty'}
    ]}
  ],
  [
    {'text' => 'asd', 'children' => [
      {'text' => 'qwe', 'children' => [
        {'text' => 'fgh'}
      ]}
    ]}
  ]
]
b = []
a.each do |tree|
  b.concat_nested tree, children: 'children', path_key: 'text'
end
b.each_nested children: 'children' do |node, parents, level|
  puts "#{"  " * level}#{node["text"]}"
end
# exit

puts 'Клонирование массива'.green
a = []
b = a.clone
b[0] = 0
print 'a: '.red; p a
print 'b: '.red; p b

puts 'Применить метод к каждому элементу массива'.green
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
# exit

puts 'Перемешать'.green
a = [1,2,3,4,5]
b = a.shuffle
print 'a: '.red; p a
print 'b: '.red; p b

puts 'Модуль перечисления'.green
class PersonCollection

  include Enumerable

  def each &each_block
    @persons.each do |person|
      each_block.call(person)
      # yield(person)
    end
  end

  def initialize(*persons)
    @persons = persons
  end
end

a = PersonCollection.new ['asd', 2, {a: 3}]
a.each do |per|
  puts per
end

puts 'Проверить все элементы выражением (.all?)'.green
# Смотри аналогичные методы: .any? .one? .none?
a = [true, true, true]
b = a.all?{|x| x == true}
print 'a: '.red; p a
print 'b: '.red; puts b
# Если массив пуст то всегда возвращается true!!!
a = []
b = a.all?{|x| x == true}
print 'a: '.red; p a
print 'b: '.red; puts b
a = []
b = a.all? &:present?
print 'a: '.red; p a
print 'b: '.red; puts b
