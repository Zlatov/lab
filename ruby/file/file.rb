# encoding: UTF-8
require 'fileutils'
require_relative '../colorize/colorize'
require 'json'
$stdout.sync = true

# 
# somefile = File.open 'path_to_file'[, 'w+']
# somefile.flock = ...
# somefile.pos = ...
# somefile.truncate 0
# somefile.close
# 
# или
# 
# File.open 'path_to_file'[, 'w+'] do |file|
#   file. ...
# end
# 
# ┏━━━━┳━━━━━━━━┳━━━━━━━━┳━━━━━━━━━━━┳━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━┓
# ┃    ┃ чтение ┃ запись ┃ указатель ┃ содержимое ┃ создание файла ┃
# ┣━━━━╋━━━━━━━━╋━━━━━━━━╋━━━━━━━━━━━╋━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━┫
# ┃ r  ┃   +    ┃   -    ┃  начало   ┃            ┃       -        ┃
# ┣━━━━╋━━━━━━━━╋━━━━━━━━╋━━━━━━━━━━━╋━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━┫
# ┃ r+ ┃   +    ┃   +    ┃  начало   ┃ оставляет  ┃       -        ┃
# ┣━━━━╋━━━━━━━━╋━━━━━━━━╋━━━━━━━━━━━╋━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━┫
# ┃ w  ┃   -    ┃   +    ┃  начало   ┃  удаляет   ┃       +        ┃
# ┣━━━━╋━━━━━━━━╋━━━━━━━━╋━━━━━━━━━━━╋━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━┫
# ┃ w+ ┃   +    ┃   +    ┃  начало   ┃  удаляет   ┃       +        ┃
# ┣━━━━╋━━━━━━━━╋━━━━━━━━╋━━━━━━━━━━━╋━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━┫
# ┃ a  ┃   -    ┃   +    ┃   конец   ┃ оставляет  ┃       +        ┃
# ┣━━━━╋━━━━━━━━╋━━━━━━━━╋━━━━━━━━━━━╋━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━┫
# ┃ a+ ┃   +    ┃   +    ┃   конец   ┃ оставляет  ┃       +        ┃
# ┗━━━━┻━━━━━━━━┻━━━━━━━━┻━━━━━━━━━━━┻━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━┛
# ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
# ┃ file.flock                    ┃                                                                     ┃
# ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
# ┃ File::LOCK_EX                 ┃ Исключительная блокировка, никакой другой                           ┃
# ┃ File::LOCK_EX                 ┃ процесс не может обратиться к файлу.                                ┃
# ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
# ┃ File::LOCK_UN                 ┃ Разблокировать.                                                     ┃
# ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
# ┃ File::LOCK_SH                 ┃ Разделяемая блокировка (другие                                      ┃
# ┃ File::LOCK_SH                 ┃ процессы могут сделать то же самое).                                ┃
# ┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┫
# ┃ File::LOCK_EX | File::LOCK_NB ┃ Пытаемся заблокировать файл, но не приостанавливаем программу, если ┃
# ┃                               ┃ не получилось; в таком случае переменная locked будет равна false.  ┃
# ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

path_to_file = './data/json.json'

puts 'Существование файла.'.green

file_exist = File.exist? path_to_file
print 'file_exist: '.light_blue; puts file_exist

puts 'Путь к директории файла.'.green

dirname = File.dirname path_to_file
print 'dirname: '.light_blue; puts dirname

puts 'Рекурсивное создание пути.'.green
FileUtils.mkdir_p(dirname) if !Dir.exist?(dirname)

puts 'Расширение файла'.green
puts File.extname('qaer4ef24r34.rffre31.ваще не понятно что?')
puts File.basename('qaer4ef24r34.rffre31.ваще не понятно что?')

puts 'Открыте файла на запись.'.green

file = File.open path_to_file, 'r+'

puts 'Проверка открыт ли файл.'.green

print 'file.closed?: '.light_blue; puts file.closed?
file.close
print 'file.closed?: '.light_blue; puts file.closed?

puts 'Блокировка файла.'.green

file = File.open path_to_file, 'r+'
flock = file.flock File::LOCK_EX|File::LOCK_NB
print 'flock: '.light_blue; puts flock
flock = file.flock File::LOCK_EX|File::LOCK_NB
print 'flock: '.light_blue; puts flock

puts 'Чтение контента файла.'.green
# content = JSON.parse file.read
content = file.read
print 'content: '.light_blue; p content
file.close

puts 'Двойное открытие файла, если открыт - закрываем.'.green
file = File.open path_to_file, 'r+'
flock = file.flock File::LOCK_EX|File::LOCK_NB
print 'flock: '.light_blue; puts flock
file2 = File.open path_to_file, 'r+'
flock2 = file2.flock File::LOCK_EX|File::LOCK_NB
print 'flock2: '.light_blue; puts flock2
if flock2==false
  file2.close
end
file.close


# puts '10 с ожидания закрытия файла другим процессом.'.green
# file = File.open path_to_file, 'r+'
# sleep_time = 0
# while ( file.flock(File::LOCK_EX|File::LOCK_NB)!=0 )
#   sleep(0.5)
#   sleep_time+=1
#   if sleep_time > 10
#     raise 'Слишком долго ждем!'
#   end
# end
# puts 'наконец мы получили исключительный доступ к файлу!'.light_blue
# file.close


puts 'Запись в файл.'.green
file = File.open path_to_file, 'r+'
sleep_time = 0
while file.flock(File::LOCK_EX|File::LOCK_NB) != 0
  sleep(0.2)
  sleep_time+= 0.2
  if sleep_time > 10
    raise 'Слишком долго ждем!'
  end
end
file.write JSON.pretty_generate [{asd:'asd'},{"id"=>312}]
file.close

file = File.open path_to_file
p file.read
file.close

# file = File.open path_to_file, 'r+'
# sleep_time = 0
# while ( file.flock(File::LOCK_EX|File::LOCK_NB)!=0 )
#   sleep(0.5)
#   sleep_time+=1
#   if sleep_time > 10
#     raise 'Слишком долго ждем!'
#   end
# end
# file.truncate 0
# file.write JSON.pretty_generate [{asd:'asd'},{"id"=>1}]
# file.close

# p File.read path_to_file

p File.basename 'asd.zxc'
p File.basename 'http://sadf.ru/asdf.jpg?asd'
p File.basename( 'http://sadf.ru/asdf.jpg?asd', '.*' )

a = File.read('/asdasdasd') rescue 123
print 'a: '.red; puts a
