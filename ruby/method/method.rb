# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

puts 'return работает привычно в циклах, ага.'.green
def includes?
  [1,2,3].each do |e|
    return true if e == 2
  end
  return false
end

print 'includes?: '.red; puts includes?

puts 'Лямбда метод'.green
a = lambda do |b, c|
  puts b + c
end
a.call 2, 3
print 'a: '.red; puts a

puts 'Метод с лямбда для синглтон значения'.green
class A
  def brand
    @brand ||= lambda do
      return Time.new.to_i
    end.call
  end
end
a = A.new
print 'a.brand: '.red; puts a.brand
sleep 2
print 'a.brand: '.red; puts a.brand

puts 'Метод []'.green
class Asd
  CONST = [1, 2, 3]
  def self.[](key)
    CONST[key]
  end
end
print 'Asd[1]: '.red; puts Asd[1]
