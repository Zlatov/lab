# encoding: UTF-8
require 'rubygems'
require 'awesome_print'
require 'date'

a = DateTime.new()
print 'a: '.red; puts a
a = DateTime.new(2001,2,3,4,5,6)
print 'a: '.red; puts a

a = Time.now
print 'a: '.red; puts a.to_s
print 'a.strftime("%m/%d/%Y"): '.red; puts a.strftime("%m/%d/%Y")
