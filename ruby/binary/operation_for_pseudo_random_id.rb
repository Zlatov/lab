#!/usr/bin/env ruby
require 'awesome_print'

class Integer

  def permutation a_position, b_position
    a_index = a_position - 1
    b_index = b_position - 1
    a_mask = 1 << a_index
    b_mask = 1 << b_index
    i = self
    i_without_bit = i & ~a_mask & ~b_mask
    a = (i & a_mask) >> a_index
    b = (i & b_mask) >> b_index
    a_to_b = a << b_index
    b_to_a = b << a_index
    i_without_bit | a_to_b | b_to_a
  end
end

a = 0b1111111111111111
print 'a: '
puts a

inversion_mask = 0b1010101010101010
# 16, 1
# 15, 3
# 14, 5
# 13, 7
# 12, 9
for i in 0..a
  print " % 6d" % i
  print " %016b" % i

  print ' Инверсия бит'
  i = i ^ inversion_mask
  print " %016b" % i

  print ' Перестановка бит'
  i = i.permutation 16, 1
  i = i.permutation 15, 3
  i = i.permutation 14, 5
  i = i.permutation 13, 7
  i = i.permutation 13, 9
  print " %016b" % i

  print " % 6d" % i

  print ' Обратно'
  i = i.permutation 13, 9
  i = i.permutation 13, 7
  i = i.permutation 14, 5
  i = i.permutation 15, 3
  i = i.permutation 16, 1
  i = i ^ inversion_mask

  print " % 6d" % i

  puts "\n"
end
