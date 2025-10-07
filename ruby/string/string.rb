# encoding: UTF-8
require_relative '../colorize/colorize'
# require 'unicode_utils' # UnicodeUtils.downcase 'String'
require 'rubygems'
require 'awesome_print'

# qwerty@
# qw****@
# qwert@
# qw***@
# qwer@
# qw**@
# qwe@
# q**@
# qw@
# **@
# q@
# *@

a = '2231@example.com'
def hide_email email
  at_index = email.index('@') || 0
  show_index = case true
  when at_index >= 4
    2
  when at_index >= 3
    1
  when at_index < 3
    0
  end
  show_part = email[0, show_index]
  end_part = email[at_index..-1]
  hide_part = '*' * (at_index - show_index)
  show_part + hide_part + end_part
end
b = hide_email a
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit 0

puts 'Очистка от BOM символов.'.green
a = 'sochi@zenonline.ru﻿, svetlana.b@zenonline.ru, olga.f@zenonline.ru'
b = a.sub("\xEF\xBB\xBF", '').gsub("\r", '')
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit 0


puts "\n"
puts 'Замена в строке'.green
a = '??asd?? ??asd??'
b = a.gsub '??asd??', 'asd'
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit 0

puts 'Замена в строке по хэш (альтернатива php str_replace, максимально простое приближение)'.green
puts 'Много gsub но простая замена ключа на значение'.blue
a = "??asd?? ??asd?? ??zxc??"
b = {
  "??asd??" => "asdasd",
  "??zxc??" => "zxczxc",
}
print 'a: '.red; puts a
b.each{|k,v| a.gsub! k, v}
print 'a: '.red; puts a
puts 'Или с одним gsub но необходима общая регулярка для ключей'.blue
a = "??asd?? ??asd?? ??zxc??"
b = {
  "??asd??" => "asdasd",
  "??zxc??" => "zxczxc",
}
c = a.gsub(/\?\?\S+\?\?/, b)
print 'c: '.red; puts c
# exit 0

puts 'Замена в строке с подстановкой найденного'.green
puts 'Подстановка найденного во втором аргументе в виде \n'.blue
puts '<img src="../../images/sh_2.gif">'.gsub(/\ssrc="((\.\.\/)+)*?images/m, ' src="' + 'http://zenonline.ru/as/df/gh/' + '\1images')
puts '<img src="images/sh_2.gif">'.gsub(/\ssrc="((\.\.\/)+)*?images/m, ' src="' + 'http://zenonline.ru/as/df/gh/' + '\1images')
puts 'Подстановка найденного в блоке через переменную'.blue
a = 'asd 0001 zxc'
b = a.gsub!(/[0-9]+/){|code| "<code>#{code}</code>"}
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit


puts "\n"
puts 'Многострочность multiline'.green
a = 'строка'
  # хередок синтаксис
  puts '<<HTML', <<HTML
    вторая #{a}
    терьтя #{a}
HTML
  # удобный хередок синтаксис с возможностью отсупа ЗАКРЫВАЮЩЕГО ТЕГА
  puts '<<-TEXT', <<-TEXT
    вторая #{a}
    терьтя #{a}
  TEXT
  # Так, как будто бы это двойные кавычки
  # (автоматическое экранирование внутренних двойных кавычек)
  puts '%Q(', %Q(
    вторая "#{a}"
    терьтя "#{a}"
  )
  puts '%(', %(
    вторая "#{a}"
    терьтя #{a}
  )
  puts '%q(', %q(
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

a = <<~DESC.strip
  Строка  
  Ещё строка  
DESC
print 'a: '.red; p a
# exit

puts 'Хередок в параметрах и массивах.'.green
a = [
  <<-TEXT,
  1
  TEXT
  2
]
print 'a: '.red; print a
# exit

# Удалить пробелы вокругтекста .strip (`trim` в других языках)
puts 'Удалить пробелы вокругтекста'.green
a = '  asd asd  '
b = a.strip
print 'a: '.red; puts a
print 'b: '.red; puts b
# exit 0

puts 'Удалить специальные символы вокруг текста'.green
a = ',asd asd ,,'
b = a.gsub /,+$/, ''
c = a.gsub /(?:^,+)|(?:,+$)/, ''
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
# exit 0

puts 'Удалить окончание (суфикс)'.green
a = '- --'
b = a.delete_suffix('-')
print 'a: '.red; puts a
print 'a.length: '.red; puts a.length
print 'b: '.red; puts b
print 'b.length: '.red; puts b.length
# exit 0

# Управление регистром символов в строке (кирилица будет в v 2.4.1)
puts 'Управление регистром символов в строке'.green
puts "управление Регистром символов в строке! asd Asd".downcase!
puts "привет Макс! asd Asd".upcase!
puts "привет Макс! asd Asd".capitalize!
# `titleize` только в рельсе
# puts "привет Макс! asd Asd".titleize
# exit

puts 'Вырезать часть строки (получение подстроки) по позициям и длинне.'.green
puts '.slice(start,length)'.blue
puts '.slice(start .. finish)'.blue
p "0123456789".slice 0, 5 # "01234"  с индекса 0, 5 символов
p "0123456789".[](0, 5) # "01234"    то же самое
p "0123456789"[0, 5] # "01234"       то же самое
p "0123456789"[2, 3] # "234"         с индекса 2, 3 символа
p "0123456789"[2] # "2"              с индекса 2, 1 символ
p "0123456789"[2 .. 3] # "23"        с индекса 2 по индкс 3 (включая)
p "0123456789"[2 .. -1] # "23456789" с индекса 2 по индкс -1 (до последнего индекса)
p "0123456789"[2 .. 1] # ""          с индекса 2 по индкс 0 (в обратную сторону не извлекает)
p "0123456789"[2 .. 2] # "2"         с индекса 2 по индкс 2 (один символ)
puts 'Простой пример с префиксом'.blue
string = 'prefix_asd'
prefix = string.slice!(0, 7)
print 'string: '.red; puts string
print 'prefix: '.red; puts prefix
puts 'Суффикс suffix'.blue
string = 'asd_suffix'
suffix = string.slice!(-7, 7)
print 'string: '.red; puts string
print 'suffix: '.red; puts suffix
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
# exit

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


a = '%s'
b = 1
c = a % b
print 'c: '.red; puts c
