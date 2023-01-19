require 'awesome_print'

a = <<-HTML

Lorem ipsum http://ya.ru dolor sit, amet consectetur adipisicing elit https://ya.ru. Perferendis reprehenderit maiores qui quos beatae odit eveniet https://mail.ru rerum nostrum doloremque hic voluptas ipsam dolores in http://google.com, vel dolorem eaque earum numquam eligendi.

Lorem ipsum http://ya.ru; dolor sit, amet consectetur adipisicing elit
https://ya.ru. Perferendis reprehenderit maiores qui quos beatae odit eveniet
https://mail.ru: rerum nostrum doloremque hic voluptas ipsam dolores in
http://google.com, vel dolorem eaque earum numquam eligendi.

HTML

b = a =~ /http:\/\/\s+/
b = a.scan(/http[s]?:\/\/[\S]+(?:[.,?!:;]?\b)/).to_a
c = a.gsub(/http[s]?:\/\/[\S]+(?:[.,?!:;]?\b)/){|url| "<a href=\"#{url}\">#{url}</a>"}
print 'b: '.red; p b
print 'c: '.red; puts c



# b = gsub(/http:\/\//){}

