require 'active_support/all'
require 'awesome_print'
require 'nested_array'

puts 'Попробуем загрузить temp_tree.json'.green
if File.exist? 'temp_tree.json'
  tree = JSON.parse File.read('temp_tree.json')
  puts 'Загружен'.green
  tree = NestedArray::Array.new tree
  print 'tree[2]: '.red; puts tree[2]
  nested = tree.to_nested(parent_id: 'parent', root_id: '#')
  print 'nested.length: '.red; puts nested.length
  print 'nested: '.red; puts nested
end

a = [
  {"id" => 1, "parent_id" => nil},
  {"id" => 2, "parent_id" => 1},
]
print 'a: '.red; puts a

b = a.to_nested
print 'b: '.red; puts b

c = a.nested_to_html do |node|
  node["id"]
end
print 'b: '.red; puts b
