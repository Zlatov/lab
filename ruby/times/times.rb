require 'awesome_print'

2.times do
  print 'asd'.green # asdasd
end
puts

2.times do |i|
  print "#{i}".green # 01
end
puts

10.times do |i|
  puts ((rand(5) + 1) * 0.1).round(1)
end
