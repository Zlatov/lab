# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

a = 1.016
b = sprintf("%#.2f", a)
print 'b: '.red; puts b
# exit

a = 100000
b = 6
c = b.to_f / a.to_f * 100
d = sprintf "%#.2f", c
print 'c: '.red; puts c
print 'd: '.red; puts d
# exit

a = 1.01
ap a.is_a? Float
ap a.is_a? Integer
ap 1.to_f
ap 1.0001.to_f
ap nil.to_f
ap nil.nil?

def with_spaces number, by=3
  if number.is_a? Float
    parts = number.to_s.split('.')
    return parts[0].gsub(/\B(?=(\d{3})+(?!\d))/, ' ')+".#{parts[1]}"
  elsif number.is_a? Integer
    return number.to_s.gsub /\B(?=(\d{3})+(?!\d))/, ' '
  else
    return number
  end
end

def price amount, metric=nil, options={}
  options = {
    by: 3,
    with_spaces: true,
    with_pennies: true,
    with_double_zero_pennies: true,
    with_metric: false,
  }.merge! options
  amount = amount.to_f if amount.is_a? Integer
  if amount.is_a? Float
    parts = amount.to_s.split('.')
    string_integer = parts[0].gsub(/\B(?=(\d{3})+(?!\d))/, ' ')
    string_pennies = parts[1].slice(0, 2).ljust(2, '0')
    return "#{string_integer}.#{string_pennies}"
  else
    return amount
  end
end

a = [
  1,11,111,1111,11111,111111,1111111,
  1.0,11.0,111.0,1111.0,11111.0,111111.0,1111111.0,
  1.1,11.1,111.1,1111.1,11111.1,111111.1,1111111.1,
  1.00,11.00,111.00,1111.00,11111.00,111111.00,1111111.00,
  1.01,11.01,111.01,1111.01,11111.01,111111.01,1111111.01,
  1.001,11.001,111.001,1111.001,11111.001,111111.001,1111111.001,
]
a.each do |b|
  c = price b
  print 'b: '.red; print "#{b}".rjust(11); print ' c: '.red; puts c
end
