# encoding: UTF-8
require 'fileutils'

# Удаление директорий
Dir.rmdir 'a' if File.directory?('a')

# Создание директорий
Dir.mkdir 'a' if !Dir.exist? 'a'
FileUtils.mkdir_p 'b/c'
Dir.rmdir 'b' if Dir['b/*'].empty?
FileUtils.rm_rf("b/.", secure: true) # отчистить папку от всего
FileUtils.rm_f Dir.glob("b/*") # отчистить папку от файлов
FileUtils.mkdir_p 'c'
Dir.rmdir 'c' if Dir['c/*'].empty?


# path_files = "#{AppPath.files}/#{action_name}/#{params['id']}"
path_files = "./"
files_name = []
if Dir.exist? path_files
  Dir.entries(path_files).each do |file_name|
    files_name << file_name if file_name != '.' && file_name != '..'
    p file_name
  end
end
p 'files_name:'
files_name.each do |file_name|
  p file_name
end


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
p Dir.glob('*').select{|e| File.file? e}
p Dir['*'].select{|e| File.directory? e}
p Dir[first].select{|e| File.directory? e}
p Dir[__FILE__].select{|e| File.directory? e}

p __FILE__
p File.dirname(__FILE__)
p Dir[File.dirname(__FILE__) + '/*'].select{|e| File.directory? e}
p Dir.entries(File.dirname(__FILE__)).reject{|e| e == '.' || e == '..'}.select{|e| File.directory? e}

# Очистить директорию
# FileUtils.rm_r Dir.entries(File.dirname(__FILE__)).reject{|e| e == '.' || e == '..'}
