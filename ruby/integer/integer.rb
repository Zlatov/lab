# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

puts -1.class
puts Integer.class

a = 1
puts a.is_a?(Integer)

a = "%g"
puts a % 0
puts a % 0.001
puts a % 0.01
puts a % 0.1

puts a % 1
puts a % 1.001
puts a % 1.01
puts a % 1.1

puts a % 10
puts a % 10.001
puts a % 10.01
puts a % 10.1

puts a % 100
puts a % 100.001
puts a % 100.01
puts a % 100.1

puts "#{'%g' % 5.0000}"
