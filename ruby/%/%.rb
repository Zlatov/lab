require 'awesome_print'

# q - многострочный текст
# w - массивы строк
# i - массивы символов

asd = 'zxc'

puts 'Строки'.green

puts '%Q() - как в двойных кавычках'.blue
a = %Q(
  123
  фыв
  #{asd}
)
print 'a: '.red; puts a

puts '%() - аналог %Q()'.blue
a = %(
  123
  фыв
  #{asd}
)
print 'a: '.red; puts a

puts '%q() - как в одинарных кавычках'.blue
a = %q(
  123
  фыв
  #{asd}
)
print 'a: '.red; puts a

puts 'Массивы'.green

puts '%w() - массив строк'.blue
a = %w(
  123
  фыв
  #{asd}
)
print 'a: '.red; p a

puts '%W() - массив строк'.blue
a = %W(
  123
  фыв
  #{asd}
)
print 'a: '.red; p a

puts '%i() - массив символов'.blue
a = %i(
  123
  фыв
  #{asd}
)
print 'a: '.red; p a

puts '%I() - массив символов'.blue
a = %I(
  123
  фыв
  #{asd}
)
print 'a: '.red; p a

puts '%r() - regular expression'.blue
puts '%s() - symbol'.blue
