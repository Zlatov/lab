# encoding: UTF-8
require_relative '../colorize/colorize'
require 'awesome_print'
require 'active_support/all'

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

puts
puts 'Перебор'.green
a = {a: 1, b: 2}
b = {}
a.each do |k,v|
  b[k] = v + 1
end
print 'a: '.red; puts a
print 'b: '.red; puts b

puts 'Перебор с разбиением - преобразовывает в массив'.green
a = {asd: 1, zxc: 2, qwe: 3}
a.each_slice(2) do |b|
  print 'b: '.red; p b
end
puts 'Перебор с разбиением - и с преобразованием обратно в хэш'.green
a = {asd: 1, zxc: 2, qwe: 3}
a.each_slice(2).map(&:to_h).each do |b|
  print 'b: '.red; p b
end
# exit

puts
puts 'Фильтрация ключей'.green
a = {a: 1, b: 2, c: 3}
b = a.slice :a, :c
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit

puts 'Символизация ключей'.green
a = [{'a' => 111}]
b = a.map(&:deep_symbolize_keys)
print 'a: '.red; puts a
print 'b: '.red; puts b
c = a.each(&:deep_symbolize_keys!)
print 'a: '.red; puts a
print 'c: '.red; puts c
# exit

puts
puts 'Количество элементов .count()'.green
a = {a: 1, b: 2}
b = a.count
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit

puts 'Выбрать все значения хэша, без ключей .values().'.green
a = {a: 1, b: 2}
b = a.values
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit

puts
puts 'Удаление по ключу .delete().'.green
puts 'Возвращает удалённое.'.blue
a = {a: 1, 'a' => 2}
b = a.delete 'a'
print 'a: '.red; puts a
print 'b: '.red; puts b
a.delete :asd
a.delete :asd
a.delete :asd
print 'a: '.red; puts a
# exit

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

puts 'Слияние двух hash (.merge)'.green
a = {a:'a', c:'1'}
b = {b:'b', c:'2'}
c = a.merge(b)
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c

puts 'Слияние двух hash (.merge!)'.green
a = {a:'a', c:'1'}
b = {b:'b', c:'2'}
c = a.merge!(b)
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
# exit 0

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


# перебор Хэш
puts 'перебор Хэш'.green
a = {"id"=>"id", "tree_id"=>"tree_id", "text"=>"name", "data"=>{"article"=>"articul", "description"=>"description", "published_at"=>"published_at", "thumbnail_url"=>"thumbnail_url", "view_count"=>"view_count", "comment_count"=>"comment_count", "video_count"=>"video_count", "subscriber_count"=>"subscriber_count", "subscriber_count_visible"=>"subscriber_count_visible", "channel_id"=>"channel_id", "channel_title"=>"channel_title", "privacy_status"=>"privacy_status", "playlist_id"=>"playlist_id", "video_id"=>"video_id", "position"=>"position"}, "type"=>"item_type", "parent"=>"parent_id", "$project"=>"project_id"}
b = {}


# {
#                           "id" => "@_json_cortege['id']",
#                      "tree_id" => "@_json_cortege['tree_id']",
#                         "name" => "@_json_cortege['text']",
#                  "description" => "@_json_cortege['data']['description']",
#                   "project_id" => "_project"



def reqursive b, a, parents=[]
  a.each do |k,v|
    if v.is_a? String
      if parents.empty?
        echo_parents = ''
      else
        echo_parents = "['#{parents.join('\'][\'')}']"
      end
      if (k =~ /^\$/) != nil
        b[v] = k.gsub /^\$/, '_'
      else
        b[v] = "@_json_cortege#{echo_parents}['#{k}']"
      end
    else
      parents.push k
      reqursive b, v, parents
      parents.pop
    end
  end
end

reqursive b, a
ap b

a = {}
[
  {a:[1,2,3,4],b:[1,2,3,4]},
  {a:[5,6,7,8],c:[5,6,7,8]},
].each do |t|
  # правило merge!{|...|...} срабатывает только если есть ключ и в первом и во втором хеш
  # иначе сливает всё что есть (и цену и наличие):
  a.merge!(t) do |k, v1, v2|
    print 'k: '.red; puts k    
    print 'v1: '.red; puts v1    
    print 'v2: '.red; puts v2    
    [v1[2]] + [v2[2]]
  end
end
print 'a: '.red; puts a
# поэтому:
a = {}
[
  {a:[1,2,3,4],b:[1,2,3,4]},
  {a:[5,6,7,8],c:[5,6,7,8]},
].each do |t|
  t.each do |k, v|
    a[k] ||= []
    a[k] += [v[2]]
  end
end
print 'a: '.red; puts a

a = {}
b = a.clone
b[:a] = 0
print 'a: '.red; p a
print 'b: '.red; p b
