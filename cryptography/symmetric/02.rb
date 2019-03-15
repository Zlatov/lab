require 'awesome_print'

DELTA = 1
data = "Aa"
data.force_encoding('ASCII-8BIT')
bytes = data.bytes
print 'bytes: '.red; p bytes
sum = 0
x1, x2 = bytes
64.times do |i|

  sum = sum + DELTA
  x1 = x1 + ( x2 << 4 ^ x2 + sum ^ x2 >> 5 ) & 255
  x2 = x2 + ( x1 << 4 ^ x1 + sum ^ x1 >> 5 ) & 255

end
new_bytes = [x1, x2]
print 'new_bytes: '.red; p new_bytes

x1, x2 = new_bytes
64.times do |i|

  x2 = x2 - ( x1 << 4 ^ x1 + sum ^ x1 >> 5 ) & 255
  x1 = x1 - ( x2 << 4 ^ x2 + sum ^ x2 >> 5 ) & 255
  sum = sum - DELTA

end

old_bytes = [x1, x2]
print 'old_bytes: '.red; p old_bytes
exit
