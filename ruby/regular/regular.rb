# encoding: UTF-8
require_relative '../colorize/colorize'

# Найдена ли подстрока | соответствует ли регулярке
puts 'Найдена ли подстрока | соответствует ли регулярке'.green
a = 'zenonline.ru/vlad/articles/articles1827.html Распродажа! на 11%! '
regex = /.+?articles\d+\.html.*/i
b = ((a =~ regex) != nil)
p b

a = 'http://zenonline.ru/vlad/articles/articles1827.html'
regex = /^http.*/i
b = ((a =~ regex) != nil)
p b

a = '_big'
b = ((a =~ /^(_small.*)|(_big1.*)|(_big2.*)/) != nil)
puts b

case true
when !('thumbnail_asd'=~/^thumbnail_.+/i).nil?
  p 1111
end


# Выбор строки
puts 'Выбор строки'.green
a = 'http://sign-forum.ru/index.php?a=b'
# endlink = a.match(/^http:\/\/sign\-forum\.ru(.*?)/i)
endlink = a.scan(/^http:\/\/sign\-forum\.ru(.*)/i).last.first
p endlink

a = 'http://www.sign-forum.ru/index.php?asd=asd'
if (a =~ /^http:\/\/www\.sign-forum\.ru.*?/i) != nil
  # b = a.scan(/^http:\/\/sign-forum\.ru(.*)/i).last.first
  b = a[/^http:\/\/www\.sign-forum\.ru(.*)/i,1]
end
print 'a: '.red; puts a
print 'b: '.red; puts b

# def сontains_text string, text
#   ((string =~ /#{text}/) != nil)
# end

# p сontains_text 'asdf', 'a'
# p сontains_text 'asdf', 'as'
# p сontains_text 'asdf', 's'
# p сontains_text 'asdf', 'f'
# p сontains_text 'asdf', 'b'

# v = '123333.21452345.23453254a'
# is_version_format = !((v =~ /^\d+\.\d+\.\d+$/).nil?)
# p is_version_format

# p 'admin.ru/asd/sadf-sa_df/?asd=wfwрусские 123123123'.split(' ')[0].gsub(/[^a-z.\-_0-9]/, '')


# Поиск строк в многострочном тексте
puts 'Поиск строк в многострочном тексте'.green
a = '
asdf sadfas dfasdf <img asfddsf="asdf" asfddsf="" src=\'asd\'>
<img src="zxc"> asd asd asd asd
sdafs<img src=""> asd asd asd asd
sdafs<img src=""> asd asd asd asd
'
# a = "<P>\r\n<TABLE border=0 align=left>\r\n<TBODY>\r\n<TR>\r\n<TD align=middle></TD></TR></TBODY></TABLE>Мобильный тент облегченный, изготовлен из алюминия с толщиной стенки 1,2 мм. Тентовая ткань белого цвета готовой формы в комплекте. Благодаря своей конструкции, тент легко и быстро можно  инсталировать в любом, необходимом месте.</P>\r\n<P>\r\n<TABLE border=0 align=left>\r\n<TBODY>\r\n<TR>\r\n<TD align=middle><IMG style=\"WIDTH: 534px; HEIGHT: 398px\" border=0 alt=\"\" src=\"/images/catalog/128.jpg\" width=739 height=517></TD></TR></TBODY></TABLE></P>\r\n<P> </P>\r\n<P> </P>\r\n<P> </P>\r\n<P>\r\n<TABLE border=0 align=left>\r\n<TBODY>\r\n<TR>\r\n<TD align=middle></TD></TR></TBODY></TABLE></P>\r\n<P> </P>\r\n<P> </P>\r\n<P> </P>\r\n<P> </P>\r\n<P> </P>\r\n<P> </P>\r\n<P> </P>\r\n<P> </P>\r\n<P> </P>\r\n<P> </P>\r\n<P>\r\n<TABLE border=0 align=left>\r\n<TBODY>\r\n<TR>\r\n<TD align=middle><IMG style=\"WIDTH: 536px; HEIGHT: 352px\" border=0 alt=\"\" src=\"/images/catalog/129.jpg\" width=744 height=519></TD></TR></TBODY></TABLE></P>"
regex = /<img .*?(?:src="(.*?)")|(?:src='(.*?)')/i
b = a.scan(regex).flatten
b = b.select{|v| !v.nil? && !v.empty? }
p b
p b.length
