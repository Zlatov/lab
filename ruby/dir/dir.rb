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
