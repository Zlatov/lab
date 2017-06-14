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
