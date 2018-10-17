# encoding: UTF-8
require 'fileutils'
require 'awesome_print'

# Удаление директорий
Dir.rmdir 'a' if File.directory?('a')

# Создание директорий
Dir.mkdir 'a' if !Dir.exist? 'a'
Dir.mkdir '00001234' if !Dir.exist? '00001234'
Dir.mkdir '00001235' if !Dir.exist? '00001235'
Dir.mkdir '00001236' if !Dir.exist? '00001236'
FileUtils.mkdir_p 'b/c'
Dir.rmdir 'b' if Dir['b/*'].empty?
FileUtils.rm_rf("b/.", secure: true) # отчистить папку от всего
FileUtils.rm_f Dir.glob("b/*") # отчистить папку от файлов
FileUtils.mkdir_p 'c'
Dir.rmdir 'c' if Dir['c/*'].empty?


puts '-----------'.red
# path_files = "#{AppPath.files}/#{action_name}/#{params['id']}"
path_files = "./"
files_name = []
if Dir.exist? path_files
  Dir.entries(path_files).each do |file_name|
    files_name << file_name if file_name != '.' && file_name != '..'
    p file_name
    puts 'DIR!!!'.green if File.directory? file_name
  end
end
puts '-----------'.red
p 'files_name:'
files_name.each do |file_name|
  p file_name
end
puts '-----------'.red


require 'pathname'
first = Pathname.new '/first/path'
second = Pathname.new '/second/path'
relative = second.relative_path_from first
p relative.to_s
# ../../second/path
a = first + relative
p a.to_s
# /second/path

a = Pathname.new 'asd/asd/asd/asd'
a = a + '../zxc'
p a.to_s

# Глоб может выдавать список полуных путей к файлам, используй entries
puts 'Глоб может выдавать список полуных путей к файлам, используй entries'.green
p Dir.glob('*').select{|e| File.file? e}
p Dir['*'].select{|e| File.directory? e}
p Dir[first].select{|e| File.directory? e}
p Dir[__FILE__].select{|e| File.directory? e}

p __FILE__
p File.dirname(__FILE__)
p Dir[File.dirname(__FILE__) + '/*'].select{|e| File.directory? e}
p Dir.entries(File.dirname(__FILE__)).reject{|e| e == '.' || e == '..'}.select{|e| File.directory? e}
# exit

# Очистить директорию
# FileUtils.rm_r Dir.entries(File.dirname(__FILE__)).reject{|e| e == '.' || e == '..'}


FileUtils.mkdir_p 'c/d'
File.write 'c/asd', 'asd'
# p Dir['c/*']
# FileUtils.rm_r Dir['c/*']
# p Dir['c/*']

File.write 'c/origin_asd.jpg', 'asd'
p Dir['c/origin_asd*'].first
