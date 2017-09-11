# encoding: UTF-8
require_relative '../colorize/colorize'

# Удалить пробелы вокругтекста
puts 'Удалить пробелы вокругтекста'.green
p ' sdf sdf '.strip

# Вырезать по позиции
puts 'Вырезать по позиции'.green
p "date".slice 0, 2
mysql_error_message = "Mysql2::Error: Длинна title превышает допустимое значение.: CALL set_seo('vips_j3_166', '123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-12', NULL, NULL, NULL, NULL);"
p mysql_error_message.length
p mysql_error_message.slice(15, mysql_error_message.length-15)

# Текст даты в дату
puts 'Текст даты в дату'.green
require 'date'
d1 = DateTime.parse("2015-01-10","%Y%-m%-d")
p d2 = DateTime.parse("1979-12-12","%Y%-m%-d")
p d1<d2


p '<strong>asdf<strong>'.gsub! '<', '&lt;'

text = 'he/el/lo'
p i = text.rindex('/')
p text.slice(0, i+1)

puts '<img src="../../images/sh_2.gif">'.gsub(/\ssrc="((\.\.\/)+)*?images/m, ' src="' + 'http://zenonline.ru/as/df/gh/' + '\1images')
puts '<img src="images/sh_2.gif">'.gsub(/\ssrc="((\.\.\/)+)*?images/m, ' src="' + 'http://zenonline.ru/as/df/gh/' + '\1images')


# В массив
puts 'В массив'.green
p "1,2,3,4".split(",") # ["1", "2", "3", "4"]

p DateTime.now.strftime("%-y%-j%H_")
p DateTime.now.strftime("%e_") + (3 + 1).to_s