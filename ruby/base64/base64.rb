# encoding: UTF-8

# Раскодирует изображение из base64 строки полученной JS `canvas.toDataURL(mime_type)`

require 'awesome_print'
require 'base64'
require 'mime/types'

base_64_encoded_data = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAIAAAACCAIAAAD91JpzAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAB3RJTUUH4gkOCzMB9a6/LAAAABl0RVh0Q29tbWVudABDcmVhdGVkIHdpdGggR0lNUFeBDhcAAAAVSURBVAjXBcEBAQAAAIAQ/08XUKkwKeQF+2OdNgAAAAAASUVORK5CYII='

# Регулярка разделяющая миме-тип и контент файла
REGEXP = /\Adata:([-\w]+\/[-\w\+\.]+)?;base64,(.*)/m

data_uri_parts = base_64_encoded_data.match(REGEXP) || []
exit 1 if data_uri_parts.length < 3

print 'data_uri_parts[1]: '.red; puts data_uri_parts[1]
print 'data_uri_parts[2]: '.red; puts data_uri_parts[2]

# Определение расширения по миме-типу
extension = MIME::Types[data_uri_parts[1]].first.preferred_extension

# Сохранение файла
file_name = "temp_image.#{extension}"
File.open(file_name, 'wb') do |f|
  f.write(Base64.decode64(data_uri_parts[2]))
end
