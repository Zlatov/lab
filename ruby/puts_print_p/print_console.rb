#!/usr/bin/env ruby

# Запуск:
# ./print_console.rb
# или
# ruby print_console.rb

require 'awesome_print'

puts 'Показываем прогрес выполнения задачи выполненными шагами'.green
a = (1..1000).to_a
b = a.length
i = 0
a.each do |c|
  printf "%4s / %s\r", i+= 1, b
  # $stdout.flush
  sleep 0.001
end
puts
# exit

puts 'Показываем прогрес выполнения задачи процентами'.green
a = (0..99).to_a
a.each_with_index do |c, index|
  printf "Выполнено %s%%\r", (index.to_f/a.length*100).floor
  sleep 0.01
end
puts "Выполнено 100%\r"
# exit

puts 'Показываем прогрес выполнения задачи заполнением шкалы'.green
a = (0..99).to_a
a.each_with_index do |c, index|
  percent = (index.to_f/a.length*100).floor
  printf "\rВыполнено %s", '[' + '=' * percent + '-' * (100 - percent) + ']'
  sleep 0.01
end
puts "\rВыполнено [" + '=' * 100 + "]"
# exit
