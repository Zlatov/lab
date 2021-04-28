require 'awesome_print'

puts 'Форматирование целочисленных значений.'.green
#   b   | Как двоичное. Отрицательное - префикс 1.
#   B   | Как двоичное. Отрицательное - префикс 0B в альтернативном форматировании (#).
a = -7
b = sprintf "%#B", a
print 'b: '.red; puts b
#   d   | Как десятеричное.
#   i   | Как десятеричное.
#   o   | Восьмеричное. Отрицательное - как дополнительный код.
a = -2
b = sprintf "%o", a
print 'b: '.red; puts b
#   u   | Как десятеричное.
#   x   | Шестнадцатеричное.
#   X   | Шестнадцатеричное, буквы в верхнем регистре.
a = -15
b = sprintf "%X", a
print 'b: '.red; puts b

puts 'Форматирование значений с плавающей точкой.'.green
#   e   | Convert floating point argument into exponential notation
#       | with one digit before the decimal point as [-]d.dddddde[+-]dd.
#       | The precision specifies the number of digits after the decimal
#       | point (defaulting to six).
#   E   | Equivalent to `e', but uses an uppercase E to indicate
#       | the exponent.
#   f   | Convert floating point argument as [-]ddd.dddddd,
#       | where the precision specifies the number of digits after
#       | the decimal point.
#   g   | Convert a floating point number using exponential form
#       | if the exponent is less than -4 or greater than or
#       | equal to the precision, or in dd.dddd form otherwise.
#       | The precision specifies the number of significant digits.
#   G   | Equivalent to `g', but use an uppercase `E' in exponent form.
#   a   | Convert floating point argument as [-]0xh.hhhhp[+-]dd,
#       | which is consisted from optional sign, "0x", fraction part
#       | as hexadecimal, "p", and exponential part as decimal.
#   A   | Equivalent to `a', but use uppercase `X' and `P'.
numbers = [
  0,
  0.0,
  0.001,
  0.0001,
  0.00001,
  0.000001,
  0.999999,
  1,
  1.0,
  1.01,
  1.000001
]
numbers.each do |x|
  print "#{x.to_s} ".red; puts '%g' % x
end
# exit

# Field |  Other Format
# ------+--------------------------------------------------------------
#   c   | Argument is the numeric code for a single character or
#       | a single character string itself.
#   p   | The valuing of argument.inspect.
#   s   | Argument is a string to be substituted.  If the format
#       | sequence contains a precision, at most that many characters
#       | will be copied.
#   %   | A percent sign itself will be displayed.  No argument taken.

# Flag     | Applies to    | Meaning
# ---------+---------------+-----------------------------------------
# space    | bBdiouxX      | Leave a space at the start of
#          | aAeEfgG       | non-negative numbers.
#          | (numeric fmt) | For `o', `x', `X', `b' and `B', use
#          |               | a minus sign with absolute value for
#          |               | negative values.
# ---------+---------------+-----------------------------------------
# (digit)$ | all           | Specifies the absolute argument number
#          |               | for this field.  Absolute and relative
#          |               | argument numbers cannot be mixed in a
#          |               | sprintf string.
# ---------+---------------+-----------------------------------------
#  #       | bBoxX         | Use an alternative format.
#          | aAeEfgG       | For the conversions `o', increase the precision
#          |               | until the first digit will be `0' if
#          |               | it is not formatted as complements.
#          |               | For the conversions `x', `X', `b' and `B'
#          |               | on non-zero, prefix the result with ``0x'',
#          |               | ``0X'', ``0b'' and ``0B'', respectively.
#          |               | For `a', `A', `e', `E', `f', `g', and 'G',
#          |               | force a decimal point to be added,
#          |               | even if no digits follow.
#          |               | For `g' and 'G', do not remove trailing zeros.
# ---------+---------------+-----------------------------------------
# +        | bBdiouxX      | Add a leading plus sign to non-negative
#          | aAeEfgG       | numbers.
#          | (numeric fmt) | For `o', `x', `X', `b' and `B', use
#          |               | a minus sign with absolute value for
#          |               | negative values.
# ---------+---------------+-----------------------------------------
# -        | all           | Left-justify the result of this conversion.
# ---------+---------------+-----------------------------------------
# 0 (zero) | bBdiouxX      | Pad with zeros, not spaces.
#          | aAeEfgG       | For `o', `x', `X', `b' and `B', radix-1
#          | (numeric fmt) | is used for negative numbers formatted as
#          |               | complements.
# ---------+---------------+-----------------------------------------
# *        | all           | Use the next argument as the field width.
#          |               | If negative, left-justify the result. If the
#          |               | asterisk is followed by a number and a dollar
#          |               | sign, use the indicated argument as the width.

puts "%g" % 1
puts "%g" % 1.0
puts "%g" % 1.1
puts "%g" % 1.6
puts "%g" % 1.006
puts "%.3g" % 1.006

