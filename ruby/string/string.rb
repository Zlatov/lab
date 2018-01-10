# encoding: UTF-8
require_relative '../colorize/colorize'
require 'unicode_utils' # UnicodeUtils.downcase 'String'
require 'rubygems'
require 'awesome_print'

# Многострочность multiline
puts 'Многострочность multiline'.green
  puts '...', <<-TEXT
    вторая строка
    терьтя строка
  TEXT
  puts '...', %Q(
    вторая строка
    терьтя строка
  )
  puts '...', %(
    вторая строка
    терьтя строка
  )
  puts '...', %q(
    вторая строка
    терьтя строка
  )

# Удалить пробелы вокругтекста (`trim` в других языках)
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
puts 'Простой пример с префиксом'.blue
a = 'prefix_needle'
c = 'prefix_'
b = a.slice c.length, a.length
print 'needle: '.red; puts b


# Скопировать часть строки регуляркой
puts 'Скопировать часть строки регуляркой [//,1]'.green
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
a = '<strong>asdf<strong>'
b = a.gsub! '<', '&lt;'
print 'a: '.red; puts a
print 'b: '.red; puts b
puts '<img src="../../images/sh_2.gif">'.gsub(/\ssrc="((\.\.\/)+)*?images/m, ' src="' + 'http://zenonline.ru/as/df/gh/' + '\1images')
puts '<img src="images/sh_2.gif">'.gsub(/\ssrc="((\.\.\/)+)*?images/m, ' src="' + 'http://zenonline.ru/as/df/gh/' + '\1images')

# Последняя позиция подстроки, подстрока по позиции и длинне
puts 'Последняя позиция подстроки, подстрока по позиции и длинне'.green
text = 'he/el/lo'
p i = text.rindex('/')
p text.slice(0, i+1)

# В массив
puts
puts 'В массив'.green
a = "1,2,3,4"
b = a.split(",")
print 'a: '.red; puts a
print 'b: '.red; puts b
a = " asd, \n zxc, \n qwe "
b = a.strip.split("\s\n\s").first.delete ','
print 'a: '.red; puts a
print 'b: '.red; ap b

# Дату в форматированный текст
puts 'Дату в форматированный текст'.green
p DateTime.now.strftime("%-y%-j%H_")
p DateTime.now.strftime("%e_") + (3 + 1).to_s

a = 'data:image/png;base64,iVBOR....'
b = a.index(',') + 1
c = a[b..-1]
puts c

a = [
  '',
  '0',
  '.',
  ',',
  '.0',
  '.1',
  '.01',
  '.9',
  ',0',
  ',1',
  ',01',
  ',9',
  '0.0',
  '0.1',
  '0.01',
  '0.9',
  '0,0',
  '0,1',
  '0,01',
  '0,9',

  '1,0',
  '1.0',

  '1,1',
  '1.1',

  '1,9',
  '1.9'
]
a.each do |v|
  print 'v.to_i: '.red; puts v.to_i
  print 'v.to_f: '.red; puts v.to_f
end

a = "Ширина"
b = a[/\((.*?)\)/,1]
c = a[/^[^\(]*/].strip
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
