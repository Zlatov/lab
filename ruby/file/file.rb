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
# exit 0

puts 'Рекурсивное создание пути.'.green
FileUtils.mkdir_p(dirname) if !Dir.exist?(dirname)

puts 'Расширение файла или пустая строка'.green
puts File.extname('asd.asd/qaer4ef24r34.rffre31.ваще не понятно что?') # расширение файла (с точкой) из пути
puts File.extname('asd.asd/qaer4ef24r34.rffre31.') # или пустая строка если точка на конце
puts File.extname('asd.asd/qaer4ef24r34').class # или пустая строка если нет
a = File.extname('asd')
print 'a: '.red; puts a
print 'a.class: '.red; puts a.class
# exit 0
puts File.basename('asdasdasd/qaer4ef24r34.rffre31.ваще не понятно что?') # имя файла из пути
puts File.basename('qaer4ef24r3/4.rffre31.ваще не понятно что?', '.*') # имя без расширения из пути
# exit 0

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

max_waiting_time = 20
puts "#{max_waiting_time} секунд ожидания закрытия файла другим процессом, без остановки процесса.".green
waiting_time = 0
step_wait = 0.2
file = File.open path_to_file, 'r+'
while file.flock(File::LOCK_EX|File::LOCK_NB) != 0
  sleep step_wait
  waiting_time += step_wait
  if waiting_time > max_waiting_time
    raise 'Слишком долго ждем!'
  else
    puts "ждём ещё до #{waiting_time} секунд".green
  end
end
puts 'наконец мы получили исключительный доступ к файлу, поработаем с ним 5 секунд.'.light_blue
sleep 5
file.close
# exit 0

puts "Ожидание эксклюзивного доступа к файлу, с остановкой процесса.".green
file = File.open path_to_file, 'r+'
file.flock File::LOCK_EX
puts 'Мы получили исключительный доступ к файлу, поработаем с ним 5 секунд.'.light_blue
sleep 5
file.close
# exit 0

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

# Удаление
puts 'Удаление.'.green
fh = File.new 'temp_delete', 'w'
fh.close
File.delete('temp_delete') if File.exist?('temp_delete')
File.delete('temp_delete') if File.exist?('temp_delete')
File.delete('temp_delete') if File.exist?('temp_delete')

# TODO
# p Dir.pwd
# p File.basename(Dir.pwd)
# p Dir.chdir '..'
# p Dir['*']


# Запись в файл, перезаписывает весь контент (w по умолчанию)
puts 'Запись в файл, перезаписывает весь контент.'.green
path = './temp'
file = File.open path, 'w'
file.write "asd\n"
file.write "asd\n"
file.write "asd\n"
file.close
p File.read('./temp').split("\n")
# exit 0

a = File.exist? path
print 'a: '.red; puts a

# Запись в файл, перезаписывает весь контент
puts 'Запись в файл, перезаписывает весь контент.'.green
File.write 'temp', '123'
File.write 'temp', '123'
File.write 'temp', '123'
p File.read('temp').split("\n")
# exit 0

# Запись в файл через open()
puts 'Запись в файл через open().'.green
open('temp', 'w') do |f|
  f.puts "puts."
  f.puts "puts."
  f.puts "puts."
  f.write "write."
  f.write "write."
  f.write "write."
  f << "<<."
  f << "<<."
  f << "<<."
end
a = File.read('temp').split("\n")
print 'a: '.red; p a
exit 0

# Запись в файл через File с указанием режима
puts 'Запись в файл через File с указанием режима.'.green
File.write 'temp', 'mmm', mode: 'a'
puts File.read 'temp'
