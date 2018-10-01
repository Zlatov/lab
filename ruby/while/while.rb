# encoding: UTF-8
require 'rubygems'
require 'awesome_print'

i = 1
while i < 1 do
  i += 1
  print 'i: '.red; puts i
end

i = 1
begin
  i += 1
  print 'i: '.red; puts i
end while i < 1
exit 0
