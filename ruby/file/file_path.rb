# encoding: UTF-8
require "awesome_print"
require "pathname"


# Путь к текущему файлу
puts 'Путь к текущему файлу'.green
p Dir.pwd
p __FILE__
p $0

# 
# __FILE__ равен $0 и
# не всегда является абсолютным путём к исполняемому (этому) файлу.
# 


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
