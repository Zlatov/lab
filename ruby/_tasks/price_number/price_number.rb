# encoding: UTF-8
require 'awesome_print'

def price_number price
  price = price.to_f.round(2)
  parts = sprintf("%.2f", price).split('.')
  integer = parts[0].gsub(/\B(?=(\d{3})+(?!\d))/, ' ')
  fractional = parts[1]
  "<span class=\"price-numeric\">#{integer} <span> #{fractional}</span></span>"
end

for price in [1,1.0,10.009,1222.004]
  a = price_number price
  print 'a: '.red; puts a
end
