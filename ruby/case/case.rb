# encoding: UTF-8

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
