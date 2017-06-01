arr = []
arr = Array.new
arr = Array.new(5)
arr = Array.new(5,"aaaaa")
arr << :a
arr << :b
arr << :c
arr << :d
p arr.sample
arr = ['asd', 'asd', 'asd']
p arr
arr = %w[asd asd asd]
p arr

arr.each do |item|
  p item
end

arr.each_with_index do |key, value|
  puts key.to_s, value
end

p arr.count
