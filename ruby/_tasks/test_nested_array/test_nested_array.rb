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
