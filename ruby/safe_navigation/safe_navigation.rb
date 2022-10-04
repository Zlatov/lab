# encoding: UTF-8
require 'awesome_print'
require 'active_support/all'

a = {}
b = a&.[]('asd')&.[]('asd')
print 'b: '.red; p b

a = Array.to_s
print 'a: '.red; p a
b = 1&.asd
print 'b: '.red; p b
