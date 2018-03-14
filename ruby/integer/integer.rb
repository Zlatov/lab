# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

puts -1.class
puts Integer.class

a = 1
puts a.is_a?(Integer)
a = 1.1
puts a.is_a?(Integer)

a = '%g'
puts a % 0
puts a % 0.001
puts a % 0.01
puts a % 0.1

puts a % 1
puts a % 1.001
puts a % 1.01
puts a % 1.1

puts a % 10
puts a % 10.001
puts a % 10.01
puts a % 10.1

puts a % 100
puts a % 100.001
puts a % 100.01
puts a % 100.1

puts "#{'%g' % 5.0000}"
puts ("%.2f" % 12000000.549)
puts ("%.2f" % 12000000.00)
puts ("%.2f" % 12000000)

for price in [99, 99.00, 99.99, 99.888, 99.999, 9999999, 9999999.00, 9999999.99, 9999999.888, 9999999.999]
  price_with_pennies = "%.2f" % price
  pennies = price_with_pennies.slice(-2, 2)
  formated_price = if pennies == '00'
    price_with_pennies.slice 0, price_with_pennies.length-3
  else
    price_with_pennies
  end
  print 'formated_price: '.red; puts formated_price
end

amt = 3
sale = 0.0
percentage = (amt/sale)*100
case true
when percentage == 0
  quant = 0
when percentage <= 25
  quant = 1
when percentage <= 75
  quant = 2
else
  quant = 3
end

print 'quant: '.red; puts quant


puts '--------------------------------'
# g limits the number of displayed digits
ap "%.2g" % 1.234 # => 1.2
ap "%.2g" % 123 # => 1.2e+02
ap "%g" % 1000000000 # => 1e+09

# combined
ap "%g" % ("%.2f" % 2) #=> 2
ap "%g" % ("%.2f" % 2.50) #=> 2.5
ap "%g" % ("%.2f" % 12.543) #=> 12.54

# specifying how many digits to display (6 is default)
ap "%g" % ("%.2f" % 9999.99) #=> 9999.99
ap "%g" % ("%.2f" % 99999.99) #=> 100000
ap "%.3g" % ("%.2f" % 11.45) #=> 99999.99
ap "%.3g" % ("%.2f" % 13.99) #=> 14
ap "%.3g" % ("%.2f" % 13.49) #=> 13.5
ap "%.3g" % ("%.2f" % 13.45) #=> 13.4 woot?!

# В строку вмещается 16 символов для "наличия"
# в числе может встречаться точка (-1)
# в числе которое нельзя округлить будет встречаться e+16 (-4)
# итого -5
def number_to_human number
  "%.11g" % ("%.11f" % number)
end

puts '--------------------------------'
[
  1234567890123456,
  1.234567890123456,
  12345678901234567,
  1.2345678901234567,
  0.0001,
  1000.01,
  1000.000000000009,
  1000.0000000000009,
].each do |n|
  ap number_to_human n
end
