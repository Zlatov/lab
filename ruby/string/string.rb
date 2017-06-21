p "date".slice 0, 2

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


p "1,2,3,4".split(",") # ["1", "2", "3", "4"]
