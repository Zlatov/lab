# encoding: UTF-8
require 'awesome_print'

puts 'Соответствует ли регулярному выражению.'.green
a = /s/
b = "asd"
c = "zxc"
puts !(a =~ b).nil?
puts !(b =~ a).nil?
puts !(a =~ c).nil?
puts !(c =~ a).nil?
# exit

puts 'Поиск подстрок(и) в тексте.'.green
a = "asd123asd$$$\nasd456asd$$$"
b = /(\d+)\w+(.*)/
c = a.scan(b)
print 'c: '.red; p c
# exit

# Найдена ли подстрока | соответствует ли регулярке
puts 'Найдена ли подстрока | соответствует ли регулярке'.green
a = 'zenonline.ru/vlad/articles/articles1827.html Распродажа! на 11%! '
regex = /.+?articles\d+\.html.*/i
b = ((a =~ regex) != nil)
p b

a = 'view_a'
b = !(/^origin_.+|^thumbnail_.+|^view_.+|^big_.+/ =~ a).nil?
print 'b: '.red; puts b

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

a = '

<div style="COLOR: #383838; FONT: 13px Tahoma, Verdana, sans-serif; MARGIN: 0px auto; WIDTH: 590px">
<h1 style="FONT-SIZE: 18px; TEXT-TRANSFORM: none; COLOR: #ff6500; TEXT-ALIGN: center; MARGIN: 15px 0px 20px">Знакомьтесь: ЗЕНОН АКАДЕМИЯ! </h1>
<div style="PADDING-BOTTOM: 25px; TEXT-ALIGN: center"><a style="TEXT-DECORATION: none" href="/mosc/articles/articles2511.html?utm_source=sendingEmail&amp;utm_content=2511" target="_blank">
<img style="BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px; BORDER-LEFT: 0px" alt="" src="/images/articles/10716.jpg" width="590" height="275"> </a>
<img style="BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px; BORDER-LEFT: 0px" alt="" src="/images/articles/10716.jpg" width="590" height="275"> </a>
<img style="BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px; BORDER-LEFT: 0px" alt="" src="/images/articles/10716.jpg" width="590" height="275"> </a>
</div>
<div style="PADDING-BOTTOM: 15px; TEXT-ALIGN: center"><b>Уважаемые партнеры и те, кто только планирует сотрудничество с компанией "ЗЕНОН - Рекламные Поставки"!</b> </div>
<p style="COLOR: #383838; FONT: 13px/16px Tahoma, verdana, sans-serif; MARGIN: 0px 0px 15px">Всем известно, что наша компания давно и активно занимается семинарской деятельностью на территории России. </p>
<p style="COLOR: #383838; FONT: 13px/16px Tahoma, verdana, sans-serif; MARGIN: 0px 0px 15px">На сегодняшний день ЗЕНОН объединяет более 40 филиалов и представительств в разных регионах нашей страны. И в каждом на регулярной основе проводятся масштабные события - <b>семинары, мастер-классы, дни открытых дверей и т.д.</b>, с участием ведущих руководителей направлений товарных групп, а также приглашенных представителей наших основных западных поставщиков. Помимо крупных мероприятий, мы проводим и так называемые <b>мини-семинары</b>, которые фактически являются индивидуальными встречами, направленными на обучение и обсуждение персональных вопросов и нужд наших клиентов. </p>
<p style="COLOR: #383838; FONT: 13px/16px Tahoma, verdana, sans-serif; MARGIN: 0px 0px 15px">Мы готовы делиться с Вами своими знаниями и огромным, годами наработанным, опытом. А в ответ с удовольствием получаем вашу неизменную заинтересованность и активность во время наших встреч. </p>
<p style="COLOR: #383838; FONT: 13px/16px Tahoma, verdana, sans-serif; MARGIN: 0px 0px 15px">Настало время объединить все обучающие направления нашей деятельности и в наступающем 2018 году представить вам новый бренд: </p>
<div style="TEXT-ALIGN: center"><img style="BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px; BORDER-LEFT: 0px" alt="" src="/images/articles/10717.png" width="220" height="158"> </div>
<p style="COLOR: #383838; FONT: 13px/16px Tahoma, verdana, sans-serif; MARGIN: 15px 0px"><b>ЗЕНОН АКАДЕМИЯ</b> - это вся семинарская и консультационная деятельность компании ЗЕНОН, включающая <b>Теорию, Практику и Индивидуальный подход</b> в работе с действующими и потенциальными партнерами. </p>
<p style="COLOR: #383838; FONT: 13px/16px Tahoma, verdana, sans-serif; MARGIN: 0px 0px 15px">Разумеется, деление на Теорию, Практику и Индивидуальный подход весьма условно! Ведь каждая наша встреча - это синтез общего освещения товарного ассортимента, новинок, последних тенденций на рынке производства наружной рекламы, а также интересной "живой" работы с материалами и оборудованием с раскрытием технологических секретов и нюансов. И, конечно, ценнейшая составляющая - это ваше непосредственное участие и прямой контакт с нашими специалистами. </p>
<p style="COLOR: #383838; FONT: 13px/16px Tahoma, verdana, sans-serif; MARGIN: 0px 0px 15px">Символом АКАДЕМИИ стало дерево, которое, как и наша компания, находится в процессе постоянного роста, изменения и развития, сохраняя стабильность и устойчивость ко всем внешним воздействиям. <b>Приглашаем развиваться вместе с нами!</b> </p>
<p style="COLOR: #383838; FONT: 13px/16px Tahoma, verdana, sans-serif; MARGIN: 0px 0px 15px">Напоминаем, что <b>занятия в нашей ЗЕНОН АКАДЕМИИ все еще абсолютно бесплатны!</b> </p>
<p style="COLOR: #383838; FONT: 13px/16px Tahoma, verdana, sans-serif; MARGIN: 0px">Ждите анонсов наших мероприятий на 2018 год в новом едином формате ЗЕНОН АКАДЕМИИ! </p>
<div style="PADDING-BOTTOM: 10px; PADDING-TOP: 30px; FONT: 13px/16px Tahoma, Verdana, sans-serif; PADDING-LEFT: 0px; PADDING-RIGHT: 0px">
<div style="BORDER-TOP: #383838 1px solid; COLOR: #383838; PADDING-BOTTOM: 10px; PADDING-TOP: 20px; FONT: bold 13px/15px Tahoma, Verdana, sans-serif; PADDING-LEFT: 0px; PADDING-RIGHT: 0px">Все проекты ЗЕНОНа:</div><noindex>
<table style="BORDER-COLLAPSE: collapse; TEXT-ALIGN: left; BORDER-SPACING: 0" width="590" border="0">
<tbody>
<tr>
<td style="VERTICAL-ALIGN: top; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; FONT: 13px/16px Tahoma, Verdana, sans-serif; PADDING-LEFT: 0px; PADDING-RIGHT: 0px" width="50%">
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://zeon-land.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Рекламное оборудование Roland DG</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.dgi-net.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Рекламное оборудование DGI</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.zeon-net.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Рекламное оборудование Zeon</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://dilli.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Широкоформатные принтеры Dilli</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.vivid-print.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Сувенирные принтеры VIVID</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.vinyls.su/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Самоклеящиеся плёнки для рекламы</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.inks.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Чернила для широкоформатной печати</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.neo-neon.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Декоративная светотехника</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.zenosvet.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Рекламная светотехника</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.led-lamp.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Светодиодные системы</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.neon-neon.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Неоновые технологии и материалы</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.screenprint.su/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Шелкотрафаретные технологии</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.textiller.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Одежда для маркировки</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.termotransfer.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Термотрансферные технологии</a></div></td>
<td style="VERTICAL-ALIGN: top; PADDING-BOTTOM: 0px; PADDING-TOP: 0px; FONT: 13px/16px Tahoma, Verdana, sans-serif; PADDING-LEFT: 0px; PADDING-RIGHT: 0px">
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.sheets.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Листовые материалы</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.zenobond.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Алюминиевые композитные сэндвич-панели</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.zenobaner.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Рулонные материалы для струйной печати</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.zenoprofil.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Алюминиевые и пластиковые профили</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.standshop.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Мобильные выставочные системы JUST</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.markbric.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Мобильные выставочные системы MARKBRIC</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.pos-torg.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Материалы для оформления места продаж</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.glues.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Клеевые и монтажные технологии</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.coating.su/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Аэрозольные лаки и краски</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.cut-cut.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Профессиональный инструмент для раскроя</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.dist.su/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Держатели и подвесные системы</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.zenotools.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Оборудование и металлофурнитура</a></div>
<div style="PADDING-BOTTOM: 5px"><a style="COLOR: #008080; TEXT-DECORATION: none" href="http://www.signtool.ru/?utm_source=sendingEmail&amp;utm_content=2511" rel="nofollow" target="_blank">Инструменты FESTOOL</a></div></td></tr></tbody></table></noindex></div></div>

'
regex = '<img style="BORDER-TOP: 0px; BORDER-RIGHT: 0px; BORDER-BOTTOM: 0px; BORDER-LEFT: 0px" alt="" src="/images/articles/10716.jpg" width="590" height="275">'
regex = /<img .*?(?:src="(.*?)")|(?:src='(.*?)')/i
b = a.scan(regex)

print 'b: '.red; puts b
print 'b: '.red; puts b.flatten.inspect


# Замена по регулярке
puts 'Замена по регулярке'.green
ap "foo".gsub(/(o+)/, '\1\1\1')
a = '$asd'
b = a.gsub(/^\$/, '_')
print 'a: '.red; puts a
print 'b: '.red; puts b

a = 'rewrite /production/ajerozolnye-pokrytija-special.html /cat/aerozolnye-kraski-i-laki permanent;'
b = a[/^(rewrite\s+\S+)\s/i, 1] rescue ''
print 'a: '.red; puts a
print 'b: '.red; puts b

# yes|no
a = 'Yes'
yn = (a =~ /^y(?:es)?$/i) != nil
print 'yn: '.red; puts yn
