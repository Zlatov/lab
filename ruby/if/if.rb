# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

@a = ['1','2']
def slug_exists slug
  @a.include? slug
end
slug = '1'
new_slug = slug
i = 1

while slug_exists(new_slug)
  i+= 1
  new_slug = "#{slug}-#{i}"
end

print 'new_slug: '.red; puts new_slug

puts 'Если значение поппадает в диапазон.'.green
a = 2
if 1 > a || a > 3
  puts "bad"
else
  puts "good"
end
if 1 <= a && a <= 3
  puts "good"
else
  puts "bad"
end
