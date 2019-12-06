require 'awesome_print'

a = 0b0011
b = 0b0101
c = a & b # AND 0001
d = a | b # OR  0111
e = a ^ b # XOR 0110
f = a << 1
g = a >> 1
print 'a: '.red; print a; puts " (%04b)" % a
print 'b: '.red; print b; puts " (%04b)" % b
print 'c: '.red; print c; puts " (%04b)" % c
print 'd: '.red; print d; puts " (%04b)" % d
print 'e: '.red; print e; puts " (%04b)" % e
print 'f: '.red; print f; puts " (%04b)" % f
print 'g: '.red; print g; puts " (%04b)" % g

# Приоритет
# ~
# * / %
# + -
# >> <<
# &
# ^ |
