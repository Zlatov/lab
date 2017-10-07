# encoding: UTF-8
require_relative '../colorize/colorize'
require 'digest'

require 'rubygems'
require 'russian'

def for_file_name string
  md5 = Digest::MD5.hexdigest(string).slice 0, 4
  string.gsub! ' ', '-'
  string.gsub! /[^a-z0-9_-]/i, '_'
  string + md5
end
a = 'Ваще "***"! 百度腾讯'
b = Russian.translit a
c = for_file_name Russian.translit(b)
print 'a: '.red; puts a
print 'b: '.red; puts b
print 'c: '.red; puts c
