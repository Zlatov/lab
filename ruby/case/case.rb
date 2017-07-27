# encoding: UTF-8
require_relative '../colorize/colorize'

a = 1..5
p a
a.each do |value|
  case value
  when 1
    p 1
  when 2
    p 2
  end
end

a = 3

b = case a
when 1..5
  "It's between 1 and 5"
when 6
  "It's 6"
when String
  "You passed a string"
else
  "You gave me #{a} -- I have no idea what to do with that."
end

puts b.red

b = case true
when a===3
  "case true"
when 6
  "It's 6"
when String
  "You passed a string"
else
  "You gave me #{a} -- I have no idea what to do with that."
end

puts b.red
