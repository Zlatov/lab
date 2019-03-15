require 'awesome_print'

a = 0b11111111
b = a + 1
c = a + 1 & 255
print 'a: '.red; puts "%b"%a
print 'b: '.red; puts b
print 'b: '.red; puts "%b"%b
print 'c: '.red; puts "%b"%c

a = 0b11111111
b = a << 1
c = a << 1 & 255
print 'a: '.red; puts "%b"%a
print 'b: '.red; puts b
print 'b: '.red; puts "%b"%b
print 'c: '.red; puts "%b"%c
