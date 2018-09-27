# encoding: UTF-8
require "awesome_print"
require "pathname"


# Путь к текущему файлу
puts 'Путь к текущему файлу'.green
print 'Dir.pwd: '.red; puts Dir.pwd
print '$0: '.red; puts $0
print '__FILE__: '.red; puts __FILE__

# 
# __FILE__ равен $0 при запуске из sublime, но
# не всегда является абсолютным путём к исполняемому (этому) файлу, достаточно
# выйти в консоль и выполнить cd ../ && ruby ./file/file_path.rb :
# 
# Dir.pwd: /home/iadfeshchm/projects/my/lab/ruby                                                                                
# $0: ./file/file_path.rb                                                                                                       
# __FILE__: ./file/file_path.rb
# 
# То есть если опереться на __FILE__ то нужно определять отностительный или абсолютный путь
# он отдаёт, однако я выбираю Dir.pwd + $0 :
# 

puts 'Путь к текущему файлу на основе Dir.pwd + $0'.green
a = Pathname.new Dir.pwd
b = a.join $0
print 'a: '.red; puts a
print 'b: '.red; puts b

real_absolute_file_path = Pathname.new(Dir.pwd).join($0)
real_absolute_file_dir_path = Pathname.new(Dir.pwd).join($0).dirname
print 'real_absolute_file_path: '.red; puts real_absolute_file_path
print 'real_absolute_file_dir_path: '.red; puts real_absolute_file_dir_path


# Путь к домашней директории
puts 'Путь к домашней директории'.green
p Dir.home
