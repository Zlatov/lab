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
