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
puts 'Ждём экслюзивного доступа с остановкой процесса.'.green
file.flock File::LOCK_EX
puts 'Получили экслюзивный доступ.'.green
puts 'Просто не отдам файл 10 секунд!'.green
sleep 10
file.flock File::LOCK_UN
puts 'Нате!'.green
sleep 1
puts 'Ждём экслюзивного доступа с остановкой процесса.'.green
file.flock File::LOCK_EX
puts 'Получили экслюзивный доступ.'.green
sleep 5
file.close
puts 'Done.'.green
