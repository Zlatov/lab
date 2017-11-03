# encoding: UTF-8
require_relative '../colorize/colorize'
require 'unicode_utils' # UnicodeUtils.downcase 'String'

# Удалить пробелы вокругтекста
puts 'Удалить пробелы вокругтекста'.green
p ' sdf sdf '.strip

# Управление регистром символов в строке (кирилица будет в v 2.4.1)
puts "привет Макс! asd Asd".downcase!
puts UnicodeUtils.downcase('привет Макс! asd Asd')
# puts "привет Макс! asd Asd".mb_chars.upcase!
# puts "привет Макс! asd Asd".mb_chars.capitalize!
# puts "привет Макс!".titleize #rails

# Вырезать по позиции
puts 'Вырезать по позиции'.green
puts 'slice'.blue
p "date".slice 0, 2
mysql_error_message = "Mysql2::Error: Длинна title превышает допустимое значение.: CALL set_seo('vips_j3_166', '123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-12', NULL, NULL, NULL, NULL);"
p mysql_error_message.length
p mysql_error_message.slice(15, mysql_error_message.length-15)


a = 'prefix_needle'
b = a.slice c.length+1, a.length
print 'b: '.red; puts b


# Скопировать часть строки регуляркой
puts 'Скопировать часть строки регуляркой'.green
a = 'thumbnail_asd'
b = a[/^(?:origin_|thumbnail_|view_|big_)(.+)/,1]
print 'a: '.red; puts a
print 'b: '.red; puts b

a = 'prefix_needle'
b = a[/prefix_(.*)/, 1]
print 'a: '.red; puts a
print 'b: '.red; puts b

# Текст даты в дату
puts 'Текст даты в дату'.green
require 'date'
d1 = DateTime.parse("2015-01-10","%Y%-m%-d")
p d2 = DateTime.parse("1979-12-12","%Y%-m%-d")
p d1<d2

# Замена в строке
puts 'Замена в строке'.green
p '<strong>asdf<strong>'.gsub! '<', '&lt;'
puts '<img src="../../images/sh_2.gif">'.gsub(/\ssrc="((\.\.\/)+)*?images/m, ' src="' + 'http://zenonline.ru/as/df/gh/' + '\1images')
puts '<img src="images/sh_2.gif">'.gsub(/\ssrc="((\.\.\/)+)*?images/m, ' src="' + 'http://zenonline.ru/as/df/gh/' + '\1images')

# Последняя позиция подстроки, подстрока по позиции и длинне
puts 'Последняя позиция подстроки, подстрока по позиции и длинне'.green
text = 'he/el/lo'
p i = text.rindex('/')
p text.slice(0, i+1)

# В массив
puts 'В массив'.green
p "1,2,3,4".split(",") # ["1", "2", "3", "4"]

# Дату в форматированный текст
puts 'Дату в форматированный текст'.green
p DateTime.now.strftime("%-y%-j%H_")
p DateTime.now.strftime("%e_") + (3 + 1).to_s

a = 'data:image/png;base64,iVBOR....'
b = a.index(',') + 1
c = a[b..-1]
puts c
