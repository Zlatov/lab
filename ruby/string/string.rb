# encoding: UTF-8
require_relative '../colorize/colorize'
# require 'unicode_utils' # UnicodeUtils.downcase 'String'
require 'rubygems'
require 'awesome_print'

puts 'Очистка от BOM символов.'.green
a = 'sochi@zenonline.ru﻿, svetlana.b@zenonline.ru, olga.f@zenonline.ru'
b = a.sub("\xEF\xBB\xBF", '').gsub("\r", '')
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit 0

puts 'Альтернатива php str_replace, замена подстрок в тексте.'.green
a = '??asd?? ??asd??'
b = a.gsub '??asd??', 'asd'
print 'a: '.red; puts a
print 'b: '.red; puts b

a = "??asd?? ??asd?? ??zxc??"
b = {
  "??asd??" => "asdasd",
  "??zxc??" => "zxczxc",
}
print 'a: '.red; puts a
b.each{|k,v| a.gsub! k, v}
print 'a: '.red; puts a
# exit

# Многострочность multiline
puts 'Многострочность multiline'.green
a = 'строка'
  # хередок синтаксис
  puts '...', <<HTML
    вторая #{a}
    терьтя #{a}
HTML
  # удобный хередок синтаксис с возможностью отсупа
  puts '...', <<-TEXT
    вторая #{a}
    терьтя #{a}
  TEXT
  # Так, как будто бы это двойные кавычки
  # (автоматическое экранирование внутренних двойных кавычек)
  puts '...', %Q(
    вторая "#{a}"
    терьтя "#{a}"
  )
  puts '...', %(
    вторая #{a}
    терьтя #{a}
  )
  puts '...', %q(
    вторая #{a}
    терьтя #{a}
  )
b = {
  "asd": %Q(
    asd
  ),
  zxc: 2
}
print 'b: '.red; puts b

puts 'Хередок в параметрах и массивах.'.green
a = [
  <<-TEXT,
  1
  TEXT
  2
]
print 'a: '.red; print a
# exit

# Удалить пробелы вокругтекста (`trim` в других языках)
puts 'Удалить пробелы вокругтекста'.green
a = ' asd asd  '
b = a.strip
print 'a: '.red; puts a
print 'b: '.red; puts b

puts 'Удалить специальные символы вокруг текста'.green
a = ',asd asd ,,'
b = a.gsub /,+$/, ''
c = a.gsub /(?:^,+)|(?:,+$)/, ''
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
# exit 0

# Управление регистром символов в строке (кирилица будет в v 2.4.1)
puts 'Управление регистром символов в строке'.green
puts "управление Регистром символов в строке! asd Asd".downcase!
puts "привет Макс! asd Asd".upcase!
puts "привет Макс! asd Asd".capitalize!
# `titleize` только в рельсе
# puts "привет Макс! asd Asd".titleize
# exit

puts 'Вырезать часть строки по позиции'.green
puts '.slice(start,length)'.blue
puts '.slice(start .. finish)'.blue
p "0123456789".slice 0, 5 # "01234"
p "0123456789".[](0, 5) # "01234"
p "0123456789"[0, 5] # "01234"
p "0123456789".slice 2, 3 # "234"
p "0123456789".slice 2 # "2"
p "0123456789"[2] # "2"
p "0123456789"[2, 3] # "234"
p "0123456789"[2 .. 3] # "23"
p "0123456789"[2 .. -1] # "23456789"
p "0123456789"[2 .. 0] # ""
p "0123456789"[2 .. 1] # ""
mysql_error_message = "Mysql2::Error: Длинна title превышает допустимое значение.: CALL set_seo('vips_j3_166', '123456789-123456789-123456789-123456789-123456789-123456789-123456789-123456789-12', NULL, NULL, NULL, NULL);"
p mysql_error_message.length
p mysql_error_message.slice(15, mysql_error_message.length-15)
p mysql_error_message.slice(15 .. -1)
puts 'Простой пример с префиксом'.blue
a = 'prefix_needle'
c = 'prefix_'
b = a.slice c.length, a.length
print 'needle: '.red; puts b
# exit


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
d = "01-02-03"
a = DateTime.parse(d)
b = DateTime.strptime(Time.now.strftime("%Y-%m-%d").to_s, "%Y-%m-%d")
c = Date.strptime(d, "%m-%Y-%d")
print 'd: '.red; puts d
print 'a: '.red; puts a.strftime("%m/%d/%Y")
print 'b: '.red; puts b.strftime("%m/%d/%Y")
print 'c: '.red; puts c.strftime("%m/%d/%Y")
# exit

# Замена в строке
puts 'Замена в строке'.green
a = '<strong>asdf<strong>'
b = a.gsub! '<', '&lt;'
print 'a: '.red; puts a
print 'b: '.red; puts b
puts '<img src="../../images/sh_2.gif">'.gsub(/\ssrc="((\.\.\/)+)*?images/m, ' src="' + 'http://zenonline.ru/as/df/gh/' + '\1images')
puts '<img src="images/sh_2.gif">'.gsub(/\ssrc="((\.\.\/)+)*?images/m, ' src="' + 'http://zenonline.ru/as/df/gh/' + '\1images')

a = '1231231'
b = a.gsub /\B(?=(\d{3})+(?!\d))/, ' '
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit

a = 'zenonline.ru/cgi-bin/caravans/client.cgi?phil_id=1&top=10ФывапыRub'
b = a.gsub /[^a-z0-9_]/i, '_'
print 'a: '.red; puts a
print 'b: '.red; puts b

puts 'Последняя позиция подстроки, подстрока по позиции и длинне'.green
text = 'he/el/lo'
p i = text.rindex('/')
p text.slice(0, i+1)

puts 'В массив'.green
a = "1,2,3,4"
b = a.split(",")
print 'a: '.red; puts a
print 'b: '.red; puts b
a = " asd, \n zxc, \n qwe "
b = a.strip.split("\s\n\s").first.delete ','
print 'a: '.red; puts a
print 'b: '.red; ap b
puts 'Лимитировать количество разбиений вторым параметром'.green
a = "asd_qwe_zxc"
b = a.split("_", 2)
print 'a: '.red; puts a
print 'b: '.red; ap b
# exit

puts 'Многострочный текст в массив'.green
a = <<-TEXT
     a@a.a ,   b@b.b
b@b.b
c@c.c
d@d.d,
 a@a.a, a@a.a,    
 e@e.e e@e.e,    
    TEXT
b = a.strip.split("\n").map{|e|e.split(',')}.flatten.map(&:strip).uniq
print 'a: '.red; puts a
print 'b: '.red; p b
c = a
  .split("\n") # разбить в массив по переносам
  .map{|e| e.split(/\s?,?\s+/)} # разбить каждую строку в массив по регулярке
  .flatten # в плоский массив
  .reject{|e| e==""} # избавляемся от пустых строк
  .uniq
print 'c: '.red; p c
exit

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
puts "string".send "red"

a = '   0.2452354 , 334.23524 52  '
b, c = *a.split(',').map(&:strip).map(&:to_f)
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c

a = 'http://asd.ru/asd/zxc?qwe=123'
b = a.sub /^http[s]{0,1}:\/\//i, ''
c = b[/([^\/]*)/i,1]
d = b.sub /[^\/]*/i, ''
print 'a: '.red; p a
print 'b: '.red; p b
print 'c: '.red; p c
print 'd: '.red; p d
