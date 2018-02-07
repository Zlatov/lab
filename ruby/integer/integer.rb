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
