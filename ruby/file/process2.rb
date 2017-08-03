# encoding: UTF-8
require 'fileutils'
require_relative '../colorize/colorize'
$stdout.sync = true

# 100.times do
#   print "."
#   sleep 0.1
# end

path_to_file = './data/json.json'
file = File.open path_to_file, 'r+'

puts 'Ждём экслюзивного доступа!'.green
sleep_time = 0
# while ( file.flock(File::LOCK_EX|File::LOCK_NB)!=0 )

while ( file.flock(File::LOCK_EX) != 0 )
# while ( file.flock(File::LOCK_EX)!=0 )
  sleep(0.2)
  sleep_time+=0.2
  if sleep_time > 10
    raise 'Слишком долго ждем!'
  end
end
puts 'Получили доступ!'.green
gg = file.flock File::LOCK_EX
print 'gg: '.light_blue; puts gg
# gg = file.flock File::LOCK_EX|File::LOCK_NB
# print 'gg: '.light_blue; puts gg
# gg = file.flock File::LOCK_EX|File::LOCK_NB
# print 'gg: '.light_blue; puts gg
puts 'Просто не отдам файл 30 секунд!'.green
sleep(30)
# file.flock File::LOCK_UN
puts 'Нате!'.green
file.close
