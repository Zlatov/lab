# Запись файла
path = "#{AppPath.files}/#{params[:type]}/#{params[:id]}"
params[:files].each do |file_info|
  File.open("#{path}/#{file_info.original_filename}", 'wb') do |file|
    file.write(file_info.read)
  end
end

# Удаление файла
file_path = "#{AppPath.files}/#{params[:file_path]}"
if File.exist? file_path
  if File.delete(file_path) > 0
    ok 'Файл удалён.', true
    return
  else
    ok 'Файл не удалён.', false
    return
  end
else
  ok 'Файла не существовало.', true
  return
end

def ok *message
  # render plain: 'ok', status: 500
  render json: message.to_json, status: :ok
end
