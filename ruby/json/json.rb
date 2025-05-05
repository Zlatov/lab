# encoding: UTF-8
require 'json'
require 'awesome_print'


puts 'Json текст в переменную ruby'.green
a = '[{"id":1,"name":"Nick"},{"id":"1","name":"\\u003cb\\u003eMikle\\u003c/b\\u003e"}]'
b = JSON.parse a
print 'a: '.red; p a
print 'b: '.red; p b
# exit 0


puts 'Переменную ruby в текст json'.green
b = ['asd']
jb = b.to_json
print 'jb: '.red; puts jb
# exit 0


puts 'Автоматическое форматирование'.green
c = [{asd:'asd'},{"id"=>1}]
jc = JSON.pretty_generate c
print 'jc: '.red; puts jc
# exit 0


puts 'Json в ruby-объект с ключами-символами symbolize_names'.green
p JSON.parse('{"key": "value", "array": [1, 2]}', symbolize_names: true)
# exit 0


puts 'С булевым типом всё норм'.green
a = '{"a": true}'
b = JSON.parse a
print 'b["a"].class.name: '.red; puts b["a"].class.name
# exit 0


puts 'Глубокое сравнение двух json с перепутанными полями объектов'.green
def deep_json_equal?(json1, json2)
  obj1 = JSON.parse(json1)
  obj2 = JSON.parse(json2)
  deep_equal?(obj1, obj2)
end

def deep_equal?(a, b)
  case [a, b]
  in [Hash, Hash]
    if !(a.keys.sort == b.keys.sort)
      print 'a.keys.sort: '.red; p a.keys.sort
      print 'b.keys.sort: '.red; p b.keys.sort
      return false
    end
    a.all? { |k, v| deep_equal?(v, b[k]) }
  in [Array, Array]
    if !(a.size == b.size)
      print 'a.size: '.red; puts a.size
      print 'b.size: '.red; puts b.size
      return false
    end
    a.each_with_index.all? { |v, i| deep_equal?(v, b[i]) }
  else
    if !(a == b)
      print 'a: '.red; puts a
      print 'b: '.red; puts b
    end
    a == b
  end
end

json1 = '{"a": 1, "b": [1, 2], "c": {"x": 10, "y": 20}}'
json2 = '{"c": {"y": 20, "x": 10}, "b": [1, 2], "a": 1}'

puts deep_json_equal?(json1, json2)
puts 'Или просто:'.blue
puts JSON.parse(json1) == JSON.parse(json2)
# exit 0
