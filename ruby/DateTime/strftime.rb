require 'active_support/time'
require 'awesome_print'
require 'date'

a = DateTime.new(2001,2,3,4,5,6,'+0100')
b = a.strftime '%F %T %:z'
print 'a: '.red; puts a
print 'b: '.red; puts b
