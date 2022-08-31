# encoding: UTF-8
require 'awesome_print'
require 'csv'


puts 'Запись в файл через CSV.open'.green
CSV.open("temp_.csv", "w") do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
end


puts 'Разделитель при CSV.open'.green
CSV.open("temp_2.csv", "w", :col_sep => "\t") do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
end


puts 'Запись в файл через CSV.open в одну строку'.green
CSV.open("temp_3.csv", "w"){|csv| ['asd', 'zxc'].each{|line| csv << [line]}}


puts 'Генерировать CSV текст вместо записи в файл CSV.generate'.green
a = CSV.generate do |csv|
  csv << ["row", "of", "CSV", "data"]
  csv << ["another", "row"]
end
print 'a: '.red; p a


puts 'Данные в CSV строку и обратно .to_csv .parse_csv'.green
a = ["CSV", "data"].to_csv
b = "CSV,String".parse_csv
c = CSV.parse("1,chocolate\n2,bacon\n3,apple")
print 'a: '.red; puts a
print 'b: '.red; p b
print 'c: '.red; p c


puts 'Чтение CSV.read'.green
puts 'Переводит весь файл в массив'.blue
lines = CSV.read("temp_.csv")
lines.each do |line|
  print 'line: '.red; p line
  print 'line[0]: '.red; puts line[0]
end


puts 'Чтение данных в CSV-таблицу CSV.parse(..., headers: true)'.green
CSV.open("temp_4.csv", "w") do |csv|
  csv << ["id", "name"]
  csv << ["1", "Asd"]
  csv << ["2", "Zxc"]
  csv << ["3", "Qwe"]
end
table = CSV.parse(File.read("temp_4.csv"), headers: true)
print 'table: '.red; p table
print 'table[0]: '.red; p table[0]
print 'table[0]["id"]: '.red; p table[0]["id"]
a = table.by_col[0]
b = table.by_col[1]
c = table.by_row[0]
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c


puts 'Чтение больших файлов CSV.foreach'.green
# If you want to process big CSV files (> 10MB) you may want to use the
# CSV.foreach(file_name) method with a block. This will read one row at a
# time & use a lot less memory.
