# encoding: UTF-8
require 'rubygems'
require 'awesome_print'
# require 'active_support/all'
require 'action_view'
include ActionView::Helpers::NumberHelper


a = 20.95
b = a * 3
c = b.round 2
d = (b * 10**2).round.to_f / 10**2
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'd: '.red; puts d
# exit

a = 1.016
b = sprintf("%#.2f", a)
print 'b: '.red; puts b
# exit

a = 1.1
b = sprintf("%#.2f", a)
print 'b: '.red; puts b
# exit

puts 'Тип'.green
a = 1.01
ap a.is_a? Float
ap a.is_a? Integer
ap 1.to_f
ap 1.0001.to_f
ap nil.to_f
ap nil.nil?
# exit

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
  1.009,11.009,111.009,1111.009,11111.009,111111.009,1111111.009,
]
a.each do |b|
  c = price b
  print 'b: '.red; print "#{b}".rjust(11); print ' c: '.red; puts c
end

puts 'Прогресс'.green
row_count = 837
index = 356
progress = (index.to_f * 100 / row_count).round(4)
print 'progress: '.red; puts progress
progress = (index * 100 / row_count).floor
print 'progress: '.red; puts progress
# exit 0

puts '.floor(до какого знака) - округляет в меньшую сторону'.green
print '1.99.floor: '.red; puts 1.99.floor
print '1.5.floor(0): '.red; puts 1.5.floor(0)
print '1.99.floor(1): '.red; puts 1.99.floor(1)
puts '.ceil - округляет в большую сторону'.green
print '1.1.ceil: '.red; puts 1.1.ceil
print '1.4.ceil: '.red; puts 1.4.ceil
print '1.5.ceil: '.red; puts 1.5.ceil
print '-1.5.ceil: '.red; puts -1.5.ceil
print '1.ceil: '.red; puts 1.ceil
# exit 0


puts 'Форматирование флоат числа; Формат %.5f возвращает строку с нулями, а number_with_precision без, чего-то среднего (0.0) нет.'.green
a = 0.000005
a = 0.000004
b = a.to_s
c = '%.5f' % a
d = number_with_precision a, precision: 5, strip_insignificant_zeros: true
print 'b: '.red; puts b
print 'c: '.red; puts c
print 'd: '.red; puts d
